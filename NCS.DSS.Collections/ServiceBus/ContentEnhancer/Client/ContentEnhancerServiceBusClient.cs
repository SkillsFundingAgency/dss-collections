﻿using Azure.Messaging.ServiceBus;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.ServiceBus.Messages.ContentEnhancer;

namespace NCS.DSS.Collections.ServiceBus.ContentEnhancer.Client
{
    public class ContentEnhancerServiceBusClient : IContentEnhancerServiceBusClient
    {
        private readonly IContentEnhancerMessageBusConfig _config;
        private readonly IContentEnhancerMessageProvider _messageProvider;
        private readonly ServiceBusClient _serviceBusClient;
        private readonly ILogger<ContentEnhancerServiceBusClient> _logger;

        public ContentEnhancerServiceBusClient(IContentEnhancerMessageBusConfig config,
            IContentEnhancerMessageProvider messageProvider,
            ServiceBusClient serviceBusClient,
            ILogger<ContentEnhancerServiceBusClient> logger)
        {
            _config = config;
            _messageProvider = messageProvider;
            _serviceBusClient = serviceBusClient;
            _logger = logger;
        }
        public async Task SendAsync(PersistedCollection collection)
        {
            _logger.LogInformation("Attempting to send message to service bus. Collection ID: {CollectionId}", collection.CollectionId);

            var serviceBusSender = _serviceBusClient.CreateSender(_config.QueueName);

            await serviceBusSender.SendMessageAsync(_messageProvider.MakeMessage(collection));

            _logger.LogInformation("Successfully sent message to the service bus. Collection ID: {CollectionId}", collection.CollectionId);
        }
    }
}
