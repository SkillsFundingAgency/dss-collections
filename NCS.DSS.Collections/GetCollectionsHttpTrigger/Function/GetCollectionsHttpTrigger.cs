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
using NCS.DSS.Collections.GetCollectionsHttpTrigger.Service;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.Validators;
using System;
using System.ComponentModel.DataAnnotations;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.GetCollectionsHttpTrigger.Function
{
    public class GetCollectionsHttpTrigger
    {
        private readonly IHttpResponseMessageHelper _responseMessageHelper;
        private IGetCollectionsHttpTriggerService _service;
        private IDssCorrelationValidator _dssCorrelationValidator;
        private IDssTouchpointValidator _dssTouchpointValidator;
        private IDssSubcontractorValidator _dssSubcontractorValidator;
        private ILoggerHelper _loggerHelper;
        private IJsonHelper _jsonHelper;

        public GetCollectionsHttpTrigger(IGetCollectionsHttpTriggerService service, IHttpResponseMessageHelper responseMessageHelper, ILoggerHelper loggerHelper, IDssCorrelationValidator dssCorrelationValidator,
          IDssTouchpointValidator dssTouchpointValidator, IJsonHelper jsonHelper, IDssSubcontractorValidator dssSubcontractorValidator)
        {
            _service = service;
            _responseMessageHelper = responseMessageHelper;
            _jsonHelper = jsonHelper;
            _loggerHelper = loggerHelper;
            _dssCorrelationValidator = dssCorrelationValidator;
            _dssTouchpointValidator = dssTouchpointValidator;
            _dssSubcontractorValidator = dssSubcontractorValidator;
        }

        [FunctionName("Get")]
        [ProducesResponseType(typeof(Collection), (int)HttpStatusCode.OK)]
        [Response(HttpStatusCode = (int)HttpStatusCode.OK, Description = "Collections found", ShowSchema = true)]
        [Response(HttpStatusCode = (int)HttpStatusCode.NoContent, Description = "Collections do not exist", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.BadRequest, Description = "Request was malformed", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Unauthorized, Description = "API key is unknown or invalid", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Forbidden, Description = "Insufficient access", ShowSchema = false)]
        [Display(Name = "Get", Description = "Ability to return all collections for the touchpoint.")]
        public async Task<HttpResponseMessage> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "collections")] HttpRequest req,
            ILogger log)
        {
            _loggerHelper.LogMethodEnter(log);            

            var correlationId = _dssCorrelationValidator.Extract(req, log);

            var touchpointId = _dssTouchpointValidator.Extract(req, log);            

            if (string.IsNullOrEmpty(touchpointId))
            {                
                return _responseMessageHelper.BadRequest();
            }

            var subcontractorId = _dssSubcontractorValidator.Extract(req, log);

            if (string.IsNullOrEmpty(subcontractorId))
            {
                return _responseMessageHelper.BadRequest();
            }

            _loggerHelper.LogInformationMessage(log, correlationId, "Attempt to process request");

            var results = await _service.ProcessRequestAsync(touchpointId, subcontractorId);

            if (results.Count == 0)
            {
                _loggerHelper.LogInformationMessage(log, correlationId, "unable to retrieve collection");
                return _responseMessageHelper.NoContent();
            }

            _loggerHelper.LogMethodExit(log);

            return _responseMessageHelper.Ok(_jsonHelper.SerializeObjectsAndRenameIdProperty<Collection>(results, "id", "CollectionId"));                                       
        }
    }
}
