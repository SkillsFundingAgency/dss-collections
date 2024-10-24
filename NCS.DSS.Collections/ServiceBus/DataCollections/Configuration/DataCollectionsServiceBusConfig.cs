﻿using NCS.DSS.Collections.ServiceBus.DataCollections.Config;

namespace NCS.DSS.Collections.ServiceBus.Configs
{
    public class DataCollectionsServiceBusConfig : IDataCollectionsServiceBusConfig
    {
        public string QueueName => Environment.GetEnvironmentVariable("DCQueueName_Out");

        public string ServiceBusConnectionString => Environment.GetEnvironmentVariable("ServiceBusConnectionString");
    }
}
