using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;

namespace NCS.DSS.Collections.Validators
{
    public interface IDssCorrelationValidator
    {
        Guid Extract(HttpRequest req, ILogger logger);
    }
}
