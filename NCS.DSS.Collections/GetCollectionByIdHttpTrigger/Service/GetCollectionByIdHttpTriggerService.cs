using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.Storage;

namespace NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service
{
    public class GetCollectionByIdHttpTriggerService : IGetCollectionByIdHttpTriggerService
    {
        private readonly ICosmosDbProvider _cosmosDbProvider;
        private readonly IDCBlobStorage _storage;
        private readonly ILogger<GetCollectionByIdHttpTriggerService> _logger;

        public GetCollectionByIdHttpTriggerService(ICosmosDbProvider cosmosDbProvider, IDCBlobStorage storage, ILogger<GetCollectionByIdHttpTriggerService> logger)
        {
            _cosmosDbProvider = cosmosDbProvider;
            _storage = storage;
            _logger = logger;
        }
        public async Task<MemoryStream> ProcessRequestAsync(string touchPointId, Guid collectionId)
        {
            var collection = await _cosmosDbProvider.GetCollectionForTouchpointAsync(touchPointId, collectionId);

            if (collection == null)
            {
                _logger.LogInformation($"Collection record does not exist. TouchpointId: {touchPointId} and CollectionId: {collectionId}");
                return null;
            }            

            return await _storage.Get(collection);
        }
    }
}