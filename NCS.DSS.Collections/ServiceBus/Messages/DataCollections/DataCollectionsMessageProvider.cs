﻿using Azure.Messaging.ServiceBus;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.ServiceBus.DataCollections.Messages;
using Newtonsoft.Json;
using System.Globalization;
using System.Text;

namespace NCS.DSS.Collections.ServiceBus.Messages.DataCollections
{
    public class DataCollectionsMessageProvider : IDataCollectionsMessageProvider
    {
        public MessageCrossLoadToNCSDto DeserializeMessage(string message)
        {
            return JsonConvert.DeserializeObject<MessageCrossLoadToNCSDto>(message);
        }

        public ServiceBusMessage MakeMessage(PersistedCollection collection)
        {
            return new ServiceBusMessage(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(new MessageCrossLoadFromNCSDto
            {
                ContainerName = collection.ContainerName,
                JobId = collection.CollectionId,
                ReportFilename = collection.ReportFileName,
                Timestamp = DateTime.UtcNow.ToString("yyyy-MM-dd HH:mm:ss.fff", CultureInfo.InvariantCulture),
                TouchpointId = collection.TouchPointId,
                Ukprn = int.Parse(collection.Ukprn)
            })))
            {
                ContentType = "application/json",
                MessageId = $"{collection.CollectionId} {DateTime.UtcNow}"
            };
        }
    }
}
