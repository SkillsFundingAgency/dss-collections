using System.Threading.Tasks;

namespace NCS.DSS.Collections.ServiceBus.Dss.Client
{
    public interface IDssServiceBusClient
    {
        Task SendPostMessageAsync(Models.Collection collection, string reqUrl);
    }
}
