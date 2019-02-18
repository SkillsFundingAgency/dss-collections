using ESFA.DC.CrossLoad.Dto;
using Microsoft.Azure.ServiceBus;

namespace NCS.DSS.Collections.ServiceBus.Messages.DataCollections
{
    public interface IDataCollectionsMessageProvider
    {                
        Message MakeMessage(Models.Collection collection);
        MessageCrossLoadDcftToDctDto DeserializeMessage(string message);
    }
}
