using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.Storage;

namespace NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service
{
    public class GetCollectionByIdHttpTriggerService : IGetCollectionByIdHttpTriggerService
    {
        private readonly ICosmosDBProvider _documentDBProvider;
        private readonly IDCBlobStorage _storage;
        private readonly ILogger<GetCollectionByIdHttpTriggerService> _logger;

        public GetCollectionByIdHttpTriggerService(ICosmosDBProvider documentDBProvider, IDCBlobStorage storage, ILogger<GetCollectionByIdHttpTriggerService> logger)
        {
            _documentDBProvider = documentDBProvider;
            _storage = storage;
            _logger = logger;
        }
        public async Task<MemoryStream> ProcessRequestAsync(string touchPointId, Guid collectionId)
        {
            var collection = await _documentDBProvider.GetCollectionForTouchpointAsync(touchPointId, collectionId);

            if (collection == null)
            {
                _logger.LogInformation($"Collection record does not exist. TouchpointId: {touchPointId} and CollectionId: {collectionId}");
                return null;
            }

            return await _storage.Get(collection);
        }
    }
}