using DFC.HTTP.Standard;
using Microsoft.Extensions.Logging;
using Moq;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.Storage;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Assert = NUnit.Framework.Assert;

namespace NCC.DSS.Collections.Tests.Services.GetCollectionByIdHtppTrigger
{
    [TestFixture]
    public class GetCollectionByIdHtppTriggerServiceTests
    {
        private IHttpRequestHelper _requestHelper;
        private IDocumentDBProvider _documentDBProvider;
        private IDCBlobStorage _storage;
        private ILogger _logger;
        private PersistedCollection _collection;
        private List<PersistedCollection> _collections;
        private string _touchPointId;
        private Guid _collectionId;

        [SetUp]
        public void Setup()
        {
            _requestHelper = new HttpRequestHelper();
            _documentDBProvider = MockingHelper.GetMockDBProvider();
            _logger = Substitute.For<ILogger>();
            _collection = Substitute.For<PersistedCollection>();
            _collections = Substitute.For<List<PersistedCollection>>();
            _touchPointId = "9000000000";
            _collectionId = Guid.NewGuid();
            _storage = Substitute.For<IDCBlobStorage>();
        }
        [Test]
        public void GetCollectionByIdHtppTriggerService_Create_Test()
        {                        
            //Act
            IGetCollectionByIdHtppTriggerService service = new GetCollectionByIdHtppTriggerService(_documentDBProvider, _storage);            

            //Assert
            Assert.IsNotNull(service);
        }

        [Test]
        public void GetCollectionByIdHttpTriggerService_Process_Test()
        {
            //Assign           
            _documentDBProvider.DoesCollectionResourceExist(_collection).Returns<bool>(true);            
            _documentDBProvider.GetCollectionForTouchpointAsync(_touchPointId, _collectionId).Returns(Task.FromResult(_collection).Result);

            //Act
            IGetCollectionByIdHtppTriggerService service = new GetCollectionByIdHtppTriggerService(_documentDBProvider, _storage);
            var result = service.ProcessRequestAsync(_touchPointId, _collectionId, _logger);

            //Assert
            Assert.IsNotNull(service);
            Assert.IsNotNull(result);
        }        
    }
}
