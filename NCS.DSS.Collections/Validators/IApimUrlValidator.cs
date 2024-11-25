using Microsoft.AspNetCore.Http;

namespace NCS.DSS.Collections.Validators
{
    public interface IApimUrlValidator
    {
        string Extract(HttpRequest req);
    }
}
