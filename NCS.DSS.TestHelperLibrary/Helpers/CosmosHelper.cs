using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using Microsoft.Azure.Documents;
using Microsoft.Azure.Documents.Client;
using Newtonsoft.Json;

namespace NCS.DSS.TestHelperLibrary.Helpers
{
    public static class CosmosHelper
    {
        //Reusable instance of DocumentClient which represents the connection to a DocumentDB endpoint
        private static DocumentClient client;
       // public static string BaseUrl { get; set; }
       // public static string AutorizationKey { get; set; }



        public static bool Initialise(string baseUrl, string authKey)
        {
            try
            {
                client = new DocumentClient(new Uri(baseUrl), authKey);
                return true;
            }
            catch (DocumentClientException de)
            {
                Exception baseException = de.GetBaseException();
                Console.WriteLine("{0} error occurred: {1}, Message: {2}", de.StatusCode, de.Message, baseException.Message);
            }
            return false;
        }

        public static bool DeleteDocument( string database, string collection, string id)
        {
            try
            {
                client.DeleteDocumentAsync(UriFactory.CreateDocumentUri(database, collection, id)).GetAwaiter().GetResult();
                return true;
            }
            catch (DocumentClientException de)
            {   
                Exception baseException = de.GetBaseException();
                Console.WriteLine("{0} error occurred: {1}, Message: {2}", de.StatusCode, de.Message, baseException.Message);
            }
            return false;
        }

		public static bool InsertDocumentFromJson(string database, string collection, string json, out string response)
		{
            dynamic obj = JsonConvert.DeserializeObject(json);
            return InsertDocumentFromJson<dynamic>(database, collection, obj, out response);
            bool returnValue = true;
            try
            {
                dynamic doc = JsonConvert.DeserializeObject(json);
                var returnDoc = client.CreateDocumentAsync(UriFactory.CreateDocumentCollectionUri(database, collection), doc).GetAwaiter().GetResult();
                var res = returnDoc.Resource;
                response = res.ToString();
            }
            catch (DocumentClientException de)
            {
                Exception baseException = de.GetBaseException();
                Console.WriteLine("{0} error occurred: {1}, Message: {2}", de.StatusCode, de.Message, baseException.Message);
                response = "";
                returnValue = false;
            }
            return returnValue;
		
		}

        public static bool InsertDocumentFromJson<T>(string database, string collection, T obj, out string response)
        {
            bool returnValue = true;
            try
            {
                var returnDoc = client.CreateDocumentAsync(UriFactory.CreateDocumentCollectionUri(database, collection), obj).GetAwaiter().GetResult();
                var res = returnDoc.Resource;
                response = res.ToString();
            }
            catch (DocumentClientException de)
            {
                Exception baseException = de.GetBaseException();
                Console.WriteLine("{0} error occurred: {1}, Message: {2}", de.StatusCode, de.Message, baseException.Message);
                response = "";
                returnValue = false;
            }
            return returnValue;

        }

        public static Document RetrieveDocument(string database, string collection, string id)
        {
            Document doc =  client.CreateDocumentQuery(
                UriFactory.CreateDocumentCollectionUri(database, collection))
                          .Where(x =>  x.Id == id.ToString() )
                          .AsEnumerable()
                          .First();
            return doc;
        }

        public static bool UpdateDocument(string database, string collection, string id, Dictionary <string, string> updateFields)
        {
            // first of all retreive the document
            var doc = RetrieveDocument(database, collection, id);

            foreach ( var item in updateFields)
            {
                doc.SetPropertyValue(item.Key, item.Value);
            }
            // update doc
            
            //doc.GetType().GetProperty(property).SetValue(doc, newValue);

            var updated = client.ReplaceDocumentAsync(UriFactory.CreateDocumentUri(database, collection, id.ToString()), doc).Result.Resource;

            return true;
        }

        public static bool UpsertDocument<T>(string database, string collection, T document)
        {
            var collectionLink = UriFactory.CreateDocumentCollectionUri(database, collection);
            var ret = client.UpsertDocumentAsync(collectionLink, document).GetAwaiter().GetResult();
            return true;
        }
    }
}
