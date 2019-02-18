using DFC.Functions.DI.Standard.Attributes;
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
        private readonly IStorage _storage;
        public GetCollectionByIdHtppTriggerService([Inject]IDocumentDBProvider documentDBProvider, IStorage storage)
        {            
            _documentDBProvider = documentDBProvider;
            _storage = storage;
        }
        public async Task<MemoryStream> ProcessRequestAsync(Guid touchPointId, Guid collectionId)
        {
            var collection = await _documentDBProvider.GetCollectionForTouchpointAsync(touchPointId, collectionId);

            Stream memoryStream = new MemoryStream();

            var file = await _storage.Get(collection.ReportStorageLocation);

            file.DownloadToStreamAsync(memoryStream).Wait();

            return (MemoryStream)memoryStream;
        }
    }
}
