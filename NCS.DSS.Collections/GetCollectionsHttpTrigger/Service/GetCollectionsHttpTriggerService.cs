using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.Mappers;
using NCS.DSS.Collections.Models;

namespace NCS.DSS.Collections.GetCollectionsHttpTrigger.Service
{
    public class GetCollectionsHttpTriggerService : IGetCollectionsHttpTriggerService
    {
        private readonly ICosmosDbProvider _cosmosDbProvider;
        private readonly ICollectionMapper _collectionMapper;

        public GetCollectionsHttpTriggerService(ICosmosDbProvider cosmosDbProvider,
                                                ICollectionMapper collectionMapper)
        {
            _cosmosDbProvider = cosmosDbProvider;
            _collectionMapper = collectionMapper;
        }

        public async Task<List<Collection>> ProcessRequestAsync(string touchpointId)
        {
            return _collectionMapper.Map(await _cosmosDbProvider.GetCollectionsForTouchpointAsync(touchpointId));
        }
    }
}

