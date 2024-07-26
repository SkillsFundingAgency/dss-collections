using DFC.Common.Standard.Logging;
using DFC.HTTP.Standard;
using DFC.JSON.Standard;
using DFC.Swagger.Standard.Annotations;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.PostCollectionHttpTrigger.Service;
using NCS.DSS.Collections.Validators;
using Newtonsoft.Json;
using System;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Microsoft.Azure.Functions.Worker;

namespace NCS.DSS.Collections.PostCollectionHttpTrigger.Function
{
    public class PostCollectionHttpTrigger
    {
        private IHttpRequestHelper _httpRequestHelper;
        private IPostCollectionHttpTriggerService _service;
        private IDssCorrelationValidator _dssCorrelationValidator;
        private IDssTouchpointValidator _dssTouchpointValidator;
        private ILogger<PostCollectionHttpTrigger> _logger;
        private IJsonHelper _jsonHelper;
        private IApimUrlValidator _apimUrlValidator;

        public PostCollectionHttpTrigger(IPostCollectionHttpTriggerService service, ILogger<PostCollectionHttpTrigger> logger, IDssCorrelationValidator dssCorrelationValidator,
          IDssTouchpointValidator dssTouchpointValidator, IJsonHelper jsonHelper, IApimUrlValidator apimUrlValidator, IHttpRequestHelper httpRequestHelper)
        {
            _service = service;
            _jsonHelper = jsonHelper;
            _logger = logger;
            _dssCorrelationValidator = dssCorrelationValidator;
            _dssTouchpointValidator = dssTouchpointValidator;
            _apimUrlValidator = apimUrlValidator;
            _httpRequestHelper = httpRequestHelper;
        }

        [Function("Post")]
        [ProducesResponseType(typeof(Collection), (int)HttpStatusCode.Created)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Created, Description = "Collection Created", ShowSchema = true)]
        [Response(HttpStatusCode = (int)HttpStatusCode.NoContent, Description = "Collection does not exist", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.BadRequest, Description = "Request was malformed", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Unauthorized, Description = "API key is unknown or invalid", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Forbidden, Description = "Insufficient access", ShowSchema = false)]
        [Response(HttpStatusCode = 422, Description = "Collection validation error(s)", ShowSchema = false)]
        [Display(Name = "Post", Description = "Ability to create a new collection for a touchpoint.")]
        public async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "post", Route = "collections")] HttpRequest req)
        {

            var correlationId = _httpRequestHelper.GetDssCorrelationId(req);
            if (string.IsNullOrEmpty(correlationId))
                _logger.LogInformation("Unable to locate 'DssCorrelationId; in request header");

            if (!Guid.TryParse(correlationId, out var correlationGuid))
            {
                _logger.LogInformation("Unable to Parse 'DssCorrelationId' to a Guid");
                correlationGuid = Guid.NewGuid();
            }

            var touchpointId = _httpRequestHelper.GetDssTouchpointId(req);
            if (string.IsNullOrEmpty(touchpointId))
            {
                _logger.LogInformation("Unable to locate 'APIM-TouchpointId' in request header.");
                return new BadRequestResult();
            }

            var apimUrl = _httpRequestHelper.GetDssApimUrl(req);
            if (string.IsNullOrEmpty(apimUrl))
            {
                _logger.LogInformation("Unable to locate 'apimurl' in request header");
                return new BadRequestResult();
            }

            if (string.IsNullOrEmpty(touchpointId) || string.IsNullOrEmpty(apimUrl))
                return new BadRequestResult();

            Collection collection;

            try
            {
                _logger.LogInformation ("Attempt to get resource from body of the request");
                collection = await _httpRequestHelper.GetResourceFromRequest<Collection>(req);               
            }
            catch (JsonException ex)
            {
                _logger.LogError( "Unable to retrieve body from req", ex);
                return new UnprocessableEntityObjectResult(ex.Message);
            }

            collection.TouchPointId = touchpointId;

            if (!collection.LastModifiedDate.HasValue)
                collection.LastModifiedDate = DateTime.UtcNow;

            var validationResults = _service.ValidateCollectionAsync(collection);

            if (validationResults != null && validationResults.Any())
            {
                _logger.LogInformation("validation errors with resource");
                return new UnprocessableEntityObjectResult(validationResults);
            }

            _logger.LogInformation(string.Format("Attempting to get Create Collection for Touchpoint {0}", touchpointId));
            var createdCollection = await _service.ProcessRequestAsync(collection, apimUrl);

            if (createdCollection != null)
            {
                _logger.LogInformation(string.Format("attempting to send to service bus {0}", createdCollection.CollectionId));
                await _service.SendToServiceBusQueueAsync(createdCollection);
            }

            return createdCollection == null ?
                new BadRequestResult() :
                new ObjectResult(_jsonHelper.SerializeObjectAndRenameIdProperty(createdCollection, "id", "CollectionId")) { StatusCode = (int)HttpStatusCode.Created};
        }
    }
}