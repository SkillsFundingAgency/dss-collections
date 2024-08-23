using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.Mappers;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.ServiceBus;
using NCS.DSS.Collections.Validators;
using System.ComponentModel.DataAnnotations;
using System.Net;

namespace NCS.DSS.Collections.PostCollectionHttpTrigger.Service
{
    public class PostCollectionHttpTriggerService : IPostCollectionHttpTriggerService
    {
        private readonly ICollectionValidator _collectionValidator;
        private readonly IDocumentDBProvider _documentDBProvider;
        private readonly IDataCollectionsServiceBusClient _dataCollectionsServiceBusClient;
        private readonly ICollectionMapper _collectionMapper;

        public PostCollectionHttpTriggerService(ICollectionValidator collectionValidator,
                                                IDocumentDBProvider documentDBProvider,
                                                IDataCollectionsServiceBusClient dataCollectionsServiceBusClient,
                                                ICollectionMapper collectionMapper)
        {
            _collectionValidator = collectionValidator;
            _documentDBProvider = documentDBProvider;
            _dataCollectionsServiceBusClient = dataCollectionsServiceBusClient;
            _collectionMapper = collectionMapper;
        }

        public List<ValidationResult> ValidateCollectionAsync(Collection collection)
        {
            if (collection == null)
                return null;

            var validationErrors = _collectionValidator.Validate(collection);

            return validationErrors.Any() ? validationErrors : null;
        }

        public async Task<Collection> ProcessRequestAsync(Collection collection, string apimUrl)
        {
            if (collection == null)
                return null;

            collection.CollectionReports = new Uri($"{apimUrl}/{collection.CollectionId}");

            var response = await _documentDBProvider.CreateCollectionAsync(_collectionMapper.Map(collection));

            return response.StatusCode == HttpStatusCode.Created ? (dynamic)response.Resource : null;

        }

        public async Task SendToServiceBusQueueAsync(Collection collection)
        {
            await _dataCollectionsServiceBusClient.SendPostMessageAsync(_collectionMapper.Map(collection));
        }

    }
}