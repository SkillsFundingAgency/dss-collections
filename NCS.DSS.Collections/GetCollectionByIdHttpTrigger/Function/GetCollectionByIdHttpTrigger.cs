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
using NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.Validators;
using System;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

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

        [FunctionName("GetById")]
        [ProducesResponseType(typeof(Collection), (int)HttpStatusCode.OK)]
        [Response(HttpStatusCode = (int)HttpStatusCode.OK, Description = "Collection Plan found", ShowSchema = true)]
        [Response(HttpStatusCode = (int)HttpStatusCode.NoContent, Description = "Collection does not exist", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.BadRequest, Description = "Request was malformed", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Unauthorized, Description = "API key is unknown or invalid", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Forbidden, Description = "Insufficient access", ShowSchema = false)]
        [Display(Name = "Get", Description = "Ability to retrieve a collection for the given collection id")]
        public async Task<HttpResponseMessage> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "collections/{collectionId}")] HttpRequest req, string collectionId, ILogger log)
        {            
            log.LogInformation("Get Collection C# HTTP trigger function processing a request. For CollectionId " + collectionId);

            var correlationId = _dssCorrelationValidator.Extract(req, log);

            var touchpointId = _dssTouchpointValidator.Extract(req, log);

            if (string.IsNullOrEmpty(touchpointId))
            {
                return _responseMessageHelper.BadRequest();
            }

            if (!Guid.TryParse(collectionId, out var collectionGuid))
                return _responseMessageHelper.BadRequest(collectionGuid);

            MemoryStream collectionStream;
            try
            {
                _loggerHelper.LogInformationMessage(log,correlationId,"Attempt to process request");
                collectionStream = await _service.ProcessRequestAsync(touchpointId, collectionGuid, log);        
            }
            catch (Exception ex)
            {
                _loggerHelper.LogError(log, correlationId, "unable to get collection", ex);
                return _responseMessageHelper.UnprocessableEntity();
            }

            if (collectionStream == null)
                return _responseMessageHelper.NoContent();

            collectionStream.Position = 0;

            var response = new HttpResponseMessage(HttpStatusCode.OK) { Content = new StreamContent(collectionStream) };
            response.Content.Headers.ContentType = new MediaTypeHeaderValue("application/octet-stream");
            return response;
        }
    }
}
