using DFC.Common.Standard.Logging;
using DFC.HTTP.Standard;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using NCC.DSS.Collections.Tests.Helpers;
using NCS.DSS.Collections.DataStore;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.PostCollectionHttpTrigger.Service;
using NCS.DSS.Collections.Validators;
using System;

namespace NCC.DSS.Collections.Tests.Services.PostCollectionHttpTrigger
{

    [TestClass]    
    public class PostCollectionHttpTriggerServiceTests
    {        
        [TestMethod]
        public void PostCollectionHttpTriggerService_Creation_Test()
        {
            //Assign     
            IPostCollectionHttpTriggerService postCollectionHttpTriggerService = new PostCollectionHttpTriggerService(null, null, null, null);

            //Assert
            Assert.IsNotNull(postCollectionHttpTriggerService);
        }

        [TestMethod]
        public void PostCollectionHttpTriggerService_Process_Test_Success()
        {
            //Assign                                  
            ILoggerHelper mockLoggingHelper = MockingHelper.GetMockLoggerHelper();

            Collection testCollection = new Collection()
            {
                CollectionId = Guid.NewGuid(),
                TouchPointId = Guid.NewGuid(),
                LastModifiedDate = DateTime.Now,
                UKPRN = "12312345"
            };                  

            //Act
            IPostCollectionHttpTriggerService postCollectionHttpTriggerService = new PostCollectionHttpTriggerService(new CollectionValidator(), new HttpRequestHelper(), new LoggerHelper(), new CollectionDataStore());
            var result = postCollectionHttpTriggerService.ProcessRequestAsync(testCollection).Result;

            //Assert
            Assert.IsNotNull(result);
            Assert.AreEqual(true, result);            
        }       
    }
}
