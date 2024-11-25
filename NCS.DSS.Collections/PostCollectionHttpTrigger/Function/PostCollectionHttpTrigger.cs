using DFC.HTTP.Standard;
using DFC.Swagger.Standard.Annotations;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Cosmos.Helper;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.PostCollectionHttpTrigger.Service;
using System.ComponentModel.DataAnnotations;
using System.Net;
using System.Text.Json;

namespace NCS.DSS.Collections.PostCollectionHttpTrigger.Function
{
    public class PostCollectionHttpTrigger
    {
        private readonly IHttpRequestHelper _httpRequestHelper;
        private readonly IPostCollectionHttpTriggerService _service;
        private readonly ILogger<PostCollectionHttpTrigger> _logger;
        private readonly IDynamicHelper _dynamicHelper;
        private static readonly string[] PropertyToExclude = { "TargetSite" };

        public PostCollectionHttpTrigger(IPostCollectionHttpTriggerService service, ILogger<PostCollectionHttpTrigger> logger, IHttpRequestHelper httpRequestHelper, IDynamicHelper dynamicHelper)
        {
            _service = service;
            _logger = logger;
            _httpRequestHelper = httpRequestHelper;
            _dynamicHelper = dynamicHelper;
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
            {
                _logger.LogInformation("Unable to locate 'DssCorrelationId; in request header");
            }

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
            {
                return new BadRequestResult();
            }

            Collection collection;

            try
            {
                _logger.LogInformation("Attempt to get resource from body of the request");
                collection = await _httpRequestHelper.GetResourceFromRequest<Collection>(req);
            }
            catch (JsonException ex)
            {
                _logger.LogError("Unable to retrieve body from req - {0}", ex);
                return new UnprocessableEntityObjectResult(_dynamicHelper.ExcludeProperty(ex, PropertyToExclude));
            }

            collection.TouchPointId = touchpointId;

            if (!collection.LastModifiedDate.HasValue)
            {
                collection.LastModifiedDate = DateTime.UtcNow;
            }

            var validationResults = _service.ValidateCollectionAsync(collection);

            if (validationResults != null && validationResults.Any())
            {
                _logger.LogInformation("validation errors with resource");
                return new UnprocessableEntityObjectResult(validationResults);
            }

            _logger.LogInformation(string.Format("Attempting to create Collection for Touchpoint {0}", touchpointId));
            var createdCollection = await _service.ProcessRequestAsync(collection, apimUrl);

            if (createdCollection != null)
            {
                _logger.LogInformation(string.Format("attempting to send to service bus {0}", createdCollection.CollectionId));
                await _service.SendToServiceBusQueueAsync(createdCollection);
                _logger.LogInformation(string.Format("Newly created collection message sent to service bus successfully"));
            }

            return createdCollection == null ?
                new BadRequestResult() :
                new JsonResult(createdCollection, new JsonSerializerOptions()) { StatusCode = (int)HttpStatusCode.Created };
        }
    }
}