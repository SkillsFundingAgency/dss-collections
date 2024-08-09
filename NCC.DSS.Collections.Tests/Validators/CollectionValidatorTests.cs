using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.Validators;
using NUnit.Framework;
using System;
using System.Linq;

namespace NCC.DSS.Collections.Tests.Validators
{
    [TestFixture]
    public class CollectionValidatorTests
    {
        private ICollectionValidator _validator;

        [SetUp]
        public void Setup()
        {
            _validator = new CollectionValidator();
        }

        [Test]
        public void Validate_Collection_Test_Positive()
        {
            //Assign
            var collection = new Collection();

            //Act            
            Guid collectionId = Guid.NewGuid();
            string touchpointId = "9000000000";
            DateTime lastUpdated = DateTime.Now;
            string ukprn = "12345678";

            collection.CollectionId = collectionId;
            collection.LastModifiedDate = lastUpdated;
            collection.TouchPointId = touchpointId;
            collection.Ukprn = ukprn;

            var result = _validator.Validate(collection);

            //Assert
            Assert.That(false == result.Any());
            Assert.That(collection, Is.Not.Null);
            Assert.That(collectionId == collection.CollectionId);
            Assert.That(touchpointId == collection.TouchPointId);
            Assert.That(lastUpdated == collection.LastModifiedDate);
            Assert.That(ukprn == collection.Ukprn);
        }

        [Test]
        public void Validate_Collection_Test_Null_Collection_Id()
        {
            //Assign
            var collection = new Collection();

            //Act            
            string touchpointId = "9000000000";
            DateTime lastUpdated = DateTime.Now;
            string ukprn = "12345678";

            collection.LastModifiedDate = lastUpdated;
            collection.TouchPointId = touchpointId;
            collection.Ukprn = ukprn;

            var result = _validator.Validate(collection);

            //Assert
            Assert.That(0 == result.Count());
            Assert.That(collection, Is.Not.Null);
            Assert.That(collection.CollectionId, Is.Not.Null);
            Assert.That(touchpointId == collection.TouchPointId);
            Assert.That(lastUpdated == collection.LastModifiedDate);
            Assert.That(ukprn == collection.Ukprn);
        }

        [Test]
        public void Validate_Collection_Test_Null_TouchPoint_Id()
        {
            //Assign
            var collection = new Collection();

            //Act            
            Guid collectionId = Guid.NewGuid();
            DateTime lastUpdated = DateTime.Now;
            string ukprn = "12345678";

            collection.CollectionId = collectionId;
            collection.LastModifiedDate = lastUpdated;
            collection.Ukprn = ukprn;

            var result = _validator.Validate(collection);

            //Assert
            Assert.That(1 == result.Count());
            Assert.That(collection, Is.Not.Null);
            Assert.That(collectionId == collection.CollectionId);
            Assert.That(collection.TouchPointId, Is.Null);
            Assert.That(lastUpdated == collection.LastModifiedDate);
            Assert.That(ukprn == collection.Ukprn);
        }

        [Test]
        public void Validate_Collection_Test_Null_Last_Modified_Date()
        {
            //Assign
            var collection = new Collection();

            //Act            
            Guid collectionId = Guid.NewGuid();
            string touchpointId = "9000000000";
            string ukprn = "12345678";

            collection.CollectionId = collectionId;
            collection.TouchPointId = touchpointId;
            collection.Ukprn = ukprn;

            var result = _validator.Validate(collection);

            //Assert
            Assert.That(1 == result.Count());
            Assert.That(collection, Is.Not.Null);
            Assert.That(collectionId == collection.CollectionId);
            Assert.That(touchpointId == collection.TouchPointId);
            Assert.That(collection.LastModifiedDate, Is.Null);
            Assert.That(ukprn == collection.Ukprn);
        }

        [Test]
        public void Validate_Collection_Test_UKPRN_Too_Long()
        {
            //Assign
            var collection = new Collection(); ;

            //Act            
            Guid collectionId = Guid.NewGuid();
            string touchpointId = "9000000000";
            DateTime lastUpdated = DateTime.Now;
            string ukprn = "123456789";

            collection.CollectionId = collectionId;
            collection.TouchPointId = touchpointId;
            collection.LastModifiedDate = lastUpdated;
            collection.Ukprn = ukprn;

            var result = _validator.Validate(collection);

            //Assert
            Assert.That(1 == result.Count());
            Assert.That(collection, Is.Not.Null);
            Assert.That(collectionId == collection.CollectionId);
            Assert.That(touchpointId == collection.TouchPointId);
            Assert.That(lastUpdated == collection.LastModifiedDate);
            Assert.That(ukprn == collection.Ukprn);
        }

        [Test]
        public void Validate_Collection_Test_UKPRN_Too_Short()
        {
            //Assign
            var collection = new Collection();
            var collectionValidator = new CollectionValidator();

            //Act            
            Guid collectionId = Guid.NewGuid();
            string touchpointId = "9000000000";
            DateTime lastUpdated = DateTime.Now;
            string ukprn = "1234567";

            collection.CollectionId = collectionId;
            collection.TouchPointId = touchpointId;
            collection.LastModifiedDate = lastUpdated;
            collection.Ukprn = ukprn;

            var result = collectionValidator.Validate(collection);

            //Assert
            Assert.That(1 == result.Count());
            Assert.That(collection, Is.Not.Null);
            Assert.That(collectionId == collection.CollectionId);
            Assert.That(touchpointId == collection.TouchPointId);
            Assert.That(lastUpdated == collection.LastModifiedDate);
            Assert.That(ukprn == collection.Ukprn);
        }
    }
}
