using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.ServiceBus.ContentEnhancer.Client;
using NCS.DSS.Collections.ServiceBus.DataCollections.Messages;
using NCS.DSS.Collections.ServiceBus.Messages.DataCollections;

namespace NCS.DSS.Collections.ServiceBus.Processor.Service
{

    public class DataCollectionsQueueProcessorService : IDataCollectionsQueueProcessorService
    {
        private readonly IDataCollectionsMessageProvider _messageProvider;
        private readonly IDocumentDBProvider _documentDbProvider;
        private readonly IContentEnhancerServiceBusClient _contentEnhancerServiceBusClient;
        private readonly ILogger<DataCollectionsQueueProcessorService> _logger;

        public DataCollectionsQueueProcessorService(IDataCollectionsMessageProvider messageProvider,
                                                    IContentEnhancerServiceBusClient contentEnhancerServiceBusClient,
                                                    IDocumentDBProvider documentDBProvider,
                                                    ILogger<DataCollectionsQueueProcessorService> logger)
        {
            _messageProvider = messageProvider;
            _documentDbProvider = documentDBProvider;
            _contentEnhancerServiceBusClient = contentEnhancerServiceBusClient;            _logger = logger;
        }

        public async Task ProcessMessageAsync(MessageCrossLoadToNCSDto message)
        {
            var correlationId = Guid.NewGuid();

            if (message == null)
            {
                throw new Exception("Unable to Deserialize Message");
            }

            if (string.Compare(message.Status, "success", StringComparison.InvariantCultureIgnoreCase) != 0)
            {
                var errorMessage = $"Data Collections returned failure for CollectionId - {message.JobId} - {message.Status}";
                _logger.LogError(errorMessage);
                throw new Exception(errorMessage);
            }

            var collection = await _documentDbProvider.GetCollectionAsync(message.JobId);

            if (collection == null)
            {
                var errorMessage = $"Data Collections - Could not locate Collection in CosmosDB. CollectionId - {message.JobId}";
                _logger.LogError(errorMessage);
                throw new Exception(errorMessage);
            }

            await _contentEnhancerServiceBusClient.SendAsync(collection);
        }
    }
}
