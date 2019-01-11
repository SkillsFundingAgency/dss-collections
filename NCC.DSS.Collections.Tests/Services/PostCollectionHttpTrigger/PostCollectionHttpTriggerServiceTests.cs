using DFC.HTTP.Standard;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using NCC.DSS.Collections.Tests.Helpers;
using NCS.DSS.Collections.ContentExtractors;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.PostCollectionHttpTrigger.Service;
using NCS.DSS.Collections.Validators;
using Newtonsoft.Json;
using System;
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
        public void PostCollectionHttpTriggerService_Process_Test_Success()
        {
            //Assign
            ICollectionValidator mockValidator = new CollectionValidator();
            ICollectionExtractor mockExtractor = new CollectionExtractor();
            IHttpRequestHelper mockrequestHelper = new HttpRequestHelper();
            Collection testCollection = new Collection()
            {
                CollectionId = Guid.NewGuid(),
                TouchPointId = Guid.NewGuid(),
                LastModifiedDate = DateTime.Now,
                UKPRN = "12312345"
            };

            HttpRequestMessage request = new HttpRequestMessage()
            {
                Content = new StringContent(JsonConvert.SerializeObject(testCollection))
            };            

            //Act
            IPostCollectionHttpTriggerService postCollectionHttpTriggerService = new PostCollectionHttpTriggerService(mockValidator, mockExtractor, mockrequestHelper);
            OkObjectResult result = postCollectionHttpTriggerService.ProcessRequest(request).Result as OkObjectResult;

            //Assert
            Assert.IsNotNull(result);
            Assert.AreEqual("Not Implemented", result.Value);
            Assert.AreEqual(200, result.StatusCode);
        }

        [TestMethod]
        public void PostCollectionHttpTriggerService_Process_Test_Fail()
        {
            //Assign
            ICollectionValidator mockValidator = new CollectionValidator();
            ICollectionExtractor mockExtractor = new CollectionExtractor();
            IHttpRequestHelper mockrequestHelper = new HttpRequestHelper();
            Collection testCollection = new Collection()
            {
                CollectionId = new Guid(),
                TouchPointId = Guid.NewGuid(),
                LastModifiedDate = DateTime.Now,
                UKPRN = "12312345"
            };

            HttpRequestMessage request = new HttpRequestMessage()
            {
                Content = new StringContent(JsonConvert.SerializeObject(testCollection))
            };

            //Act
            IPostCollectionHttpTriggerService postCollectionHttpTriggerService = new PostCollectionHttpTriggerService(mockValidator, mockExtractor, mockrequestHelper);
            OkObjectResult result = postCollectionHttpTriggerService.ProcessRequest(request).Result as OkObjectResult;

            //Assert
            Assert.IsNull(result);                        
        }
    }
}
