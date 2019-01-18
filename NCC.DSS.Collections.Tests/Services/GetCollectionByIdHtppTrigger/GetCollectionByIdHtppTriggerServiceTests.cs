using DFC.Common.Standard.Logging;
using DFC.HTTP.Standard;
using DFC.JSON.Standard;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using NCS.DSS.Collections.DataStore;
using NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service;
using NCS.DSS.Collections.Models;
using System;

namespace NCC.DSS.Collections.Tests.Services.GetCollectionByIdHtppTrigger
{
    [TestClass]
    public class GetCollectionByIdHtppTriggerServiceTests
    {
        [TestMethod]
        public void GetCollectionByIdHtppTriggerService_Create_Test()
        {
            //Assign
            IHttpRequestHelper requestHelper = new HttpRequestHelper();
            IHttpResponseMessageHelper responseMessageHelper = new HttpResponseMessageHelper();
            ILoggerHelper loggerHelper = new LoggerHelper();
            IJsonHelper jsonHelper = new JsonHelper();
            ICollectionDataStore collectionDataStore = new CollectionDataStore();

            IGetCollectionByIdHtppTriggerService service = new GetCollectionByIdHtppTriggerService(requestHelper, responseMessageHelper, loggerHelper, jsonHelper, collectionDataStore);            

            //Assert
            Assert.IsNotNull(service);
        }

        [TestMethod]
        public void GetCollectionByIdHtppTriggerService_Process_Test()
        {
            //Assign            
            IHttpRequestHelper requestHelper = new HttpRequestHelper();
            IHttpResponseMessageHelper responseMessageHelper = new HttpResponseMessageHelper();
            ILoggerHelper loggerHelper = new LoggerHelper();
            IJsonHelper jsonHelper = new JsonHelper();
            ICollectionDataStore collectionDataStore = new CollectionDataStore();

            IGetCollectionByIdHtppTriggerService getCollectionByIdHtppTriggerService = new GetCollectionByIdHtppTriggerService(requestHelper, responseMessageHelper, loggerHelper, jsonHelper, collectionDataStore);

            //Act
            var result = getCollectionByIdHtppTriggerService.ProcessRequestAsync(Guid.NewGuid(), Guid.NewGuid()).Result;

            //Assert
            Assert.IsNotNull(getCollectionByIdHtppTriggerService);
            Assert.IsNotNull(result);
            Assert.AreEqual(typeof(Collection), result.GetType());
        }
    }
}
