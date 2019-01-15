using DFC.Common.Standard.Logging;
using DFC.HTTP.Standard;
using DFC.JSON.Standard;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using NCC.DSS.Collections.Tests.Helpers;
using NCS.DSS.Collections.DataStore;
using NCS.DSS.Collections.GetCollectionsHttpTrigger.Service;
using NCS.DSS.Collections.Models;
using System.Collections.Generic;

namespace NCC.DSS.Collections.Tests.Services.GetCollectionsHttpTrigger
{
    [TestClass]
    public class GetCollectionsHttpTriggerServiceTests
    {
        [TestMethod]
        public void GetCollectionsHttpTriggerService_Create_Test()
        {
            //Assign            
            IGetCollectionsHttpTriggerService getCollectionsHttpTriggerService = new GetCollectionsHttpTriggerService(new HttpRequestHelper(), new LoggerHelper(), new CollectionDataStore());

            //Act
            Assert.IsNotNull(getCollectionsHttpTriggerService);
        }

        [TestMethod]
        public void GetCollectionsHttpTriggerService_Process_Test()
        {
            //Assign            
            IHttpRequestHelper requestHelper = new HttpRequestHelper();
            IHttpResponseMessageHelper responseMessageHelper = new HttpResponseMessageHelper();
            ILoggerHelper mockLoggerHelper = MockingHelper.GetMockLoggerHelper();
            IJsonHelper jsonHelper = new JsonHelper();

            IGetCollectionsHttpTriggerService service = new GetCollectionsHttpTriggerService(new HttpRequestHelper(), new LoggerHelper(), new CollectionDataStore());

            //Act
            IEnumerable<Collection> result = service.ProcessRequestAsync().Result;

            //Assert
            Assert.IsNotNull(service);
            Assert.IsNotNull(result);            
        }
    }
}
