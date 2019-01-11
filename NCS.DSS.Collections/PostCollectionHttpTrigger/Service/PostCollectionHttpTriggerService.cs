using DFC.Functions.DI.Standard.Attributes;
using DFC.HTTP.Standard;
using Microsoft.AspNetCore.Mvc;
using NCS.DSS.Collections.ContentExtractors;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.Validators;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.PostCollectionHttpTrigger.Service
{
    public class PostCollectionHttpTriggerService : IPostCollectionHttpTriggerService
    {        
        private readonly ICollectionValidator _collectionValidator;
        private readonly ICollectionExtractor _collectionExtractor;
        private readonly IHttpRequestHelper _requestHelper;
        public PostCollectionHttpTriggerService([Inject]ICollectionValidator collectionValidator, [Inject]ICollectionExtractor collectionExtractor, [Inject]IHttpRequestHelper requestHelper)
        {
            _collectionExtractor = collectionExtractor;
            _collectionValidator = collectionValidator;
            _requestHelper = requestHelper;
        }
        public async Task<IActionResult> ProcessRequest(HttpRequestMessage req)
        {
            Collection collection = await _collectionExtractor.Extract<Collection>(req);

            if (collection == null)
            {
                return await Task.FromResult(new BadRequestResult());
            }

            var validationErrors = await _collectionValidator.Validate(collection);

            if (validationErrors.Any())
            {
                return await Task.FromResult(new BadRequestResult());
            }



            return await Task.FromResult(new OkObjectResult("Not Implemented"));
        }
    }
}
