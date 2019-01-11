using Microsoft.VisualStudio.TestTools.UnitTesting;
using NCS.DSS.Collections.ContentExtractors;
using NCS.DSS.Collections.Models;
using Newtonsoft.Json;
using System;
using System.Net.Http;
using System.Text;

namespace NCC.DSS.Collections.Tests.Extractors
{
    [TestClass]
    public class CollectionExtractorTests
    {
        [TestMethod]
        public void CollectionExtractor_Creation_Test()
        {
            //Assign            
            ICollectionExtractor extractor = new CollectionExtractor();

            //Assert
            Assert.IsNotNull(extractor);
        }

        [TestMethod]
        public void CollectionExtractor_Extract_Test_Positive()
        {
            //Assign
            Guid collectionId = Guid.NewGuid();
            Guid touchpointId = Guid.NewGuid();
            DateTime lastmodifedDate = DateTime.Now;
            string ukprn = "12345678";

            ICollectionExtractor extractor = new CollectionExtractor();
            Collection collection = new Collection()
            {
                CollectionId = collectionId,
                TouchPointId = touchpointId,
                LastModifiedDate = lastmodifedDate,
                UKPRN = ukprn
            };

            //Act
            Collection result = extractor.Extract<Collection>(new HttpRequestMessage()
            {
                Content = new StringContent(JsonConvert.SerializeObject(collection),
                    Encoding.UTF8, "application/json")
            }).Result;            

            //Assert
            Assert.IsNotNull(extractor);
            Assert.IsNotNull(result);
            Assert.AreEqual(collectionId, result.CollectionId);
            Assert.AreEqual(touchpointId, result.TouchPointId);
            Assert.AreEqual(lastmodifedDate, result.LastModifiedDate);
            Assert.AreEqual(ukprn, result.UKPRN);
        }        
    }
}
