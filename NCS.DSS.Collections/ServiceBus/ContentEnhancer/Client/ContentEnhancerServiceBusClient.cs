using Microsoft.Azure.ServiceBus;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.ServiceBus.Messages.ContentEnhancer;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.ServiceBus.ContentEnhancer.Client
{
    public class ContentEnhancerServiceBusClient : IContentEnhancerServiceBusClient
    {
        private readonly IContentEnhancerMessageBusConfig _config;
        private readonly IContentEnhancerMessageProvider _messageProvider;
        public ContentEnhancerServiceBusClient(IContentEnhancerMessageBusConfig config, IContentEnhancerMessageProvider messageProvider)
        {
            _config = config;
            _messageProvider = messageProvider;
        }
        public async Task SendAsync(PersistedCollection collection)
        {
            var queueClient = new QueueClient(_config.ServiceBusConnectionString, _config.QueueName);            

            await queueClient.SendAsync(_messageProvider.MakeMessage(collection));
        }
    }
}
