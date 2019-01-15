using DFC.Common.Standard.Logging;
using DFC.Functions.DI.Standard.Attributes;
using DFC.HTTP.Standard;
using NCS.DSS.Collections.DataStore;
using NCS.DSS.Collections.Models;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.GetCollectionsHttpTrigger.Service
{
    public class GetCollectionsHttpTriggerService : IGetCollectionsHttpTriggerService
    {
        private readonly IHttpRequestHelper _requestHelper;
        private readonly ILoggerHelper _loggerHelper;
        private readonly ICollectionDataStore _dataStore;
        public GetCollectionsHttpTriggerService([Inject]IHttpRequestHelper requestHelper, [Inject]ILoggerHelper loggerHelper, [Inject]ICollectionDataStore dataStore)
        {
            _requestHelper = requestHelper;
            _loggerHelper = loggerHelper;
            _dataStore = dataStore;
        }
        public async Task<List<Collection>> ProcessRequestAsync()
        {                    
            return await _dataStore.GetCollections();
        }
    }
}
