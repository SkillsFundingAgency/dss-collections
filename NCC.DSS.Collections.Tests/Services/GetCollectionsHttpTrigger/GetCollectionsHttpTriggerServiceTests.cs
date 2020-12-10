using DFC.HTTP.Standard;
using NCS.DSS.Collections.GetCollectionsHttpTrigger;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.GetCollectionsHttpTrigger.Service;
using NCS.DSS.Collections.Mappers;
using NCS.DSS.Collections.Models;
using NUnit.Framework;
using Moq;
using System;
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
        private Mock<IHttpRequestHelper> _httpRequestHelper;
        private PersistedCollection _collection;
        private List<PersistedCollection> _collections;
        private string _touchPointId;
        private Guid _collectionId;
        private IGetCollectionsHttpTriggerService _triggerService;

        [SetUp]
        private void Setup()
        {
            _httpRequestHelper = new Mock<IHttpRequestHelper>();
            _collectionMapper = new Mock<ICollectionMapper>();
            _documentDBProvider = new Mock<IDocumentDBProvider>();
            _collection = new PersistedCollection();
            _collections = new List<PersistedCollection>();
            _touchPointId = "9000000000";
            _collectionId = Guid.NewGuid();
            _triggerService = new GetCollectionsHttpTriggerService(_documentDBProvider.Object, _collectionMapper.Object);
        }

        [Test]
        public void GetCollectionsHttpTriggerService_Process_Test()
        {
            //Arrange        
            _documentDBProvider.Setup(x => x.DoesCollectionResourceExist(_collection)).Returns(Task.FromResult(true));
            _documentDBProvider.Setup(x => x.GetCollectionsForTouchpointAsync(_touchPointId)).Returns(Task.FromResult(Task.FromResult(_collections).Result));
            //_documentDBProvider.Object.DoesCollectionResourceExist(_collection).Returns<bool>(true);            
            //_documentDBProvider.Object.GetCollectionsForTouchpointAsync(_touchPointId).Returns(Task.FromResult(Task.FromResult(_collections).Result));

            //Act
            IEnumerable<Collection> result = _triggerService.ProcessRequestAsync(_touchPointId).Result;

            //Assert
            Assert.IsNotNull(result);            
        }
    }
}
