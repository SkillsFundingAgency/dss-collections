using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.Mappers;
using NCS.DSS.Collections.Models;

namespace NCS.DSS.Collections.GetCollectionsHttpTrigger.Service
{
    public class GetCollectionsHttpTriggerService : IGetCollectionsHttpTriggerService
    {
        private readonly ICosmosDBProvider _documentDBProvider;
        private readonly ICollectionMapper _collectionMapper;

        public GetCollectionsHttpTriggerService(ICosmosDBProvider documentDBProvider,
                                                ICollectionMapper collectionMapper)
        {
            _documentDBProvider = documentDBProvider;
            _collectionMapper = collectionMapper;
        }

        public async Task<List<Collection>> ProcessRequestAsync(string touchpointId)
        {
            return _collectionMapper.Map(await _documentDBProvider.GetCollectionsForTouchpointAsync(touchpointId));
        }
    }
}

