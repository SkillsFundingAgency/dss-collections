using Microsoft.Azure.ServiceBus;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.ServiceBus.DataCollections.Config;
using NCS.DSS.Collections.ServiceBus.Messages.DataCollections;

namespace NCS.DSS.Collections.ServiceBus.DataCollections.Client
{
    public class DataCollectionsServiceBusClient : IDataCollectionsServiceBusClient
    {
        private readonly IDataCollectionsServiceBusConfig _busConfig;
        private readonly IDataCollectionsMessageProvider _messageProvider;
        public DataCollectionsServiceBusClient(IDataCollectionsServiceBusConfig busConfig,
                                               IDataCollectionsMessageProvider messageProvider)
        {
            _busConfig = busConfig;
            _messageProvider = messageProvider;
        }
        public async Task SendPostMessageAsync(PersistedCollection collection)
        {
            var queueClient = new QueueClient(_busConfig.ServiceBusConnectionString, _busConfig.QueueName);

            await queueClient.SendAsync(_messageProvider.MakeMessage(collection));
        }
    }
}
