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
        private readonly ICosmosDbProvider _cosmosDbProvider;
        private readonly IContentEnhancerServiceBusClient _contentEnhancerServiceBusClient;
        private readonly ILogger<DataCollectionsQueueProcessorService> _logger;

        public DataCollectionsQueueProcessorService(IDataCollectionsMessageProvider messageProvider,
                                                    IContentEnhancerServiceBusClient contentEnhancerServiceBusClient,
                                                    ICosmosDbProvider cosmosDbProvider,
                                                    ILogger<DataCollectionsQueueProcessorService> logger)
        {
            _messageProvider = messageProvider;
            _cosmosDbProvider = cosmosDbProvider;
            _contentEnhancerServiceBusClient = contentEnhancerServiceBusClient;            _logger = logger;
        }

        public async Task ProcessMessageAsync(MessageCrossLoadToNCSDto message)
        {
            var correlationId = Guid.NewGuid();

            if (message == null)
            {
                _logger.LogWarning("The Collection message could not be sent to the service bus due to a null message object.");

                throw new Exception("Unable to Deserialize Message");
            }

            if (string.Compare(message.Status, "success", StringComparison.InvariantCultureIgnoreCase) != 0)
            {
                var errorMessage = $"Data Collections returned failure for CollectionID: {message.JobId} - Status: {message.Status}";
                _logger.LogError(errorMessage);
                throw new Exception(errorMessage);
            }

            var collection = await _cosmosDbProvider.GetCollectionAsync(message.JobId);

            if (collection == null)
            {
                var errorMessage = $"Data Collections - Could not locate Collection in CosmosDB. CollectionID: {message.JobId}";
                _logger.LogError(errorMessage);
                throw new Exception(errorMessage);
            }

            _logger.LogInformation("Attempting to send message to service bus client. Collection ID: {JobId}", message.JobId);

            await _contentEnhancerServiceBusClient.SendAsync(collection);

            _logger.LogInformation("Successfully sent message to the service bus by client. Collection ID: {JobId}", message.JobId);
        }
    }
}
