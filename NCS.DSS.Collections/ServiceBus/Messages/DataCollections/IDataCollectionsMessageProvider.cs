using Azure.Messaging.ServiceBus;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.ServiceBus.DataCollections.Messages;

namespace NCS.DSS.Collections.ServiceBus.Messages.DataCollections
{
    public interface IDataCollectionsMessageProvider
    {
        ServiceBusMessage MakeMessage(PersistedCollection collection);
        MessageCrossLoadToNCSDto DeserializeMessage(string message);
    }
}
