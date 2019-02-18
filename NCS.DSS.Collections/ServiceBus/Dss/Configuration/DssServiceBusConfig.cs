using System;

namespace NCS.DSS.Collections.ServiceBus.Dss.Configuration
{
    public class DssServiceBusConfig : IDssServiceBusConfig
    {
        public string QueueName => Environment.GetEnvironmentVariable("DssQueueName");
        public string ServiceBusConnectionString => Environment.GetEnvironmentVariable("DssBusConnectionString");
    }
}
