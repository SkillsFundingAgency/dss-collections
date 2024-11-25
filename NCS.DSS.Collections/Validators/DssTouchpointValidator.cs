using DFC.Common.Standard.Logging;
using DFC.HTTP.Standard;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;

namespace NCS.DSS.Collections.Validators
{
    public class DssTouchpointValidator : IDssTouchpointValidator
    {
        private readonly IHttpRequestHelper _httpRequestHelper;        
        private readonly IDssCorrelationValidator _correlationValidator;
        private readonly ILogger<DssTouchpointValidator> _logger;

        public DssTouchpointValidator(IHttpRequestHelper httpRequestHelper, IDssCorrelationValidator correlationValidator, ILogger<DssTouchpointValidator> logger)
        {
            _httpRequestHelper = httpRequestHelper;
            _correlationValidator = correlationValidator;
            _logger = logger;
        }
        public string Extract(HttpRequest req, ILogger logger)
        {
            var touchpointId = _httpRequestHelper.GetDssTouchpointId(req);

            if (string.IsNullOrEmpty(touchpointId))
            {
                _logger.LogInformation($"Unable to locate 'TouchpointId' in request header. TouchpointId: {touchpointId} and CorrelationId: {_correlationValidator.Extract(req, logger)}");
                return null;
            }

            return touchpointId;
        }
    }
}
