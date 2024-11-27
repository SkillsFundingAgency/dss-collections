using Microsoft.Azure.Cosmos;
using NCS.DSS.Collections.Models;

namespace NCS.DSS.Collections.Cosmos.Provider
{
    public interface ICosmosDBProvider
    {
        Task<ItemResponse<PersistedCollection>> CreateCollectionAsync(PersistedCollection collection);
        Task<List<PersistedCollection>> GetCollectionsForTouchpointAsync(string touchpointId);
        Task<PersistedCollection> GetCollectionForTouchpointAsync(string touchPointId, Guid collectionId);
        Task<PersistedCollection> GetCollectionAsync(Guid collectionId);
        Task<ItemResponse<PersistedCollection>> UpdateCollectionAsync(PersistedCollection collection);
    }
}
