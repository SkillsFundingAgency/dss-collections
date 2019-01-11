using Microsoft.AspNetCore.Mvc;
using System.Net.Http;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.Scaffold
{
    public interface ICollectionService
    {
        Task<IActionResult> ProcessRequest(HttpRequestMessage req);
    }
}
