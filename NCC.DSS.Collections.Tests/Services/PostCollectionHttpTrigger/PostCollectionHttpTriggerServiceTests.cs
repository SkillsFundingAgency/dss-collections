using DFC.HTTP.Standard;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using NCC.DSS.Collections.Tests.Helpers;
using NCS.DSS.Collections.ContentExtractors;
using NCS.DSS.Collections.PostCollectionHttpTrigger.Service;
using NCS.DSS.Collections.Validators;
using System.Net.Http;

namespace NCC.DSS.Collections.Tests.Services.PostCollectionHttpTrigger
{

    [TestClass]    
    public class PostCollectionHttpTriggerServiceTests
    {        
        [TestMethod]
        public void PostCollectionHttpTriggerService_Creation_Test()
        {
            //Assign
            ICollectionValidator mockValidator = MockingHelper.GetMockValidator();
            ICollectionExtractor mockExtractor = MockingHelper.GetMockExtractor();
            IHttpRequestHelper mockRequestHelper = MockingHelper.GetHttpRequestHelper();

            //Act
            IPostCollectionHttpTriggerService postCollectionHttpTriggerService = new PostCollectionHttpTriggerService(mockValidator, mockExtractor, mockRequestHelper);

            //Assert
            Assert.IsNotNull(postCollectionHttpTriggerService);
        }

        [TestMethod]
        public void PostCollectionHttpTriggerService_Process_Test()
        {
            //Assign
            ICollectionValidator mockValidator = MockingHelper.GetMockValidator();
            ICollectionExtractor mockExtractor = MockingHelper.GetMockExtractor();
            IHttpRequestHelper mockrequestHelper = MockingHelper.GetHttpRequestHelper();

            //Act
            IPostCollectionHttpTriggerService postCollectionHttpTriggerService = new PostCollectionHttpTriggerService(mockValidator, mockExtractor, mockrequestHelper);
            OkObjectResult result = postCollectionHttpTriggerService.ProcessRequest(new HttpRequestMessage()).Result as OkObjectResult;

            //Assert
            Assert.IsNotNull(result);
            Assert.AreEqual("Not Implemented", result.Value);
            Assert.AreEqual(200, result.StatusCode);
        }
    }
}
