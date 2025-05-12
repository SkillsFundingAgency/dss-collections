using Azure.Messaging.ServiceBus;

namespace NCS.DSS.Collections.ServiceBus.Messages.ContentEnhancer
{
    public interface IContentEnhancerMessageProvider
    {
        ServiceBusMessage MakeMessage(Models.Collection collection);
    }
}
