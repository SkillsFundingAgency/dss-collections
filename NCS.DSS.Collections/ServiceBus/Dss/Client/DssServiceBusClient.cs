using System.Threading.Tasks;
using NCS.DSS.Collections.Models;

namespace NCS.DSS.Collections.ServiceBus.Dss.Client
{

    public class DssServiceBusClient : IDssServiceBusClient
    {
        public Task SendPostMessageAsync(Collection collection, string reqUrl)
        {
            throw new System.NotImplementedException();
        }
    }
}
