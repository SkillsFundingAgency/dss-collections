using DFC.Common.Standard.Logging;
using DFC.Functions.DI.Standard.Attributes;
using DFC.HTTP.Standard;
using DFC.JSON.Standard;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.DataStore;
using NCS.DSS.Collections.Models;
using System;
using System.Collections.ObjectModel;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service
{
    public class GetCollectionByIdHtppTriggerService : IGetCollectionByIdHtppTriggerService
    {
        private readonly IHttpRequestHelper _requestHelper;
        private readonly IHttpResponseMessageHelper _responseMessageHelper;
        private readonly ILoggerHelper _loggerHelper;
        private readonly IJsonHelper _jsonHelper;
        private readonly ICollectionDataStore _dataStore;
        public GetCollectionByIdHtppTriggerService([Inject]IHttpRequestHelper requestHelper, [Inject]IHttpResponseMessageHelper responseMessageHelper, [Inject]ILoggerHelper loggerHelper, [Inject]IJsonHelper jsonHelper, [Inject]ICollectionDataStore dataStore)
        {
            _requestHelper = requestHelper;
            _loggerHelper = loggerHelper;
            _responseMessageHelper = responseMessageHelper;
            _jsonHelper = jsonHelper;
            _dataStore = dataStore;
        }
        public async Task<Collection> ProcessRequestAsync(string collectionId)
        {                        
            return await _dataStore.GetCollectionById(collectionId);
        }
    }
}
