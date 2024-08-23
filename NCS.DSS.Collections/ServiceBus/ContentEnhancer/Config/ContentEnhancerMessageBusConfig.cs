namespace NCS.DSS.Collections.ServiceBus.ContentEnhancer
{
    public class ContentEnhancerMessageBusConfig : IContentEnhancerMessageBusConfig
    {
        public string QueueName => Environment.GetEnvironmentVariable("CEQueueName");

        public string ServiceBusConnectionString => Environment.GetEnvironmentVariable("ServiceBusConnectionString");
    }
}
