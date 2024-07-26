using DFC.Common.Standard.Logging;
using DFC.HTTP.Standard;
using DFC.JSON.Standard;
using DFC.Swagger.Standard.Annotations;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.GetCollectionsHttpTrigger.Service;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.Validators;
using System.ComponentModel.DataAnnotations;
using System.Net;
using System.Threading.Tasks;
using Microsoft.Azure.Functions.Worker;

namespace NCS.DSS.Collections.GetCollectionsHttpTrigger.Function
{
    public class GetCollectionsHttpTrigger
    {
        private readonly IHttpResponseMessageHelper _responseMessageHelper;
        private IGetCollectionsHttpTriggerService _service;
        private IDssCorrelationValidator _dssCorrelationValidator;
        private IDssTouchpointValidator _dssTouchpointValidator;
        private ILogger<GetCollectionsHttpTrigger> _logger;
        private IJsonHelper _jsonHelper;

        public GetCollectionsHttpTrigger(IGetCollectionsHttpTriggerService service, IHttpResponseMessageHelper responseMessageHelper, ILogger<GetCollectionsHttpTrigger> logger, IDssCorrelationValidator dssCorrelationValidator,
          IDssTouchpointValidator dssTouchpointValidator, IJsonHelper jsonHelper)
        {
            _service = service;
            _responseMessageHelper = responseMessageHelper;
            _jsonHelper = jsonHelper;
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
        public async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "collections")] HttpRequest req)
        {
           
            var correlationId = _dssCorrelationValidator.Extract(req, _logger);

            var touchpointId = _dssTouchpointValidator.Extract(req, _logger);            

            if (string.IsNullOrEmpty(touchpointId))
            {                
                return new BadRequestResult();
            }

            _logger.LogInformation($"{ correlationId} Attempt to process request");

            var results = await _service.ProcessRequestAsync(touchpointId);

            if (results.Count == 0)
            {
                _logger.LogInformation($"{correlationId} unable to retrieve collection");
                return new NoContentResult();
            }
            var contentTypes = new Microsoft.AspNetCore.Mvc.Formatters.MediaTypeCollection
                {
                    new Microsoft.Net.Http.Headers.MediaTypeHeaderValue("application/json")
                };

            return new OkObjectResult(_jsonHelper.SerializeObjectsAndRenameIdProperty<Collection>(results, "id", "CollectionId")) { ContentTypes = contentTypes};                                       
        }
    }
}
