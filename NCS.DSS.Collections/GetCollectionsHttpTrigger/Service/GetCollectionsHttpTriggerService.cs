using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.Mappers;
using NCS.DSS.Collections.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.GetCollectionsHttpTrigger.Service
{
    public class GetCollectionsHttpTriggerService : IGetCollectionsHttpTriggerService
    {
        private readonly IDocumentDBProvider _documentDBProvider;
        private readonly ICollectionMapper _collectionMapper;

        public GetCollectionsHttpTriggerService(IDocumentDBProvider documentDBProvider,
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

