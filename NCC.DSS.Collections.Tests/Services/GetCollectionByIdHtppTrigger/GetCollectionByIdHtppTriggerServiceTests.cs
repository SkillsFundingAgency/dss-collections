using DFC.Common.Standard.Logging;
using DFC.HTTP.Standard;
using DFC.JSON.Standard;
using Microsoft.AspNetCore.Http;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using NCC.DSS.Collections.Tests.Helpers;
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
            ILoggerHelper mockLoggerHelper = MockingHelper.GetMockLoggerHelper();
            IJsonHelper jsonHelper = new JsonHelper();
            ICollectionDataStore mockDataStore = MockingHelper.GetMockCollectionDataStore(); 
            IGetCollectionByIdHtppTriggerService service = new GetCollectionByIdHtppTriggerService(requestHelper, responseMessageHelper, mockLoggerHelper, jsonHelper, mockDataStore);

            //Assert
            Assert.IsNotNull(service);
        }

        [TestMethod]
        public void GetCollectionByIdHtppTriggerService_Process_Test()
        {
            //Assign            
            IHttpRequestHelper requestHelper = new HttpRequestHelper();
            IHttpResponseMessageHelper responseMessageHelper = new HttpResponseMessageHelper();
            ILoggerHelper mockLoggerHelper = MockingHelper.GetMockLoggerHelper();
            IJsonHelper jsonHelper = new JsonHelper();
            ICollectionDataStore dataStore = new CollectionDataStore();
            IGetCollectionByIdHtppTriggerService getCollectionByIdHtppTriggerService = new GetCollectionByIdHtppTriggerService(requestHelper, responseMessageHelper, mockLoggerHelper, jsonHelper, dataStore);

            //Act
            var result = getCollectionByIdHtppTriggerService.ProcessRequestAsync(Guid.NewGuid().ToString()).Result;

            //Assert
            Assert.IsNotNull(getCollectionByIdHtppTriggerService);
            Assert.IsNotNull(result);
            Assert.AreEqual(typeof(Collection), result.GetType());
        }
    }
}
