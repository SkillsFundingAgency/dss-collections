using Microsoft.Azure.Documents;
using Microsoft.Azure.Documents.Client;
using NCS.DSS.Collections.Models;

namespace NCS.DSS.Collections.Cosmos.Provider
{
    public interface IDocumentDBProvider
    {
        Task<bool> DoesCollectionResourceExist(PersistedCollection collection);
        Task<ResourceResponse<Document>> CreateCollectionAsync(PersistedCollection collection);
        Task<List<PersistedCollection>> GetCollectionsForTouchpointAsync(string touchpointId);
        Task<PersistedCollection> GetCollectionForTouchpointAsync(string touchPointId, Guid collectionId);
        Task<PersistedCollection> GetCollectionAsync(Guid collectionId);
        Task<ResourceResponse<Document>> UpdateCollectionAsync(PersistedCollection collection);
    }
}
