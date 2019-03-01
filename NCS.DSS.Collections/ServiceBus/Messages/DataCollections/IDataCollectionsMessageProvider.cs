using Microsoft.Azure.ServiceBus;
using NCS.DSS.Collections.ServiceBus.DataCollections.Messages;

namespace NCS.DSS.Collections.ServiceBus.Messages.DataCollections
{
    public interface IDataCollectionsMessageProvider
    {                
        Message MakeMessage(Models.PersistedCollection collection);
        MessageCrossLoadToNCSDto DeserializeMessage(string message);
    }
}
