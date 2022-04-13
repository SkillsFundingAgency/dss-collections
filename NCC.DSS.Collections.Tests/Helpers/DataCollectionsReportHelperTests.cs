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
        private string _subcontractorId;

        [SetUp]
        public void Setup()
        {
            _collectionIdGuid = Guid.NewGuid();
            _touchpointId = "90000000000";
            _touchpointId = "99999999999";

            _reportHelper = new DataCollectionsReportHelper();            

            _collection = new Collection{
                                            CollectionId = _collectionIdGuid,
                                            TouchPointId = _touchpointId,
                                            SubcontractorId = _subcontractorId
            };
        }

        [Test]
        public void Get_Container_Name_Passing()
        {
            //Assert
            Assert.AreEqual($"{_touchpointId}/{_subcontractorId}/{_collectionIdGuid}/NCS-Reports.zip", _reportHelper.FileName(_collection));
        }

        [Test]
        public void Get_Container_Name_Failing()
        {
            //Assert
            Assert.AreNotEqual($"{_touchpointId}/{_subcontractorId}/{_collectionIdGuid}/NCS-Reports.zip ", _reportHelper.FileName(_collection));
        }
    }
}
