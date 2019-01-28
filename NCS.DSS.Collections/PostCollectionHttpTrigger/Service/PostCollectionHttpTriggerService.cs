using DFC.Common.Standard.Logging;
using DFC.Functions.DI.Standard.Attributes;
using DFC.HTTP.Standard;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.Validators;
using System;
using System.Linq;
using System.Net;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.PostCollectionHttpTrigger.Service
{
    public class PostCollectionHttpTriggerService : IPostCollectionHttpTriggerService
    {        
        private readonly ICollectionValidator _collectionValidator;        
        private readonly IHttpRequestHelper _requestHelper;
        private readonly ILoggerHelper _loggerHelper;        
        private readonly IDocumentDBProvider _documentDBProvider;
        public PostCollectionHttpTriggerService([Inject]ICollectionValidator collectionValidator, 
                                                [Inject]IHttpRequestHelper requestHelper, 
                                                [Inject]ILoggerHelper loggerHelper,                                                
                                                [Inject]IDocumentDBProvider documentDBProvider)
        {                     
            _requestHelper = requestHelper;
            _loggerHelper = loggerHelper;
            _collectionValidator = collectionValidator;            
            _documentDBProvider = documentDBProvider;
        }
        public async Task<Collection> ProcessRequestAsync(Collection collection)
        {                        
            if (collection == null)
            {
                return null;
            }

            var validationErrors = await _collectionValidator.Validate(collection);

            if (validationErrors.Any())
            {
                return null;
            }

            var response = await _documentDBProvider.CreateCollectionAsync(collection);

            return response.StatusCode == HttpStatusCode.Created ? (dynamic)response.Resource : null;                                    
        }
    }
}
