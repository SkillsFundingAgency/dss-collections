using DFC.HTTP.Standard;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using NCC.DSS.Collections.Tests.Helpers;
using NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service;
using System.Net.Http;

namespace NCC.DSS.Collections.Tests.Services.GetCollectionByIdHtppTrigger
{
    [TestClass]
    public class GetCollectionByIdHtppTriggerServiceTests
    {
        [TestMethod]
        public void GetCollectionByIdHtppTriggerService_Create_Test()
        {
            //Assign
            IHttpRequestHelper mockRequestHelper = MockingHelper.GetHttpRequestHelper();
            IGetCollectionByIdHtppTriggerService getCollectionByIdHtppTriggerService = new GetCollectionByIdHtppTriggerService(mockRequestHelper);

            //Assert
            Assert.IsNotNull(getCollectionByIdHtppTriggerService);
        }

        [TestMethod]
        public void GetCollectionByIdHtppTriggerService_Process_Test()
        {
            //Assign
            IHttpRequestHelper mockRequestHelper = MockingHelper.GetHttpRequestHelper();
            IGetCollectionByIdHtppTriggerService getCollectionByIdHtppTriggerService = new GetCollectionByIdHtppTriggerService(mockRequestHelper);

            //Act
            OkObjectResult result = getCollectionByIdHtppTriggerService.ProcessRequest(new HttpRequestMessage()).Result as OkObjectResult;

            //Assert
            Assert.IsNotNull(getCollectionByIdHtppTriggerService);
            Assert.AreEqual("Not Implemented", result.Value);
            Assert.AreEqual(200, result.StatusCode);
        }
    }
}
