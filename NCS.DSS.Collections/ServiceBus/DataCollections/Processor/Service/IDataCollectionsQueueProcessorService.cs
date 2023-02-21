using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.ServiceBus.DataCollections.Messages;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.ServiceBus.Processor.Service
{
    public interface IDataCollectionsQueueProcessorService
    {
        Task ProcessMessageAsync(MessageCrossLoadToNCSDto message, ILogger log);
    }
}
