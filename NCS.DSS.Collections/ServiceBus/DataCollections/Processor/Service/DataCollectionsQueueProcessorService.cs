using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.ServiceBus.Messages.DataCollections;
using System;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.ServiceBus.Processor.Service
{

    public class DataCollectionsQueueProcessorService : IDataCollectionsQueueProcessorService
    {
        private readonly IDataCollectionsMessageProvider _messageProvider;
        private readonly IDocumentDBProvider _documentDbProvider;

        public DataCollectionsQueueProcessorService(IDataCollectionsMessageProvider messageProvider, IDocumentDBProvider documentDBProvider)
        {
            _messageProvider = messageProvider;
            _documentDbProvider = documentDBProvider;
        }
        public async Task ProcessMessageAsync(string queueItem)
        {
            var message = _messageProvider.DeserializeMessage(queueItem);

            Guid.TryParse(message.DcftJobId, out var collectionGuid);            

            var collection = await _documentDbProvider.GetCollectionAsync(collectionGuid);            

            collection.ReportStorageLocation = message.StorageFileNameReport1;

            await _documentDbProvider.UpdateCollectionAsync(collection);


        }
    }
}
