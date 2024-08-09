using DFC.Common.Standard.Logging;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.ServiceBus.ContentEnhancer.Client;
using NCS.DSS.Collections.ServiceBus.DataCollections.Messages;
using NCS.DSS.Collections.ServiceBus.Messages.DataCollections;
using System;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.ServiceBus.Processor.Service
{

    public class DataCollectionsQueueProcessorService : IDataCollectionsQueueProcessorService
    {
        private readonly IDataCollectionsMessageProvider _messageProvider;
        private readonly ILoggerHelper _loggerHelper;
        private readonly IDocumentDBProvider _documentDbProvider;
        private readonly IContentEnhancerServiceBusClient _contentEnhancerServiceBusClient;

        public DataCollectionsQueueProcessorService(IDataCollectionsMessageProvider messageProvider,
                                                    ILoggerHelper loggerHelper,
                                                    IContentEnhancerServiceBusClient contentEnhancerServiceBusClient,
                                                    IDocumentDBProvider documentDBProvider)
        {
            _messageProvider = messageProvider;
            _loggerHelper = loggerHelper;
            _documentDbProvider = documentDBProvider;
            _contentEnhancerServiceBusClient = contentEnhancerServiceBusClient;
        }
        public async Task ProcessMessageAsync(MessageCrossLoadToNCSDto message, ILogger log)
        {
            var correlationId = Guid.NewGuid();

            if (message == null)
                throw new Exception("Unable to Deserialize Message");

            if (string.Compare(message.Status, "success", StringComparison.InvariantCultureIgnoreCase) != 0)
            {
                _loggerHelper.LogError(log, correlationId, new Exception($"Data Collections returned failure for CollectionId - {message.JobId} - {message.Status}"));
                throw new Exception($"Data Collections returned failure for CollectionId - {message.JobId} - {message.Status}");
            }

            var collection = await _documentDbProvider.GetCollectionAsync(message.JobId);

            if (collection == null)
            {
                _loggerHelper.LogError(log, correlationId, new Exception($"Data Collections - Could not locate Collection in CosmosDB CollectionId - {message.JobId}"));
                throw new Exception($"Data Collections - Could not locate Collection in CosmosDB CollectionId - {message.JobId}");
            }

            await _contentEnhancerServiceBusClient.SendAsync(collection);
        }
    }
}
