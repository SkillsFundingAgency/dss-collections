﻿using Microsoft.Extensions.Logging;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.ServiceBus.Processor.Service
{
    public interface IDataCollectionsQueueProcessorService
    {
        Task ProcessMessageAsync(string queueItem, ILogger log);
    }
}
