using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Models;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.PostCollectionHttpTrigger.Service
{
    public interface IPostCollectionHttpTriggerService
    {
        Task<Collection> ProcessRequestAsync(Collection collection, string apimUrl);
        Task SendToServiceBusQueueAsync(Collection collection);
    }
}
