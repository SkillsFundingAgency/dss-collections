using System;
using System.Threading.Tasks;
using DFC.Common.Standard.Logging;
using Microsoft.Azure.WebJobs;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.ServiceBus.Processor.Service;

namespace NCS.DSS.Collections.ServiceBus.DataCollections.Processor.Function
{
    public class DataCollectionsQueueProcessor
    {
        private const string _dataCollectionsQueueName = "%DCQueueName_In%";
        private const string _dataCollectionsConnectionString = "ServiceBusConnectionString";
        private IDataCollectionsQueueProcessorService _dataCollectionsQueueProcessorService;
        private ILoggerHelper _loggerHelper;

        public DataCollectionsQueueProcessor(IDataCollectionsQueueProcessorService dataCollectionsQueueProcessorService, ILoggerHelper loggerHelper)
        {
            _dataCollectionsQueueProcessorService = dataCollectionsQueueProcessorService;
            _loggerHelper = loggerHelper;
        }

        
        [FunctionName("DataCollectionsQueueProcessor")]
        public async Task RunAsync([ServiceBusTrigger(_dataCollectionsQueueName,
                                                Connection = _dataCollectionsConnectionString)]
                                                string queueItem,
                                                ILogger log)
        {
            _loggerHelper.LogMethodEnter(log);

            var correlationId = Guid.NewGuid();

            try
            {
                if (queueItem == null)
                {
                    _loggerHelper.LogError(log, correlationId, new NullReferenceException("Message cannot be null"));
                    return;
                }

                _loggerHelper.LogInformationMessage(log, correlationId, "Attempting to process message");
                await _dataCollectionsQueueProcessorService.ProcessMessageAsync(queueItem, log);
            }
            catch (Exception ex)
            {
                _loggerHelper.LogException(log, correlationId, ex);
                throw;
            }
            finally
            {
                _loggerHelper.LogMethodExit(log);
            }
        }
    }
}
