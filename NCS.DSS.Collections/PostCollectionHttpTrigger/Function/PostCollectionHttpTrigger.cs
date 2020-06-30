using DFC.Common.Standard.Logging;
using DFC.Functions.DI.Standard.Attributes;
using DFC.HTTP.Standard;
using DFC.JSON.Standard;
using DFC.Swagger.Standard.Annotations;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.PostCollectionHttpTrigger.Service;
using NCS.DSS.Collections.Validators;
using Newtonsoft.Json;
using System;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.PostCollectionHttpTrigger.Function
{
    public static class PostCollectionHttpTrigger
    {
        [FunctionName("Post")]
        [Response(HttpStatusCode = (int)HttpStatusCode.Created, Description = "Collection Created", ShowSchema = true)]
        [Response(HttpStatusCode = (int)HttpStatusCode.NoContent, Description = "Collection does not exist", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.BadRequest, Description = "Request was malformed", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Unauthorized, Description = "API key is unknown or invalid", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Forbidden, Description = "Insufficient access", ShowSchema = false)]
        [Response(HttpStatusCode = 422, Description = "Collection validation error(s)", ShowSchema = false)]
        [Display(Name = "Post", Description = "Ability to create a new collection for a touchpoint.")]
        [ProducesResponseType(typeof(Models.Collection), (int)HttpStatusCode.OK)]
        [PostRequestBody(typeof(Models.Collection), "Request Body")]
        public static async Task<HttpResponseMessage> RunAsync(
            [HttpTrigger(AuthorizationLevel.Anonymous, "post", Route = "collections")] HttpRequest req,
            ILogger log,
            [Inject]IPostCollectionHttpTriggerService service,
            [Inject]IHttpRequestHelper httpRequestHelper,
            [Inject]IHttpResponseMessageHelper httpResponseMessageHelper,
            [Inject]IJsonHelper jsonHelper,
            [Inject]ILoggerHelper loggerHelper,
            [Inject]IDssCorrelationValidator dssCorrelationValidator,
            [Inject]IDssTouchpointValidator dssTouchpointValidator,
            [Inject]IApimUrlValidator apimUrlValidator)
        {

            var correlationId = dssCorrelationValidator.Extract(req, log);

            var touchpointId = dssTouchpointValidator.Extract(req, log);

            var apimUrl = apimUrlValidator.Extract(req, log);

            if (string.IsNullOrEmpty(touchpointId) || string.IsNullOrEmpty(apimUrl))
                return httpResponseMessageHelper.BadRequest();

            Collection collection;

            try
            {
                loggerHelper.LogInformationMessage(log, correlationId, "Attempt to get resource from body of the request");
                collection = await httpRequestHelper.GetResourceFromRequest<Collection>(req);
            }
            catch (JsonException ex)
            {
                loggerHelper.LogError(log, correlationId, "Unable to retrieve body from req", ex);
                return httpResponseMessageHelper.UnprocessableEntity(ex);
            }

            collection.TouchPointId = touchpointId;

            if (!collection.LastModifiedDate.HasValue)
                collection.LastModifiedDate = DateTime.UtcNow;

            var validationResults = service.ValidateCollectionAsync(collection);

            if (validationResults != null && validationResults.Any())
            {
                loggerHelper.LogInformationMessage(log, correlationId, "validation errors with resource");
                return httpResponseMessageHelper.UnprocessableEntity(validationResults);
            }

            loggerHelper.LogInformationMessage(log, correlationId, string.Format("Attempting to get Create Collection for Touchpoint {0}", touchpointId));
            var createdCollection = await service.ProcessRequestAsync(collection, apimUrl);

            if (createdCollection != null)
            {
                loggerHelper.LogInformationMessage(log, correlationId, string.Format("attempting to send to service bus {0}", createdCollection.CollectionId));
                await service.SendToServiceBusQueueAsync(createdCollection);
            }

            return createdCollection == null ?
                httpResponseMessageHelper.BadRequest() :
                httpResponseMessageHelper.Created(jsonHelper.SerializeObjectAndRenameIdProperty(createdCollection, "id", "CollectionId"));
        }
    }
}