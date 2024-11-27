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

        [Function("Get")]
        [ProducesResponseType(typeof(Collection), (int)HttpStatusCode.OK)]
        [Response(HttpStatusCode = (int)HttpStatusCode.OK, Description = "Collections found", ShowSchema = true)]
        [Response(HttpStatusCode = (int)HttpStatusCode.NoContent, Description = "Collections do not exist", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.BadRequest, Description = "Request was malformed", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Unauthorized, Description = "API key is unknown or invalid", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Forbidden, Description = "Insufficient access", ShowSchema = false)]
        [Display(Name = "Get", Description = "Ability to return all collections for the touchpoint.")]
        public async Task<IActionResult> RunAsync(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "collections")] HttpRequest req)
        {
            var correlationId = _dssCorrelationValidator.Extract(req, _logger);

            var touchpointId = _dssTouchpointValidator.Extract(req, _logger);

            if (string.IsNullOrEmpty(touchpointId))
            {
                _logger.LogWarning("CorrelationId: {0} Unable to locate 'TouchpointId' in request header.", correlationId);
                return new BadRequestResult();
            }

            _logger.LogInformation("CorrelationId: {0} Attempt to process request", correlationId);

            var results = await _service.ProcessRequestAsync(touchpointId);

            if (results.Count == 0 || results == null)
            {
                _logger.LogInformation("CorrelationId: {0} Unable to retrieve collection", correlationId);
                return new NoContentResult();
            }
            else if (results.Count == 1)
            {
                _logger.LogInformation("CorrelationId: {0} Successfully retrieved [{1}] collection", correlationId, results.Count);
                return new JsonResult(results[0], new JsonSerializerOptions()) { StatusCode = (int)HttpStatusCode.OK };
            }
            else
            {
                _logger.LogInformation("CorrelationId: {0} Successfully retrieved [{1}] collections", correlationId, results.Count);
                return new JsonResult(results, new JsonSerializerOptions()) { StatusCode = (int)HttpStatusCode.OK };
            }
        }
    }
}
