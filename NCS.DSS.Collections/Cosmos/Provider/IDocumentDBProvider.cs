using Microsoft.Azure.Documents;
using Microsoft.Azure.Documents.Client;
using NCS.DSS.Collections.Models;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.Cosmos.Provider
{
    public interface IDocumentDBProvider
    {
        Task<bool> DoesCollectionResourceExist(PersistedCollection collection);
        Task<ResourceResponse<Document>> CreateCollectionAsync(PersistedCollection collection);
        Task<List<PersistedCollection>> GetCollectionsForTouchpointAsync(string touchpointId, string subcontractorId);
        Task<PersistedCollection> GetCollectionForTouchpointAsync(string touchPointId, string subcontractorId, Guid collectionId);
        Task<PersistedCollection> GetCollectionAsync(Guid collectionId);
        Task<ResourceResponse<Document>> UpdateCollectionAsync(PersistedCollection collection);
    }
}
