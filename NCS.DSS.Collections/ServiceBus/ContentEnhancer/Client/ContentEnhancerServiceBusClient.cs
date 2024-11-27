using Azure.Messaging.ServiceBus;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.ServiceBus.Messages.ContentEnhancer;

namespace NCS.DSS.Collections.ServiceBus.ContentEnhancer.Client
{
    public class ContentEnhancerServiceBusClient : IContentEnhancerServiceBusClient
    {
        private readonly IContentEnhancerMessageBusConfig _config;
        private readonly IContentEnhancerMessageProvider _messageProvider;
        private readonly ServiceBusClient _serviceBusClient;

        public ContentEnhancerServiceBusClient(IContentEnhancerMessageBusConfig config,
            IContentEnhancerMessageProvider messageProvider,
            ServiceBusClient serviceBusClient)
        {
            _config = config;
            _messageProvider = messageProvider;
            _serviceBusClient = serviceBusClient;
        }
        public async Task SendAsync(PersistedCollection collection)
        {
            var serviceBusSender = _serviceBusClient.CreateSender(_config.QueueName);

            await serviceBusSender.SendMessageAsync(_messageProvider.MakeMessage(collection));
        }
    }
}
