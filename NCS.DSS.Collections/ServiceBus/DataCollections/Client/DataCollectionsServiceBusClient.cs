using Azure.Messaging.ServiceBus;
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

        public DataCollectionsServiceBusClient(IDataCollectionsServiceBusConfig busConfig,
                                               IDataCollectionsMessageProvider messageProvider,
                                               ServiceBusClient serviceBusClient)
        {
            _busConfig = busConfig;
            _messageProvider = messageProvider;
            _serviceBusClient = serviceBusClient;
        }
        public async Task SendPostMessageAsync(PersistedCollection collection)
        {
            var serviceBusSender = _serviceBusClient.CreateSender(_busConfig.QueueName);

            await serviceBusSender.SendMessageAsync(_messageProvider.MakeMessage(collection));
        }
    }
}
