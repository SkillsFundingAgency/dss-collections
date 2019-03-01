using DFC.Common.Standard.Logging;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.ServiceBus.ContentEnhancer.Client;
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
        public async Task ProcessMessageAsync(string queueItem, ILogger log)
        {
            var correlationId = Guid.NewGuid();

            var message = _messageProvider.DeserializeMessage(queueItem);

            if (!message.Status.Contains("SUCCESS"))
            {
                _loggerHelper.LogError(log, correlationId, new Exception($"Data Collections returned failure for CollectionId - {message.JobId}"));
            }

            var collection = await _documentDbProvider.GetCollectionAsync(message.JobId);

            if (collection == null)
            {
                _loggerHelper.LogError(log, correlationId, new Exception($"Data Collections - Could not location Collection in CosmosDB CollectionId -{message.JobId}"));
            }
            else
            {
                await _contentEnhancerServiceBusClient.SendAsync(collection);
            }
        }
    }
}
