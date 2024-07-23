using DFC.Common.Standard.Logging;
using DFC.HTTP.Standard;
using DFC.Swagger.Standard.Annotations;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.Validators;
using System;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Net.Http.Headers;

namespace NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Function
{
    public class GetCollectionByIdHttpTrigger
    {
        private readonly IHttpResponseMessageHelper _responseMessageHelper;
        private IGetCollectionByIdHtppTriggerService _service;
        private IDssCorrelationValidator _dssCorrelationValidator;
        private IDssTouchpointValidator _dssTouchpointValidator;
        private ILoggerHelper _loggerHelper;

        public GetCollectionByIdHttpTrigger(IGetCollectionByIdHtppTriggerService service, IHttpResponseMessageHelper responseMessageHelper, ILoggerHelper loggerHelper, IDssCorrelationValidator dssCorrelationValidator,
          IDssTouchpointValidator dssTouchpointValidator)
        {
            //_requestHelper = requestHelper;
            _service = service;
            _responseMessageHelper = responseMessageHelper;
            //_jsonHelper = jsonHelper;
            _loggerHelper = loggerHelper;
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
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "collections/{collectionId}")] HttpRequest req, string collectionId, ILogger log)
        {            
            log.LogInformation("Get Collection C# HTTP trigger function processing a request. For CollectionId " + collectionId);

            var correlationId = _dssCorrelationValidator.Extract(req, log);

            var touchpointId = _dssTouchpointValidator.Extract(req, log);

            if (string.IsNullOrEmpty(touchpointId))
            {
                return new BadRequestObjectResult("");
            }

            if (!Guid.TryParse(collectionId, out var collectionGuid))
                return new BadRequestObjectResult(collectionGuid);

            MemoryStream collectionStream;
            try
            {
                _loggerHelper.LogInformationMessage(log,correlationId,"Attempt to process request");
                collectionStream = await _service.ProcessRequestAsync(touchpointId, collectionGuid, log);        
            }
            catch (Exception ex)
            {
                _loggerHelper.LogError(log, correlationId, "unable to get collection", ex);
                return new UnprocessableEntityResult();
            }

            if (collectionStream == null)
                return new ContentResult();

            collectionStream.Position = 0;

            var response = new ObjectResult(new StreamContent(collectionStream)){ StatusCode = (int)HttpStatusCode.OK,  };
            var collection = new Microsoft.AspNetCore.Mvc.Formatters.MediaTypeCollection
            {
                new MediaTypeHeaderValue("application/octet-stream")
            };
            response.ContentTypes = collection;
            return response;
        }
    }
}
