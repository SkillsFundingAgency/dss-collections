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

        [Function("GET_BY_COLLECTIONID")]
        [ProducesResponseType(typeof(Collection), (int)HttpStatusCode.OK)]
        [Response(HttpStatusCode = (int)HttpStatusCode.OK, Description = "Collection Plan found", ShowSchema = true)]
        [Response(HttpStatusCode = (int)HttpStatusCode.NoContent, Description = "Collection does not exist", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.BadRequest, Description = "Request was malformed", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Unauthorized, Description = "API key is unknown or invalid", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Forbidden, Description = "Insufficient access", ShowSchema = false)]
        [Display(Name = "GET_BY_COLLECTIONID", Description = "Ability to retrieve a collection for the given collection id")]
        public async Task<IActionResult> RunAsync(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "collections/{collectionId}")] HttpRequest req, string collectionId)
        {
            _logger.LogInformation("Function {FunctionName} has been invoked", nameof(GetCollectionByIdHttpTrigger));

            var correlationGuid = _dssCorrelationValidator.Extract(req, _logger);

            var touchpointId = _dssTouchpointValidator.Extract(req, _logger);

            if (string.IsNullOrEmpty(touchpointId))
            {
                _logger.LogWarning("Unable to locate 'TouchpointId' in request header. Correlation GUID: {CorrelationGuid}", correlationGuid);
                return new BadRequestObjectResult("");
            }

            if (!Guid.TryParse(collectionId, out var collectionGuid))
            {
                _logger.LogWarning("Unable to parse 'collectionId' to a GUID. Collection ID: {CollectionId}. Correlation GUID: {CorrelationGuid}", collectionId, correlationGuid);
                return new BadRequestObjectResult(collectionGuid);
            }

            _logger.LogInformation("Header validation has succeeded. Touchpoint ID: {TouchpointId}. Correlation GUID: {CorrelationGuid}", touchpointId, correlationGuid);

            MemoryStream collectionStream;
            try
            {
                _logger.LogInformation("Attempting to process collection retrieval from blob storage. Collection ID: {CollectionId}. Correlation GUID: {CorrelationGuid}", collectionId, correlationGuid);
                collectionStream = await _service.ProcessRequestAsync(touchpointId, collectionGuid);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error has occurred when attempting to retrieve collection from blob storage. Correlation GUID: {CorrelationGuid}. Exception: {ExceptionMessage}", correlationGuid, ex.Message);
                return new UnprocessableEntityResult();
            }

            if (collectionStream == null)
            {
                _logger.LogWarning("Collection stream is null. Correlation GUID: {CorrelationGuid}", correlationGuid);
                return new NoContentResult();
            }

            collectionStream.Position = 0;

            var responseObject = new StreamContent(collectionStream);

            _logger.LogInformation("Collection successfully retrieved. Collection ID: {CollectionId}. Correlation GUID: {CorrelationGuid}", collectionId, correlationGuid);
            _logger.LogInformation("Function {FunctionName} has finished invoking", nameof(GetCollectionByIdHttpTrigger));
            return new FileStreamResult(collectionStream, "application/octet-stream");
        }
    }
}
