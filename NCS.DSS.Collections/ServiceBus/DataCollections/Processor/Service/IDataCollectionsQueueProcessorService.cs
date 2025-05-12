using NCS.DSS.Collections.ServiceBus.DataCollections.Messages;

namespace NCS.DSS.Collections.ServiceBus.Processor.Service
{
    public interface IDataCollectionsQueueProcessorService
    {
        Task ProcessMessageAsync(MessageCrossLoadToNCSDto message);
    }
}
