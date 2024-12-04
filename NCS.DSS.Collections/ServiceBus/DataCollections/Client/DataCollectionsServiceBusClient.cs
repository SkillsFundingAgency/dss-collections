using Azure.Messaging.ServiceBus;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.ServiceBus.DataCollections.Config;
using NCS.DSS.Collections.ServiceBus.Messages.DataCollections;

namespace NCS.DSS.Collections.ServiceBus.DataCollections.Client
{
    public class DataCollectionsServiceBusClient : IDataCollectionsServiceBusClient
    {
        private readonly IDataCollectionsServiceBusConfig _busConfig;
        private readonly IDataCollectionsMessageProvider _messageProvider;
        private readonly ServiceBusClient _serviceBusClient;
        private readonly ILogger<DataCollectionsServiceBusClient> _logger;

        public DataCollectionsServiceBusClient(IDataCollectionsServiceBusConfig busConfig,
                                               IDataCollectionsMessageProvider messageProvider,
                                               ServiceBusClient serviceBusClient,
                                               ILogger<DataCollectionsServiceBusClient> logger)
        {
            _busConfig = busConfig;
            _messageProvider = messageProvider;
            _serviceBusClient = serviceBusClient;
            _logger = logger;
        }

        public async Task SendPostMessageAsync(PersistedCollection collection)
        {
            _logger.LogInformation("Attempting to send message to service bus. Collection ID: {CollectionId}", collection.CollectionId);

            var serviceBusSender = _serviceBusClient.CreateSender(_busConfig.QueueName);

            await serviceBusSender.SendMessageAsync(_messageProvider.MakeMessage(collection));

            _logger.LogInformation("Successfully sent message to the service bus. Collection ID: {CollectionId}", collection.CollectionId);
        }
    }
}
