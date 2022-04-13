using DFC.Common.Standard.Logging;
using DFC.HTTP.Standard;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;

namespace NCS.DSS.Collections.Validators
{
    public class DssSubcontractorValidator : IDssSubcontractorValidator
    {
        private readonly IHttpRequestHelper _httpRequestHelper;
        private readonly ILoggerHelper _loggerHelper;
        private readonly IDssCorrelationValidator _correlationValidator;
        public DssSubcontractorValidator(IHttpRequestHelper httpRequestHelper, ILoggerHelper loggerHelper, IDssCorrelationValidator correlationValidator)
        {
            _httpRequestHelper = httpRequestHelper;
            _loggerHelper = loggerHelper;
            _correlationValidator = correlationValidator;
        }
        public string Extract(HttpRequest req, ILogger logger)
        {
            var SubcontractorId = _httpRequestHelper.GetDssSubcontractorId(req);

            if (string.IsNullOrEmpty(SubcontractorId))
            {
                _loggerHelper.LogInformationMessage(logger, _correlationValidator.Extract(req, logger), "Unable to locate 'SubcontractorId' in request header");
                return null;
            }

            return SubcontractorId;
        }
    }
}
