using DFC.Common.Standard.Logging;
using DFC.Functions.DI.Standard.Attributes;
using DFC.HTTP.Standard;
using DFC.JSON.Standard;
using DFC.Swagger.Standard.Annotations;
using Microsoft.AspNetCore.Http;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.PostCollectionHttpTrigger.Service;
using NCS.DSS.Collections.Validators;
using Newtonsoft.Json;
using System;
using System.ComponentModel.DataAnnotations;
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
            loggerHelper.LogMethodEnter(log);

            var correlationId = dssCorrelationValidator.Extract(req, log);

            var touchpointId = dssTouchpointValidator.Extract(req, log);                                  

            var ApimUrl = apimUrlValidator.Extract(req, log);

            if (string.IsNullOrEmpty(touchpointId) || string.IsNullOrEmpty(ApimUrl))
                return httpResponseMessageHelper.BadRequest();

            Collection collection;

            try
            {
                collection = await httpRequestHelper.GetResourceFromRequest<Collection>(req);

                collection.TouchPointId = touchpointId;

                if (!collection.LastModifiedDate.HasValue)
                    collection.LastModifiedDate = DateTime.UtcNow;

                var result = await service.ProcessRequestAsync(collection, ApimUrl);

                if (result == null)
                {
                    return httpResponseMessageHelper.BadRequest();
                }

                return httpResponseMessageHelper.Created(jsonHelper.SerializeObjectAndRenameIdProperty(result, "id", "CollectionId"));
            }
            catch (JsonException ex)
            {
                return httpResponseMessageHelper.UnprocessableEntity(ex);
            }            
        }
    }
}