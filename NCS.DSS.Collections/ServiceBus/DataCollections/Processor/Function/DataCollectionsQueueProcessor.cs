using System;
using System.Threading.Tasks;
using DFC.Common.Standard.Logging;
using DFC.Functions.DI.Standard.Attributes;
using Microsoft.Azure.WebJobs;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.ServiceBus.Processor.Service;

namespace NCS.DSS.Collections.ServiceBus.DataCollections.Processor.Function
{
    public static class DataCollectionsQueueProcessor
    {
        private const string _dataCollectionsQueueName = "%DCQueueName_In%";
        private const string _dataCollectionsConnectionString = "ServiceBusConnectionString";

        [FunctionName("DataCollectionsQueueProcessor")]
        public static async Task RunAsync([ServiceBusTrigger(_dataCollectionsQueueName,
                                                Connection = _dataCollectionsConnectionString)]
                                                string queueItem,
                                                ILogger log,
                                                [Inject]ILoggerHelper loggerHelper,
                                                [Inject]IDataCollectionsQueueProcessorService dataCollectionsQueueProcessorService)
        {
            loggerHelper.LogMethodEnter(log);

            var correlationId = Guid.NewGuid();

            try
            {
                if (queueItem == null)
                {
                    loggerHelper.LogError(log, correlationId, new NullReferenceException("Message cannot be null"));
                    return;
                }

                loggerHelper.LogInformationMessage(log, correlationId, "Attempting to process message");
                await dataCollectionsQueueProcessorService.ProcessMessageAsync(queueItem, log);
            }
            catch (Exception ex)
            {
                loggerHelper.LogException(log, correlationId, ex);
            }
            finally
            {
                loggerHelper.LogMethodExit(log);
            }
        }
    }
}
