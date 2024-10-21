using Microsoft.Extensions.Logging;

namespace NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service
{
    public interface IGetCollectionByIdHtppTriggerService
    {
        Task<MemoryStream> ProcessRequestAsync(string touchPointId, Guid collectionId, ILogger log);
    }
}
