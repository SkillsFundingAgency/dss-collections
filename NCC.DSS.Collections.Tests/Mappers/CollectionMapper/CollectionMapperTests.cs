using NCS.DSS.Collections.Helpers;
using NCS.DSS.Collections.Mappers;
using NCS.DSS.Collections.Models;
using Moq;
using NUnit.Framework;
using System;
using System.Collections.Generic;

namespace NCC.DSS.Collections.Tests.Mappers.CollectionMapper
{
    [TestFixture]
    public class CollectionMapperTests
    {
        private Mock<ICollectionMapper> _mapper;
        private Mock<IDataCollectionsReportHelper> _reportHelper;
        [SetUp]
        public void Setup()
        {
            _reportHelper = new Mock<IDataCollectionsReportHelper>();
            _mapper = new Mock<ICollectionMapper>();
            //_mapper = new NCS.DSS.Collections.Mappers.CollectionMapper(_reportHelper.Object);
        }

        [Test]
        public void Test_Mapping_From_Collection_To_PersistedCollection()
        {
            //Arranga
            var collectionId = Guid.NewGuid();
            var touchpointId = "9000000000";
            var ukprn = "12345";
            var collectionReports = new Uri("http://localhost");
            var lastModifiedDate = DateTime.Now;

            Collection collection = new Collection
                                    {
                                        CollectionId = collectionId,
                                        TouchPointId = touchpointId,
                                        Ukprn = ukprn,
                                        CollectionReports = collectionReports,
                                        LastModifiedDate = lastModifiedDate
                                    };

            _mapper.Setup(x => x.Map(collection)).Returns<string>(null);
            //Act

            PersistedCollection mappedCollection = _mapper.Map(collection);

            //Assert
            Assert.AreEqual(mappedCollection.CollectionId, collection.CollectionId);
            Assert.AreEqual(mappedCollection.CollectionReports, collection.CollectionReports);
            Assert.AreEqual(mappedCollection.TouchPointId, collection.TouchPointId);
            Assert.AreEqual(mappedCollection.Ukprn, collection.Ukprn);
            Assert.AreEqual(mappedCollection.LastModifiedDate, collection.LastModifiedDate);
        }

        [Test]
        public void Test_Mapping_From_PersistedCollection_To_Collection()
        {
            //Assign
            var collectionId = Guid.NewGuid();
            var touchpointId = "9000000000";
            var ukprn = "12345";
            var collectionReports = new Uri("http://localhost");
            var lastModifiedDate = DateTime.Now;

            //Act
            PersistedCollection collection = new PersistedCollection
                                                 {
                                                    CollectionId = collectionId,
                                                    CollectionReports = collectionReports,
                                                    ContainerName = "containerName",
                                                    LastModifiedDate = lastModifiedDate,
                                                    ReportFileName = $"{touchpointId}-{collectionId}-NCS-Reports.zip",
                                                    TouchPointId = touchpointId,
                                                    Ukprn = ukprn
                                                 };

            Collection mappedCollection = _mapper.Map(collection);


            //Assert
            Assert.AreEqual(mappedCollection.CollectionId, collection.CollectionId);
            Assert.AreEqual(mappedCollection.CollectionReports, collection.CollectionReports);
            Assert.AreEqual(mappedCollection.TouchPointId, collection.TouchPointId);
            Assert.AreEqual(mappedCollection.Ukprn, collection.Ukprn);
            Assert.AreEqual(mappedCollection.LastModifiedDate, collection.LastModifiedDate);
        }   
        
        [Test]
        public void Test_Mapping_From_Collections_To_PersistedCollections()
        {
            //Assign
            List<Collection> collectionList = new List<Collection>();

            collectionList.Add(new Collection
            {
                CollectionId = Guid.NewGuid(),
                CollectionReports = new Uri("http://localhost"),
                LastModifiedDate = DateTime.Now,
                TouchPointId = "9000000000",
                Ukprn = "12345"
            });

            collectionList.Add(new Collection
            {
                CollectionId = Guid.NewGuid(),
                CollectionReports = new Uri("http://localhost"),
                LastModifiedDate = DateTime.Now,
                TouchPointId = "9000000001",
                Ukprn = "12345"
            });

            //Act
            var persistedCollectionList = _mapper.Map(collectionList);

            //Assert

            for (int iCount = 0; iCount < persistedCollectionList.Count; iCount++)
            {
                Assert.AreEqual(collectionList[iCount].CollectionId, persistedCollectionList[iCount].CollectionId);
                Assert.AreEqual(collectionList[iCount].CollectionReports, persistedCollectionList[iCount].CollectionReports);
                Assert.AreEqual(collectionList[iCount].TouchPointId, persistedCollectionList[iCount].TouchPointId);
                Assert.AreEqual(collectionList[iCount].Ukprn, persistedCollectionList[iCount].Ukprn);
                Assert.AreEqual(collectionList[iCount].LastModifiedDate, persistedCollectionList[iCount].LastModifiedDate);
            }
        }

        [Test]
        public void Test_Mapping_From_PersistedCollections_ToCollections()
        {
            //Assign
            List<PersistedCollection> persistedCollectionList = new List<PersistedCollection>();

            persistedCollectionList.Add(new PersistedCollection
            {
                CollectionId = Guid.NewGuid(),
                CollectionReports = new Uri("http://localhost"),
                LastModifiedDate = DateTime.Now,
                TouchPointId = "9000000000",
                Ukprn = "12345"
            });

            persistedCollectionList.Add(new PersistedCollection
            {
                CollectionId = Guid.NewGuid(),
                CollectionReports = new Uri("http://localhost"),
                LastModifiedDate = DateTime.Now,
                TouchPointId = "9000000001",
                Ukprn = "12345"
            });

            //Act
            var collectionList = _mapper.Map(persistedCollectionList);

            //Assert

            for (int iCount = 0; iCount < collectionList.Count; iCount++)
            {
                Assert.AreEqual(collectionList[iCount].CollectionId, persistedCollectionList[iCount].CollectionId);
                Assert.AreEqual(collectionList[iCount].CollectionReports, persistedCollectionList[iCount].CollectionReports);
                Assert.AreEqual(collectionList[iCount].TouchPointId, persistedCollectionList[iCount].TouchPointId);
                Assert.AreEqual(collectionList[iCount].Ukprn, persistedCollectionList[iCount].Ukprn);
                Assert.AreEqual(collectionList[iCount].LastModifiedDate, persistedCollectionList[iCount].LastModifiedDate);
            }
        }
    }
}
