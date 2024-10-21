using Microsoft.Azure.Documents;
using Microsoft.Azure.Documents.Client;
using Microsoft.Azure.Documents.Linq;
using NCS.DSS.Collections.Cosmos.Client;
using NCS.DSS.Collections.Cosmos.Helper;
using NCS.DSS.Collections.Models;

namespace NCS.DSS.Collections.Cosmos.Provider
{
    public class DocumentDBProvider : IDocumentDBProvider
    {
        public async Task<ResourceResponse<Document>> CreateCollectionAsync(PersistedCollection collection)
        {
            var collectionUri = DocumentDBHelper.CreateCollectionDocumentCollectionUri();

            var client = DocumentDBClient.CreateDocumentClient();

            if (client == null)
                return null;

            return await client.CreateDocumentAsync(collectionUri, collection);
        }

        public async Task<bool> DoesCollectionResourceExist(PersistedCollection collection)
        {
            var documentUri = DocumentDBHelper.CreateCollectionDocumentUri(collection.CollectionId);

            var client = DocumentDBClient.CreateDocumentClient();

            if (client == null)
                return false;
            try
            {
                var response = await client.ReadDocumentAsync(documentUri);
                if (response.Resource != null)
                    return true;
            }
            catch (DocumentClientException)
            {
                return false;
            }

            return false;
        }

        public async Task<PersistedCollection> GetCollectionAsync(Guid collectionId)
        {
            var collectionUri = DocumentDBHelper.CreateCollectionDocumentCollectionUri();

            var client = DocumentDBClient.CreateDocumentClient();

            var collectionForCollectionIdQuery = client?.CreateDocumentQuery<PersistedCollection>(collectionUri, new FeedOptions { MaxItemCount = 1 })
                                                    .Where(x => x.CollectionId == collectionId)
                                                    .AsDocumentQuery();

            if (collectionForCollectionIdQuery == null)
                return null;

            var collection = await collectionForCollectionIdQuery.ExecuteNextAsync<PersistedCollection>();

            return collection?.FirstOrDefault();
        }

        public async Task<PersistedCollection> GetCollectionForTouchpointAsync(string touchPointId, Guid collectionId)
        {
            var collectionUri = DocumentDBHelper.CreateCollectionDocumentCollectionUri();

            var client = DocumentDBClient.CreateDocumentClient();

            var collectionForTouchpointQuery = client
                ?.CreateDocumentQuery<PersistedCollection>(collectionUri, new FeedOptions { MaxItemCount = 1 })
                .Where(x => x.TouchPointId == touchPointId && x.CollectionId == collectionId)
                .AsDocumentQuery();

            if (collectionForTouchpointQuery == null)
                return null;

            var collections = await collectionForTouchpointQuery.ExecuteNextAsync<PersistedCollection>();

            return collections?.FirstOrDefault();
        }

        public async Task<List<PersistedCollection>> GetCollectionsForTouchpointAsync(string touchpointId)
        {
            var collectionUri = DocumentDBHelper.CreateCollectionDocumentCollectionUri();

            var client = DocumentDBClient.CreateDocumentClient();

            var collectionsQuery = client.CreateDocumentQuery<PersistedCollection>(collectionUri)
                .Where(so => so.TouchPointId == touchpointId).AsDocumentQuery();

            var collections = new List<PersistedCollection>();

            while (collectionsQuery.HasMoreResults)
            {
                var response = await collectionsQuery.ExecuteNextAsync<PersistedCollection>();
                collections.AddRange(response);
            }

            return collections.Any() ? collections : null;
        }

        public async Task<ResourceResponse<Document>> UpdateCollectionAsync(PersistedCollection collection)
        {
            var documentUri = DocumentDBHelper.CreateCollectionDocumentUri(collection.CollectionId);

            var client = DocumentDBClient.CreateDocumentClient();

            if (client == null)
                return null;

            var response = await client.ReplaceDocumentAsync(documentUri, collection);

            return response;
        }
    }
}
