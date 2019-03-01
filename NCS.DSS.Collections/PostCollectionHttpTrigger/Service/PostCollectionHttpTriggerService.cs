using DFC.Common.Standard.Logging;
using DFC.Functions.DI.Standard.Attributes;
using DFC.HTTP.Standard;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.Mappers;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.ServiceBus;
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
        private readonly IHttpResponseMessageHelper _responseMessageHelper;
        private readonly ILoggerHelper _loggerHelper;
        private readonly IDocumentDBProvider _documentDBProvider;
        private readonly IDataCollectionsServiceBusClient _dataCollectionsServiceBusClient;
        private readonly ICollectionMapper _collectionMapper;
        public PostCollectionHttpTriggerService(ICollectionValidator collectionValidator,
                                                IHttpRequestHelper requestHelper,
                                                IHttpResponseMessageHelper responseMessageHelper,
                                                ILoggerHelper loggerHelper,
                                                IDocumentDBProvider documentDBProvider,
                                                IDataCollectionsServiceBusClient dataCollectionsServiceBusClient,
                                                ICollectionMapper collectionMapper)
        {
            _requestHelper = requestHelper;
            _responseMessageHelper = responseMessageHelper;
            _loggerHelper = loggerHelper;
            _collectionValidator = collectionValidator;
            _documentDBProvider = documentDBProvider;
            _dataCollectionsServiceBusClient = dataCollectionsServiceBusClient;
            _collectionMapper = collectionMapper;
        }
        public async Task<Collection> ProcessRequestAsync(Collection collection, string apimUrl)
        {
            {
                if (collection == null)
                    return null;

                var validationErrors = await _collectionValidator.Validate(collection);

                if (validationErrors.Any())
                    return null;

                collection.CollectionReports = new Uri($"{apimUrl}/{collection.CollectionId}");
                
                var response = await _documentDBProvider.CreateCollectionAsync(_collectionMapper.Map(collection));

                await _dataCollectionsServiceBusClient.SendPostMessageAsync(_collectionMapper.Map(collection));

                return response.StatusCode == HttpStatusCode.Created ? (dynamic)response.Resource : null;                
            }
        }
    }
}
