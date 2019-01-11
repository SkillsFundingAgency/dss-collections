using DFC.Functions.DI.Standard.Attributes;
using DFC.HTTP.Standard;
using Microsoft.AspNetCore.Mvc;
using System.Net.Http;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service
{
    public class GetCollectionByIdHtppTriggerService : IGetCollectionByIdHtppTriggerService
    {
        private readonly IHttpRequestHelper _requestHelper;
        public GetCollectionByIdHtppTriggerService([Inject]IHttpRequestHelper requestHelper)
        {
            _requestHelper = requestHelper;
        }
        public async Task<IActionResult> ProcessRequest(HttpRequestMessage req)
        {
            return await Task.FromResult(new OkObjectResult("Not Implemented"));
        }
    }
}
