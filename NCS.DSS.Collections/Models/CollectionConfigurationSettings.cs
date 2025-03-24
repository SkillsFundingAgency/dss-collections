namespace NCS.DSS.Collections.Models
{
    public class CollectionConfigurationSettings
    {
        public required string Key { get; set; }
        public required string Endpoint { get; set; }
        public required string QueueName { get; set; }
        public required string ServiceBusConnectionString { get; set; }
        public required string CollectionDatabaseId { get; set; }
        public required string CollectionCollectionId { get; set; }
        public required string CEQueueName { get; set; }
        public required string DCContainerName { get; set; }
        public required string DCQueueName_In { get; set; }
        public required string DCQueueName_Out { get; set; }
        public required string StorageConnectionString { get; set; }
    }
}