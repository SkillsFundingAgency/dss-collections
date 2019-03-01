using Microsoft.Azure.ServiceBus;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.ServiceBus.DataCollections.Config;
using NCS.DSS.Collections.ServiceBus.Messages.DataCollections;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.ServiceBus
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
