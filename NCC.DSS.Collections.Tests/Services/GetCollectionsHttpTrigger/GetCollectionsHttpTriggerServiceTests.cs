using DFC.HTTP.Standard;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using NCC.DSS.Collections.Tests.Helpers;
using NCS.DSS.Collections.GetCollectionsHttpTrigger.Service;
using System.Net.Http;

namespace NCC.DSS.Collections.Tests.Services.GetCollectionsHttpTrigger
{
    [TestClass]
    public class GetCollectionsHttpTriggerServiceTests
    {
        [TestMethod]
        public void GetCollectionsHttpTriggerService_Create_Test()
        {
            //Assign
            IHttpRequestHelper mockRequestHelper = MockingHelper.GetHttpRequestHelper();
            IGetCollectionsHttpTriggerService getCollectionsHttpTriggerService = new GetCollectionsHttpTriggerService(mockRequestHelper);

            //Act
            Assert.IsNotNull(getCollectionsHttpTriggerService);
        }

        [TestMethod]
        public void GetCollectionsHttpTriggerService_Process_Test()
        {
            //Assign
            IHttpRequestHelper mockRequestHelper = MockingHelper.GetHttpRequestHelper();
            IGetCollectionsHttpTriggerService getCollectionByIdHtppTriggerService = new GetCollectionsHttpTriggerService(mockRequestHelper);

            //Act
            OkObjectResult result = getCollectionByIdHtppTriggerService.ProcessRequest(new HttpRequestMessage()).Result as OkObjectResult;

            //Assert
            Assert.IsNotNull(getCollectionByIdHtppTriggerService);
            Assert.AreEqual("Not Implemented", result.Value);
            Assert.AreEqual(200, result.StatusCode);
        }
    }
}
