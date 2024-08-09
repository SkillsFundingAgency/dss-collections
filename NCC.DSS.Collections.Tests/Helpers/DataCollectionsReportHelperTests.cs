using NCS.DSS.Collections.Helpers;
using NCS.DSS.Collections.Models;
using NUnit.Framework;
using System;

namespace NCC.DSS.Collections.Tests.Helpers
{
    [TestFixture]
    public class DataCollectionsReportHelperTests
    {
        private IDataCollectionsReportHelper _reportHelper;
        private Collection _collection;
        private Guid _collectionIdGuid;
        private string _touchpointId;

        [SetUp]
        public void Setup()
        {
            _collectionIdGuid = Guid.NewGuid();
            _touchpointId = "90000000000";

            _reportHelper = new DataCollectionsReportHelper();            

            _collection = new Collection{
                                            CollectionId = _collectionIdGuid,
                                            TouchPointId = _touchpointId
                                        };
        }

        [Test]
        public void Get_Container_Name_Passing()
        {
            //Assert
            Assert.That($"{_touchpointId}/{_collectionIdGuid}/NCS-Reports.zip" == _reportHelper.FileName(_collection));
        }

        [Test]
        public void Get_Container_Name_Failing()
        {
            //Assert
            Assert.That($"{_touchpointId}/{_collectionIdGuid}/NCS-Reports.zip " != _reportHelper.FileName(_collection));
        }
    }
}
