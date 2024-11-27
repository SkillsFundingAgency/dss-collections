using Moq;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.GetCollectionsHttpTrigger.Service;
using NCS.DSS.Collections.Mappers;
using NCS.DSS.Collections.Models;
using NUnit.Framework;
using System.Collections.Generic;
using System.Threading.Tasks;
using Assert = NUnit.Framework.Assert;

namespace NCC.DSS.Collections.Tests.Services.GetCollectionsHttpTrigger
{
    [TestFixture]
    public class GetCollectionsHttpTriggerServiceTests
    {
        private Mock<IDocumentDBProvider> _documentDBProvider;
        private Mock<ICollectionMapper> _collectionMapper;
        private Mock<PersistedCollection> _collection;
        private Mock<List<PersistedCollection>> _collections;
        private string _touchPointId;
        private IGetCollectionsHttpTriggerService _triggerService;

        [SetUp]
        public void Setup()
        {
            _collectionMapper = new Mock<ICollectionMapper>();
            _documentDBProvider = new Mock<IDocumentDBProvider>();
            _collection = new Mock<PersistedCollection>();
            _collections = new Mock<List<PersistedCollection>>();
            _touchPointId = "9000000000";
            _triggerService = new GetCollectionsHttpTriggerService(_documentDBProvider.Object, _collectionMapper.Object);
        }

        [Test]
        public void GetCollectionsHttpTriggerService_Process_Test()
        {
            //Arrange        
            _documentDBProvider.Setup(x => x.GetCollectionsForTouchpointAsync(_touchPointId)).Returns(Task.FromResult(Task.FromResult(_collections.Object).Result));

            //Act
            var result = _triggerService.ProcessRequestAsync(_touchPointId);

            //Assert
            Assert.That(_triggerService, Is.Not.Null);
            Assert.That(result, Is.Not.Null);
        }
    }
}
