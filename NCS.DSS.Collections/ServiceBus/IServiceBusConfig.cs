namespace NCS.DSS.Collections.ServiceBus
{
    public interface IServiceBusConfig
    {
        string QueueName { get; }
        string ServiceBusConnectionString { get; }
    }
}
