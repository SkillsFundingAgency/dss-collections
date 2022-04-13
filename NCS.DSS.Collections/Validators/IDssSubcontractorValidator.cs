using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;

namespace NCS.DSS.Collections.Validators
{
    public interface IDssSubcontractorValidator
    {
        string Extract(HttpRequest req, ILogger logger);
    }
}
