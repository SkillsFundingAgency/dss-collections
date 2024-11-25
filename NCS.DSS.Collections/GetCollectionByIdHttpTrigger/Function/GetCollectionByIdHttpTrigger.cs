using DFC.Swagger.Standard.Annotations;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.Validators;
using System.ComponentModel.DataAnnotations;
using System.Net;

namespace NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Function
{
    public class GetCollectionByIdHttpTrigger
    {
        private readonly IGetCollectionByIdHttpTriggerService _service;
        private readonly IDssCorrelationValidator _dssCorrelationValidator;
        private readonly IDssTouchpointValidator _dssTouchpointValidator;
        private readonly ILogger<GetCollectionByIdHttpTrigger> _logger;

        public GetCollectionByIdHttpTrigger(IGetCollectionByIdHttpTriggerService service, ILogger<GetCollectionByIdHttpTrigger> logger, IDssCorrelationValidator dssCorrelationValidator,
          IDssTouchpointValidator dssTouchpointValidator)
        {
            _service = service;
            _logger = logger;
            _dssCorrelationValidator = dssCorrelationValidator;
            _dssTouchpointValidator = dssTouchpointValidator;
        }

        [Function("GetById")]
        [ProducesResponseType(typeof(Collection), (int)HttpStatusCode.OK)]
        [Response(HttpStatusCode = (int)HttpStatusCode.OK, Description = "Collection Plan found", ShowSchema = true)]
        [Response(HttpStatusCode = (int)HttpStatusCode.NoContent, Description = "Collection does not exist", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.BadRequest, Description = "Request was malformed", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Unauthorized, Description = "API key is unknown or invalid", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Forbidden, Description = "Insufficient access", ShowSchema = false)]
        [Display(Name = "Get", Description = "Ability to retrieve a collection for the given collection id")]
        public async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "collections/{collectionId}")] HttpRequest req, string collectionId)
        {
            _logger.LogInformation("Get Collection C# HTTP trigger function processing a request. For CollectionId " + collectionId);

            var correlationId = _dssCorrelationValidator.Extract(req, _logger);

            var touchpointId = _dssTouchpointValidator.Extract(req, _logger);

            if (string.IsNullOrEmpty(touchpointId))
            {
                return new BadRequestObjectResult("");
            }

            if (!Guid.TryParse(collectionId, out var collectionGuid))
                return new BadRequestObjectResult(collectionGuid);

            MemoryStream collectionStream;
            try
            {
                _logger.LogInformation($"{correlationId} Attempt to process request.");
                collectionStream = await _service.ProcessRequestAsync(touchpointId, collectionGuid);
            }
            catch (Exception ex)
            {
                _logger.LogError($"{correlationId} unable to get collection", ex);
                return new UnprocessableEntityResult();
            }

            if (collectionStream == null)
                return new NoContentResult();

            collectionStream.Position = 0;

            var responseObject = new StreamContent(collectionStream);
            return new FileStreamResult(collectionStream, "application/octet-stream");
        }
    }
}
