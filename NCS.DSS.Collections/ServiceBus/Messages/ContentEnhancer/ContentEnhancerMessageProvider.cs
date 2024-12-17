using Azure.Messaging.ServiceBus;
using NCS.DSS.Collections.Models;
using Newtonsoft.Json;
using System.Text;

namespace NCS.DSS.Collections.ServiceBus.Messages.ContentEnhancer
{
    public class ContentEnhancerMessageProvider : IContentEnhancerMessageProvider
    {
        public ServiceBusMessage MakeMessage(Collection collection)
        {
            return new ServiceBusMessage(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(new MessageModel()
            {
                DataCollections = true,
                CustomerGuid = Guid.Empty,
                LastModifiedDate = collection.LastModifiedDate,
                URL = collection.CollectionReports.AbsoluteUri,
                TouchpointId = collection.TouchPointId,
                IsNewCustomer = false,
                TitleMessage = $"Data Collections report available - CollectionId - {collection.CollectionId}"
            })))
            {
                ContentType = "application/json",
                MessageId = collection.CollectionId + " " + DateTime.UtcNow
            };
        }
    }
}
