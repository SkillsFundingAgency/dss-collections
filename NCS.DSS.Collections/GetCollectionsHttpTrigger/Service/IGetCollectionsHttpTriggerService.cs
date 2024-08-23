using NCS.DSS.Collections.Models;

namespace NCS.DSS.Collections.GetCollectionsHttpTrigger.Service
{
    public interface IGetCollectionsHttpTriggerService
    {
        Task<List<Collection>> ProcessRequestAsync(string touchpointId);
    }
}
