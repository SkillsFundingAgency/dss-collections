using Microsoft.Azure.ServiceBus;

namespace NCS.DSS.Collections.ServiceBus.Messages.ContentEnhancer
{
    public interface IContentEnhancerMessageProvider
    {
        Message MakeMessage(Models.Collection collection, string reqUrl);
    }
}
