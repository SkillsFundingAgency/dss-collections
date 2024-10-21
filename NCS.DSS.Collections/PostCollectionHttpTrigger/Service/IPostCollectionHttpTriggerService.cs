using NCS.DSS.Collections.Models;
using System.ComponentModel.DataAnnotations;

namespace NCS.DSS.Collections.PostCollectionHttpTrigger.Service
{
    public interface IPostCollectionHttpTriggerService
    {
        List<ValidationResult> ValidateCollectionAsync(Collection collection);
        Task<Collection> ProcessRequestAsync(Collection collection, string apimUrl);
        Task SendToServiceBusQueueAsync(Collection collection);
    }
}
