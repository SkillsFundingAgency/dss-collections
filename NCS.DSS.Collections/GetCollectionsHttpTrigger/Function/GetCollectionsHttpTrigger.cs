using DFC.Swagger.Standard.Annotations;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.GetCollectionsHttpTrigger.Service;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.Validators;
using System.ComponentModel.DataAnnotations;
using System.Net;
using System.Text.Json;

namespace NCS.DSS.Collections.GetCollectionsHttpTrigger.Function
{
    public class GetCollectionsHttpTrigger
    {
        private readonly IGetCollectionsHttpTriggerService _service;
        private readonly IDssCorrelationValidator _dssCorrelationValidator;
        private readonly IDssTouchpointValidator _dssTouchpointValidator;
        private readonly ILogger<GetCollectionsHttpTrigger> _logger;

        public GetCollectionsHttpTrigger(IGetCollectionsHttpTriggerService service, ILogger<GetCollectionsHttpTrigger> logger, IDssCorrelationValidator dssCorrelationValidator,
          IDssTouchpointValidator dssTouchpointValidator)
        {
            _service = service;
            _logger = logger;
            _dssCorrelationValidator = dssCorrelationValidator;
            _dssTouchpointValidator = dssTouchpointValidator;
        }

        [Function("GET")]
        [ProducesResponseType(typeof(Collection), (int)HttpStatusCode.OK)]
        [Response(HttpStatusCode = (int)HttpStatusCode.OK, Description = "Collections found", ShowSchema = true)]
        [Response(HttpStatusCode = (int)HttpStatusCode.NoContent, Description = "Collections do not exist", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.BadRequest, Description = "Request was malformed", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Unauthorized, Description = "API key is unknown or invalid", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Forbidden, Description = "Insufficient access", ShowSchema = false)]
        [Display(Name = "GET", Description = "Ability to return all collections for the touchpoint.")]
        public async Task<IActionResult> RunAsync(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "collections")] HttpRequest req)
        {
            _logger.LogInformation("Function {FunctionName} has been invoked", nameof(GetCollectionsHttpTrigger));

            var correlationGuid = _dssCorrelationValidator.Extract(req, _logger);

            var touchpointId = _dssTouchpointValidator.Extract(req, _logger);

            if (string.IsNullOrEmpty(touchpointId))
            {
                _logger.LogWarning("Unable to locate 'TouchpointId' in request header. Correlation GUID: {CorrelationGuid}", correlationGuid);
                return new BadRequestResult();
            }

            _logger.LogInformation("Header validation has succeeded. Touchpoint ID: {TouchpointId}. Correlation GUID: {CorrelationGuid}", touchpointId, correlationGuid);

            _logger.LogInformation("Attempting to retrieve all Collection(s) from blob storage. Touchpoint ID: {TouchpointId}. Correlation GUID: {CorrelationGuid}", touchpointId, correlationGuid);
            var results = await _service.ProcessRequestAsync(touchpointId);

            if (results.Count == 0 || results == null)
            {
                _logger.LogInformation("No Collection(s) have been found. Touchpoint ID: {TouchpointId}. Correlation GUID: {CorrelationGuid}", touchpointId, correlationGuid);
                _logger.LogInformation("Function {FunctionName} has finished invoking", nameof(GetCollectionsHttpTrigger));

                return new NoContentResult();
            }

            if (results.Count == 1)
            {
                _logger.LogInformation("Successfully retrieved a Collection. Touchpoint ID: {TouchpointId}. Correlation GUID: {CorrelationGuid}", touchpointId, correlationGuid);
                _logger.LogInformation("Function {FunctionName} has finished invoking", nameof(GetCollectionsHttpTrigger));

                return new JsonResult(results[0], new JsonSerializerOptions()) { StatusCode = (int)HttpStatusCode.OK };
            }

            _logger.LogInformation("Successfully retrieved {Count} Collection(s). Touchpoint ID: {TouchpointId}. Correlation GUID: {CorrelationGuid}", results.Count, touchpointId, correlationGuid);
            _logger.LogInformation("Function {FunctionName} has finished invoking", nameof(GetCollectionsHttpTrigger));

            return new JsonResult(results, new JsonSerializerOptions()) { StatusCode = (int)HttpStatusCode.OK };
        }
    }
}
