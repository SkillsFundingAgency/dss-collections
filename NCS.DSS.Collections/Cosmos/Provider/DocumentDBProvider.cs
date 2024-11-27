using Microsoft.Azure.Cosmos;
using NCS.DSS.Collections.Models;

namespace NCS.DSS.Collections.Cosmos.Provider
{
    public class DocumentDBProvider : IDocumentDBProvider
    {
        private readonly Container _container;
        private readonly string _databaseId = Environment.GetEnvironmentVariable("CollectionDatabaseId");
        private readonly string _containerId = Environment.GetEnvironmentVariable("CollectionCollectionId");

        public DocumentDBProvider(CosmosClient cosmosClient)
        {
            _container = cosmosClient.GetContainer(_databaseId, _containerId);
        }

        public async Task<ItemResponse<PersistedCollection>> CreateCollectionAsync(PersistedCollection collection)
        {
            ItemResponse<PersistedCollection> response = await _container.CreateItemAsync(collection);

            return response;
        }

        public async Task<PersistedCollection> GetCollectionAsync(Guid collectionId)
        {
            string queryText = $"SELECT TOP 1 * FROM c Where c.id = '{collectionId}'";
            QueryDefinition queryDefinition = new QueryDefinition(queryText);

            PersistedCollection collection = null;
            using (FeedIterator<PersistedCollection> iterator = _container.GetItemQueryIterator<PersistedCollection>(queryDefinition))
            {
                while (iterator.HasMoreResults)
                {
                    var response = await iterator.ReadNextAsync();
                    collection = response.FirstOrDefault();
                }
            }

            return collection;
        }

        public async Task<PersistedCollection> GetCollectionForTouchpointAsync(string touchPointId, Guid collectionId)
        {
            string queryText = $"SELECT TOP 1 * FROM c Where c.TouchPointId = '{touchPointId}' and c.id = '{collectionId}'";
            QueryDefinition queryDefinition = new QueryDefinition(queryText);

            PersistedCollection collection = null;
            using (FeedIterator<PersistedCollection> iterator = _container.GetItemQueryIterator<PersistedCollection>(queryDefinition))
            {
                while (iterator.HasMoreResults)
                {
                    var response = await iterator.ReadNextAsync();
                    collection = response.FirstOrDefault();
                }
            }

            return collection;
        }

        public async Task<List<PersistedCollection>> GetCollectionsForTouchpointAsync(string touchpointId)
        {
            string queryText = $"SELECT * FROM c Where c.TouchPointId = '{touchpointId}'";
            QueryDefinition queryDefinition = new QueryDefinition(queryText);

            var collections = new List<PersistedCollection>();

            using (FeedIterator<PersistedCollection> iterator = _container.GetItemQueryIterator<PersistedCollection>(queryDefinition))
            {
                while (iterator.HasMoreResults)
                {
                    var response = await iterator.ReadNextAsync();
                    collections.AddRange(response);
                }
            }

            return collections.Any() ? collections : null;
        }

        public async Task<ItemResponse<PersistedCollection>> UpdateCollectionAsync(PersistedCollection collection)
        {
            var response = await _container.ReplaceItemAsync(collection, collection.CollectionId.ToString());
            return response;
        }
    }
}