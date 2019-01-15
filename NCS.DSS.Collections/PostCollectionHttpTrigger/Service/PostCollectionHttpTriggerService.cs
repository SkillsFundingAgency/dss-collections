using DFC.Common.Standard.Logging;
using DFC.Functions.DI.Standard.Attributes;
using DFC.HTTP.Standard;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.DataStore;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.Validators;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.PostCollectionHttpTrigger.Service
{
    public class PostCollectionHttpTriggerService : IPostCollectionHttpTriggerService
    {        
        private readonly ICollectionValidator _collectionValidator;        
        private readonly IHttpRequestHelper _requestHelper;
        private readonly ILoggerHelper _loggerHelper;
        private readonly ICollectionDataStore _dataStore;
        public PostCollectionHttpTriggerService([Inject]ICollectionValidator collectionValidator, [Inject]IHttpRequestHelper requestHelper, [Inject]ILoggerHelper loggerHelper, [Inject]ICollectionDataStore dataStore)
        {                     
            _requestHelper = requestHelper;
            _loggerHelper = loggerHelper;
            _collectionValidator = collectionValidator;
            _dataStore = dataStore;
        }
        public async Task<bool> ProcessRequestAsync(Collection collection)
        {                        
            if (collection == null)
            {
                return await Task.FromResult(false);
            }

            var validationErrors = await _collectionValidator.Validate(collection);

            if (validationErrors.Any())
            {
                return await Task.FromResult(false);
            }

            return await _dataStore.InsertCollection(collection);            
        }
    }
}
