using Microsoft.Azure.ServiceBus;
using NCS.DSS.Collections.Models;
using Newtonsoft.Json;
using System;
using System.Text;

namespace NCS.DSS.Collections.ServiceBus.Messages.ContentEnhancer
{
    public class ContentEnhancerMessageProvider : IContentEnhancerMessageProvider
    {
        public Message MakeMessage(Collection collection, string reqUrl)
        {          
            return new Message(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(new MessageModel()
            {
                TitleMessage = "Collection report avvailable for {" + collection.CollectionId + "} at " + DateTime.UtcNow,
                CustomerGuid = collection.CollectionId,
                LastModifiedDate = collection.LastModifiedDate,
                URL = reqUrl,
                IsNewCustomer = false,
                TouchpointId = collection.TouchPointId.ToString()
            })))
            {
                ContentType = "application/json",
                MessageId = collection.CollectionId + " " + DateTime.UtcNow
            };            
        }
    }
}
