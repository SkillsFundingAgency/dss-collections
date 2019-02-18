using DFC.Common.Standard.Logging;
using DFC.HTTP.Standard;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;

namespace NCS.DSS.Collections.Validators
{
    public interface IApimUrlValidator
    {
        string Extract(HttpRequest req, ILogger logger);
    }
    public class ApimUrlValidator : IApimUrlValidator
    {
        private readonly IHttpRequestHelper _httpRequestHelper;
        private readonly ILoggerHelper _loggerHelper;
        private readonly IDssCorrelationValidator _correlationValidator;
        public ApimUrlValidator(IHttpRequestHelper httpRequestHelper, ILoggerHelper loggerHelper, IDssCorrelationValidator correlationValidator)
        {
            _httpRequestHelper = httpRequestHelper;
            _loggerHelper = loggerHelper;
            _correlationValidator = correlationValidator;
        }
        public string Extract(HttpRequest req, ILogger logger)
        {
            var ApimUrl = _httpRequestHelper.GetDssApimUrl(req);

            if (string.IsNullOrEmpty(ApimUrl))
            {
                _loggerHelper.LogInformationMessage(logger, _correlationValidator.Extract(req, logger), "Unable to locate 'apimurl' in request header");
                return null;
            }

            return ApimUrl;
        }
    }
}
