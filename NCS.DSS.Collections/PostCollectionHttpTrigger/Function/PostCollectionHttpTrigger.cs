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

        [Function("POST")]
        [ProducesResponseType(typeof(Collection), (int)HttpStatusCode.Created)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Created, Description = "Collection Created", ShowSchema = true)]
        [Response(HttpStatusCode = (int)HttpStatusCode.NoContent, Description = "Collection does not exist", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.BadRequest, Description = "Request was malformed", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Unauthorized, Description = "API key is unknown or invalid", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Forbidden, Description = "Insufficient access", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.UnprocessableEntity, Description = "Collection validation error(s)", ShowSchema = false)]
        [Display(Name = "POST", Description = "Ability to create a new collection for a touchpoint.")]
        public async Task<IActionResult> RunAsync(
            [HttpTrigger(AuthorizationLevel.Anonymous, "post", Route = "collections")] HttpRequest req)
        {
            _logger.LogInformation("Function {FunctionName} has been invoked", nameof(PostCollectionHttpTrigger));

            var correlationId = _httpRequestHelper.GetDssCorrelationId(req);
            if (string.IsNullOrEmpty(correlationId))
            {
                _logger.LogInformation("Unable to locate 'DssCorrelationId' in request header");
            }

            if (!Guid.TryParse(correlationId, out var correlationGuid))
            {
                _logger.LogInformation("Unable to parse 'DssCorrelationId' to a Guid");
                correlationGuid = Guid.NewGuid();
            }

            var touchpointId = _httpRequestHelper.GetDssTouchpointId(req);
            if (string.IsNullOrEmpty(touchpointId))
            {
                _logger.LogWarning("Unable to locate 'TouchpointId' in request header. Correlation GUID: {CorrelationGuid}", correlationGuid);
                return new BadRequestResult();
            }

            var apimUrl = _httpRequestHelper.GetDssApimUrl(req);
            if (string.IsNullOrEmpty(apimUrl))
            {
                _logger.LogWarning("Unable to locate 'apimURL' in request header. Correlation GUID: {CorrelationGuid}", correlationGuid);
                return new BadRequestResult();
            }

            _logger.LogInformation("Header validation has succeeded. Touchpoint ID: {TouchpointId}. Correlation GUID: {CorrelationGuid}", touchpointId, correlationGuid);

            Collection collection;
            try
            {
                _logger.LogInformation("Attempt to retrieve resource from the request body. Correlation GUID: {CorrelationGuid}", correlationGuid);
                collection = await _httpRequestHelper.GetResourceFromRequest<Collection>(req);
            }
            catch (JsonException ex)
            {
                _logger.LogError(ex, "Unable to parse Collection from request body. Exception: {ErrorMessage}", ex.Message);
                return new UnprocessableEntityObjectResult(_dynamicHelper.ExcludeProperty(ex, PropertyToExclude));
            }

            _logger.LogInformation("Retrieved resource from request body. Correlation GUID: {CorrelationGuid}", correlationGuid);

            collection.TouchPointId = touchpointId;

            if (!collection.LastModifiedDate.HasValue)
            {
                collection.LastModifiedDate = DateTime.UtcNow;
            }

            _logger.LogInformation("Attempting to validate {Collection} object. Correlation GUID: {CorrelationGuid}", nameof(collection), correlationGuid);
            var validationResults = _service.ValidateCollectionAsync(collection);

            if (validationResults != null && validationResults.Any())
            {
                _logger.LogWarning("Failed to validate {Collection} object. Correlation GUID: {CorrelationGuid}", nameof(collection), correlationGuid);
                return new UnprocessableEntityObjectResult(validationResults);
            }
            _logger.LogInformation("Successfully validated {Collection} object. Correlation GUID: {CorrelationGuid}", nameof(collection), correlationGuid);

            _logger.LogInformation("Attempting to create Collection object. Touchpoint ID: {TouchpointId}. Correlation GUID: {CorrelationGuid}", touchpointId, correlationGuid);
            var createdCollection = await _service.ProcessRequestAsync(collection, apimUrl);

            if (createdCollection == null)
            {
                _logger.LogWarning("Failed to create Collection object. Touchpoint ID: {TouchpointId}. Correlation GUID: {CorrelationGuid}", touchpointId, correlationGuid);
                return new BadRequestObjectResult(touchpointId);
            }

            _logger.LogInformation("Sending newly created Collection to service bus. Collection ID: {CollectionId}. Touchpoint ID: {TouchpointId}. Correlation GUID: {CorrelationGuid}", collection.CollectionId, touchpointId, correlationGuid);
            await _service.SendToServiceBusQueueAsync(createdCollection);

            _logger.LogInformation("POST request successful. Collection ID: {CollectionId}. Touchpoint ID: {TouchpointId}. Correlation GUID: {CorrelationGuid}", collection.CollectionId, touchpointId, correlationGuid);
            _logger.LogInformation("Function {FunctionName} has finished invoking", nameof(PostCollectionHttpTrigger));
            return new JsonResult(createdCollection, new JsonSerializerOptions()) { StatusCode = (int)HttpStatusCode.Created };
        }
    }
}