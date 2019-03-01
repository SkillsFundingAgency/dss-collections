using System.Threading.Tasks;

namespace NCS.DSS.Collections.ServiceBus.ContentEnhancer.Client
{
    public interface IContentEnhancerServiceBusClient
    {
        Task SendAsync(Models.PersistedCollection collection);
    }
}
