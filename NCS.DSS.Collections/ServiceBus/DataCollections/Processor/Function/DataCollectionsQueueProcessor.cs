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
        private ILogger<DataCollectionsQueueProcessor> _logger;

        public DataCollectionsQueueProcessor(IDataCollectionsQueueProcessorService dataCollectionsQueueProcessorService, ILogger<DataCollectionsQueueProcessor> logger)
        {
            _dataCollectionsQueueProcessorService = dataCollectionsQueueProcessorService;
            _logger = logger;
        }

        [Function("DataCollectionsQueueProcessor")]
        public async Task RunAsync([ServiceBusTrigger(_dataCollectionsQueueName, Connection = _dataCollectionsConnectionString)] MessageCrossLoadToNCSDto message)
        {            
            _logger.LogInformation("Function {FunctionName} has been invoked", nameof(DataCollectionsQueueProcessor));
            var correlationId = Guid.NewGuid();

            try
            {
                if (message == null)
                {
                    _logger.LogWarning("Message cannot be null. Correlation ID: {CorrelationId}", correlationId);
                    return;
                }

                _logger.LogInformation("Attempting to process queue message. Correlation ID: {CorrelationId}", correlationId);
                await _dataCollectionsQueueProcessorService.ProcessMessageAsync(message);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An exception has occurred. Correlation ID: {CorrelationId} Message: {Message} StackTrace: {StackTrace}", correlationId, ex.Message, ex.StackTrace);
                throw;
            }
            finally
            {                
                _logger.LogInformation("Function {FunctionName} has finished invoking", nameof(DataCollectionsQueueProcessor));
            }
        }
    }
}
