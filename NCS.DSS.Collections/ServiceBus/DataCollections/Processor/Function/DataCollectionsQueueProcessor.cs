using DFC.Common.Standard.Logging;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.ServiceBus.DataCollections.Messages;
using NCS.DSS.Collections.ServiceBus.Processor.Service;
using System;
using System.Threading.Tasks;

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


        [Function("DataCollectionsQueueProcessor")]
        public async Task RunAsync([ServiceBusTrigger(_dataCollectionsQueueName,
                                                Connection = _dataCollectionsConnectionString)]
            MessageCrossLoadToNCSDto message,
                                                ILogger log)
        {
            _loggerHelper.LogMethodEnter(log);

            var correlationId = Guid.NewGuid();

            try
            {
                if (message == null)
                {
                    _loggerHelper.LogError(log, correlationId, new NullReferenceException("Message cannot be null"));
                    return;
                }

                _loggerHelper.LogInformationMessage(log, correlationId, "Attempting to process message");
                await _dataCollectionsQueueProcessorService.ProcessMessageAsync(message, log);
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
