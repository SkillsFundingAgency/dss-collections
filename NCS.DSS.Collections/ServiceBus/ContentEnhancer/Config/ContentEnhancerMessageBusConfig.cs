using System;

namespace NCS.DSS.Collections.ServiceBus.ContentEnhancer
{
    public class ContentEnhancerMessageBusConfig : IContentEnhancerMessageBusConfig
    {
        public string QueueName => Environment.GetEnvironmentVariable("ContentEnhancerQueueName");

        public string ServiceBusConnectionString => Environment.GetEnvironmentVariable("ContentEnhancerConnectionString");
    }
}
