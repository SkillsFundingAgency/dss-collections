using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.ServiceBus.DataCollections.Messages;
using NCS.DSS.Collections.ServiceBus.Processor.Service;

namespace NCS.DSS.Collections.ServiceBus.DataCollections.Processor.Function
{
    public class DataCollectionsQueueProcessor
    {
        private const string _dataCollectionsQueueName = "%DCQueueName_In%";
        private const string _dataCollectionsConnectionString = "ServiceBusConnectionString";
        private IDataCollectionsQueueProcessorService _dataCollectionsQueueProcessorService;
        private ILogger log;

        public DataCollectionsQueueProcessor(IDataCollectionsQueueProcessorService dataCollectionsQueueProcessorService, ILogger<DataCollectionsQueueProcessor> log)
        {
            _dataCollectionsQueueProcessorService = dataCollectionsQueueProcessorService;
            this.log = log;
        }

        [Function("DataCollectionsQueueProcessor")]
        public async Task RunAsync([ServiceBusTrigger(_dataCollectionsQueueName, Connection = _dataCollectionsConnectionString)] MessageCrossLoadToNCSDto message)
        {
            log.LogInformation($"Function {nameof(DataCollectionsQueueProcessor)} has been invoked");
            var correlationId = Guid.NewGuid();

            try
            {
                if (message == null)
                {
                    log.LogError($"Message cannot be null. Correlation ID: {correlationId}");
                    return;
                }

                log.LogInformation($"Attempting to process queue message");
                await _dataCollectionsQueueProcessorService.ProcessMessageAsync(message, log);
            }
            catch (Exception ex)
            {
                log.LogError($"An exception has occurred. Correlation ID: {correlationId}", ex);
                throw;
            }
            finally
            {
                log.LogInformation($"Function {nameof(DataCollectionsQueueProcessor)} has finished invocation");
            }
        }
    }
}
