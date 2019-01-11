using DFC.Functions.DI.Standard.Attributes;
using DFC.HTTP.Standard;
using Microsoft.AspNetCore.Mvc;
using System.Net.Http;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.GetCollectionsHttpTrigger.Service
{
    public class GetCollectionsHttpTriggerService : IGetCollectionsHttpTriggerService
    {
        private readonly IHttpRequestHelper _requestHelper;
        public GetCollectionsHttpTriggerService([Inject]IHttpRequestHelper requestHelper)
        {
            _requestHelper = requestHelper;
        }
        public async Task<IActionResult> ProcessRequest(HttpRequestMessage req)
        {
            return await Task.FromResult(new OkObjectResult("Not Implemented"));
        }
    }
}
