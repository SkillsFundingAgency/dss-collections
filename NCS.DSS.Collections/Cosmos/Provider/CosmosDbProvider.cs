using Microsoft.Azure.Cosmos;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using NCS.DSS.Collections.Models;

namespace NCS.DSS.Collections.Cosmos.Provider
{
    public class CosmosDbProvider : ICosmosDbProvider
    {
        private readonly Container _container;

        private readonly ILogger<CosmosDbProvider> _logger;

        public CosmosDbProvider(CosmosClient cosmosClient, IOptions<CollectionConfigurationSettings> configOptions, ILogger<CosmosDbProvider> logger)
        {
            var config = configOptions.Value;
            _container = cosmosClient.GetContainer(config.CollectionDatabaseId, config.CollectionCollectionId);
            _logger = logger;
        }

        public async Task<ItemResponse<PersistedCollection>> CreateCollectionAsync(PersistedCollection collection)
        {
            _logger.LogInformation("Creating Collection. Collection ID: {CollectionId}", collection.CollectionId);

            ItemResponse<PersistedCollection> response = await _container.CreateItemAsync(collection);

            _logger.LogInformation("Finished creating Collection. Collection ID: {CollectionId}", collection.CollectionId);

            return response;
        }

        public async Task<PersistedCollection> GetCollectionAsync(Guid collectionId)
        {
            _logger.LogInformation("Retrieving Collection. Collection ID: {CollectionId}.", collectionId);

            string queryText = $"SELECT TOP 1 * FROM c Where c.id = '{collectionId}'";
            QueryDefinition queryDefinition = new QueryDefinition(queryText);

            PersistedCollection collection = null;
            using (FeedIterator<PersistedCollection> iterator = _container.GetItemQueryIterator<PersistedCollection>(queryDefinition))
            {
                while (iterator.HasMoreResults)
                {
                    var response = await iterator.ReadNextAsync();

                    _logger.LogInformation("Successfully retrieved Collection. Collection ID: {CollectionId}.", collectionId);
                    collection = response.FirstOrDefault();
                }
            }
            return collection;
        }

        public async Task<PersistedCollection> GetCollectionForTouchpointAsync(string touchPointId, Guid collectionId)
        {
            _logger.LogInformation("Retrieving Collection for Touchpoint. Collection ID: {CollectionId} Touchpoint: {TouchPointId}.", collectionId, touchPointId);

            string queryText = $"SELECT TOP 1 * FROM c Where c.TouchPointId = '{touchPointId}' and c.id = '{collectionId}'";
            QueryDefinition queryDefinition = new QueryDefinition(queryText);

            PersistedCollection collection = null;
            using (FeedIterator<PersistedCollection> iterator = _container.GetItemQueryIterator<PersistedCollection>(queryDefinition))
            {
                while (iterator.HasMoreResults)
                {
                    var response = await iterator.ReadNextAsync();

                    _logger.LogInformation("Successfully retrieved Collection for Touchpoint. Collection ID: {CollectionId} Touchpoint: {TouchPointId}.", collectionId, touchPointId);
                    collection = response.FirstOrDefault();
                }
            }

            return collection;
        }

        public async Task<List<PersistedCollection>> GetCollectionsForTouchpointAsync(string touchPointId)
        {
            _logger.LogInformation("Retrieving Collections for Touchpoint. Touchpoint: {TouchPointId}.", touchPointId);

            string queryText = $"SELECT * FROM c Where c.TouchPointId = '{touchPointId}'";
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

            if (collections.Count == 0)
            {
                _logger.LogInformation("No collection found for Touchpoint. Touchpoint: {TouchPointId}.", touchPointId);
            }

            _logger.LogInformation("Successfully retrieved Collections for Touchpoint. Touchpoint: {TouchPointId}.", touchPointId);
            return collections;
        }

        public async Task<ItemResponse<PersistedCollection>> UpdateCollectionAsync(PersistedCollection collection)
        {
            _logger.LogInformation("Updating Collection. Collection ID: {CollectionId}", collection.CollectionId);

            var response = await _container.ReplaceItemAsync(collection, collection.CollectionId.ToString());

            _logger.LogInformation("Finished updating Collection. Collection ID: {CollectionId}", collection.CollectionId);

            return response;
        }
    }
}