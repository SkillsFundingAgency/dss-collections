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
    public class PostCollectionHttpTrigger
    {
        private IHttpRequestHelper _httpRequestHelper;
        private readonly IHttpResponseMessageHelper _httpResponseMessageHelper;
        private IPostCollectionHttpTriggerService _service;
        private IDssCorrelationValidator _dssCorrelationValidator;
        private IDssTouchpointValidator _dssTouchpointValidator;
        private ILoggerHelper _loggerHelper;
        private IJsonHelper _jsonHelper;
        private IApimUrlValidator _apimUrlValidator;

        public PostCollectionHttpTrigger(IPostCollectionHttpTriggerService service, IHttpResponseMessageHelper httpResponseMessageHelper, ILoggerHelper loggerHelper, IDssCorrelationValidator dssCorrelationValidator,
          IDssTouchpointValidator dssTouchpointValidator, IJsonHelper jsonHelper, IApimUrlValidator apimUrlValidator, IHttpRequestHelper httpRequestHelper)
        {
            _service = service;
            _httpResponseMessageHelper = httpResponseMessageHelper;
            _jsonHelper = jsonHelper;
            _loggerHelper = loggerHelper;
            _dssCorrelationValidator = dssCorrelationValidator;
            _dssTouchpointValidator = dssTouchpointValidator;
            _apimUrlValidator = apimUrlValidator;
            _httpRequestHelper = httpRequestHelper;
        }

        [FunctionName("Post")]
        [ProducesResponseType(typeof(Models.Collection), (int)HttpStatusCode.Created)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Created, Description = "Collection Created", ShowSchema = true)]
        [Response(HttpStatusCode = (int)HttpStatusCode.NoContent, Description = "Collection does not exist", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.BadRequest, Description = "Request was malformed", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Unauthorized, Description = "API key is unknown or invalid", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Forbidden, Description = "Insufficient access", ShowSchema = false)]
        [Response(HttpStatusCode = 422, Description = "Collection validation error(s)", ShowSchema = false)]
        [Display(Name = "Post", Description = "Ability to create a new collection for a touchpoint.")]
        public async Task<HttpResponseMessage> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "post", Route = "collections")] HttpRequest req,
            ILogger log)
        {

            var correlationId = _httpRequestHelper.GetDssCorrelationId(req);
            if (string.IsNullOrEmpty(correlationId))
                log.LogInformation("Unable to locate 'DssCorrelationId; in request header");

            if (!Guid.TryParse(correlationId, out var correlationGuid))
            {
                log.LogInformation("Unable to Parse 'DssCorrelationId' to a Guid");
                correlationGuid = Guid.NewGuid();
            }

            var touchpointId = _httpRequestHelper.GetDssTouchpointId(req);
            if (string.IsNullOrEmpty(touchpointId))
            {
                log.LogInformation("Unable to locate 'APIM-TouchpointId' in request header.");
                return _httpResponseMessageHelper.BadRequest();
            }

            var apimUrl = _httpRequestHelper.GetDssApimUrl(req);
            if (string.IsNullOrEmpty(apimUrl))
            {
                log.LogInformation("Unable to locate 'apimurl' in request header");
                return _httpResponseMessageHelper.BadRequest();
            }

            if (string.IsNullOrEmpty(touchpointId) || string.IsNullOrEmpty(apimUrl))
                return _httpResponseMessageHelper.BadRequest();

            Collection collection;

            try
            {
                _loggerHelper.LogInformationMessage(log, correlationGuid, "Attempt to get resource from body of the request");
                collection = await _httpRequestHelper.GetResourceFromRequest<Collection>(req);               
            }
            catch (JsonException ex)
            {
                _loggerHelper.LogError(log, correlationGuid, "Unable to retrieve body from req", ex);
                return _httpResponseMessageHelper.UnprocessableEntity(ex);
            }

            collection.TouchPointId = touchpointId;

            if (!collection.LastModifiedDate.HasValue)
                collection.LastModifiedDate = DateTime.UtcNow;

            var validationResults = _service.ValidateCollectionAsync(collection);

            if (validationResults != null && validationResults.Any())
            {
                _loggerHelper.LogInformationMessage(log, correlationGuid, "validation errors with resource");
                return _httpResponseMessageHelper.UnprocessableEntity(validationResults);
            }

            _loggerHelper.LogInformationMessage(log, correlationGuid, string.Format("Attempting to get Create Collection for Touchpoint {0}", touchpointId));
            var createdCollection = await _service.ProcessRequestAsync(collection, apimUrl);

            if (createdCollection != null)
            {
                _loggerHelper.LogInformationMessage(log, correlationGuid, string.Format("attempting to send to service bus {0}", createdCollection.CollectionId));
                await _service.SendToServiceBusQueueAsync(createdCollection);
            }

            return createdCollection == null ?
                _httpResponseMessageHelper.BadRequest() :
                _httpResponseMessageHelper.Created(_jsonHelper.SerializeObjectAndRenameIdProperty(createdCollection, "id", "CollectionId"));
        }
    }
}