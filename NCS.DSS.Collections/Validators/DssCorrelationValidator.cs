using DFC.HTTP.Standard;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;

namespace NCS.DSS.Collections.Validators
{
    public class DssCorrelationValidator : IDssCorrelationValidator
    {
        private readonly IHttpRequestHelper _httpRequestHelper;
        public DssCorrelationValidator(IHttpRequestHelper httpRequestHelper)
        {
            _httpRequestHelper = httpRequestHelper;
        }
        public Guid Extract(HttpRequest req, ILogger logger)
        {
            var correlationId = _httpRequestHelper.GetDssCorrelationId(req);

            if (string.IsNullOrEmpty(correlationId))
            {
                logger.LogInformation("Unable to locate 'DssCorrelationId' in request header");
            }

            if (!Guid.TryParse(correlationId, out var correlationGuid))
            {
                logger.LogInformation("Unable to parse 'DssCorrelationId' to a Guid");
                correlationGuid = Guid.NewGuid();
            }

            return correlationGuid;
        }
    }
}
