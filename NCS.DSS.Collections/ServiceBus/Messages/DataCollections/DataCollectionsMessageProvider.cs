using ESFA.DC.CrossLoad.Dto;
using Microsoft.Azure.ServiceBus;
using NCS.DSS.Collections.Models;
using Newtonsoft.Json;
using System;
using System.Text;

namespace NCS.DSS.Collections.ServiceBus.Messages.DataCollections
{
    public class DataCollectionsMessageProvider : IDataCollectionsMessageProvider
    {
        private readonly IDataCollectionsMessageProvider _messageProvider;
        public DataCollectionsMessageProvider(IDataCollectionsMessageProvider messageProvider)
        {
            _messageProvider = messageProvider;
        }

        public MessageCrossLoadDcftToDctDto DeserializeMessage(string message)
        {
            throw new NotImplementedException();
        }

        public Message MakeMessage(Collection collection)
        {
            return new Message(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(new MessageCrossLoadDcftToDctDto
            {
                DcftJobId = collection.CollectionId.ToString()
            })))
            {
                ContentType = "application/json",
                MessageId = collection.CollectionId+ " " + DateTime.UtcNow
            };            
        }
    }
}
