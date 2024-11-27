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

        private Mock<IDocumentDBProvider> _documentDBProvider;
        private Mock<IDCBlobStorage> _storage;
        private Mock<ILogger<GetCollectionByIdHttpTriggerService>> _logger;
        private Mock<PersistedCollection> _collection;
        private Mock<List<PersistedCollection>> _collections;
        private string _touchPointId;
        private Guid _collectionId;
        private IGetCollectionByIdHttpTriggerService _triggerService;

        [SetUp]
        public void Setup()
        {
            _documentDBProvider = new Mock<IDocumentDBProvider>();
            _logger = new Mock<ILogger<GetCollectionByIdHttpTriggerService>>();
            _collection = new Mock<PersistedCollection>();
            _collections = new Mock<List<PersistedCollection>>();
            _touchPointId = "9000000000";
            _collectionId = Guid.NewGuid();
            _storage = new Mock<IDCBlobStorage>();
            _triggerService = new GetCollectionByIdHttpTriggerService(_documentDBProvider.Object, _storage.Object, _logger.Object);
        }

        [Test]
        public void GetCollectionByIdHttpTriggerService_Process_Test()
        {
            //Arrange        
            _documentDBProvider.Setup(x => x.GetCollectionsForTouchpointAsync(_touchPointId)).Returns(Task.FromResult(Task.FromResult(_collections.Object).Result));

            //Act
            var result = _triggerService.ProcessRequestAsync(_touchPointId, _collectionId);

            //Assert
            Assert.That(_triggerService, Is.Not.Null);
            Assert.That(result, Is.Not.Null);
        }
    }
}
