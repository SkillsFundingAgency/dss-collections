namespace NCS.DSS.Collections.ServiceBus
{
    public interface IDataCollectionsServiceBusClient
    {
        Task SendPostMessageAsync(Models.PersistedCollection collection);
    }
}
