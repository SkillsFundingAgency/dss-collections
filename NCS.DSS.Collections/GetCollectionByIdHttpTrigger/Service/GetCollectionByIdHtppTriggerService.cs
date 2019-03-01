using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.Storage;
using System;
using System.IO;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service
{
    public class GetCollectionByIdHtppTriggerService : IGetCollectionByIdHtppTriggerService
    {        
        private readonly IDocumentDBProvider _documentDBProvider;
        private readonly IDCBlobStorage _storage;
        public GetCollectionByIdHtppTriggerService(IDocumentDBProvider documentDBProvider, IDCBlobStorage storage)
        {            
            _documentDBProvider = documentDBProvider;
            _storage = storage;
        }
        public async Task<MemoryStream> ProcessRequestAsync(string touchPointId, Guid collectionId, ILogger log)
        {
            var collection = await _documentDBProvider.GetCollectionForTouchpointAsync(touchPointId, collectionId);

            if (collection == null)
                return null;            

            return await _storage.Get(collection, log);
        }
    }
}
