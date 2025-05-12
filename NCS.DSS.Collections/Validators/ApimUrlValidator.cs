using DFC.HTTP.Standard;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;

namespace NCS.DSS.Collections.Validators
{
    public class ApimUrlValidator : IApimUrlValidator
    {
        private readonly IHttpRequestHelper _httpRequestHelper;
        private readonly ILogger<ApimUrlValidator> _logger;
        private readonly IDssCorrelationValidator _correlationValidator;
        public ApimUrlValidator(IHttpRequestHelper httpRequestHelper, ILogger<ApimUrlValidator> logger, IDssCorrelationValidator correlationValidator)
        {
            _httpRequestHelper = httpRequestHelper;
            _logger = logger;
            _correlationValidator = correlationValidator;
        }
        public string Extract(HttpRequest req)
        {
            var ApimUrl = _httpRequestHelper.GetDssApimUrl(req);

            if (string.IsNullOrEmpty(ApimUrl))
            {
                _logger.LogInformation("Unable to locate 'apimURL' in request header. Correlation GUID: {CorrelationGuid}", _correlationValidator.Extract(req, _logger));
                return null;
            }

            return ApimUrl;
        }
    }
}
