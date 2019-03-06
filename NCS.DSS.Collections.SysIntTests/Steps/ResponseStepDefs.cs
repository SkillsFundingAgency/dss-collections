using FluentAssertions;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Linq.Expressions;
using System.Net;
//using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.SysIntTests.Helpers;
using NCS.DSS.Collections.SysIntTests.Models;
using NCS.DSS.Collections.SysIntTests.Singletons;
using NCS.DSS.TestHelperLibrary.Helpers;
using RestSharp;
using System.Text;
using TechTalk.SpecFlow;

namespace NCS.DSS.Collections.SysIntTests.Steps
{
    [Binding]
    class ResponseStepDefs
    {
        Collection CollectionRequest = new Collection();
        EnvironmentSettings Env = new EnvironmentSettings();
        private readonly ScenarioContext scenarioContext;
        private readonly List<Loader> LoaderData = new List<Loader>();

        public ResponseStepDefs(ScenarioContext context)
        {
            // make sure test data list in scenario context has been initialised
            scenarioContext = context;

            scenarioContext["TestData"] = new List<Loader>();

        }

        [Given(@"A report has been requested")]
        public void GivenAReportHasBeenRequested()
        {
            Loader loadItem = new Loader();
            //populate collection object with new GUID and insert int Collections collection in COSMOS
            CollectionRequest.CollectionId = Guid.NewGuid();
            CollectionRequest.LastModifiedDate = DateTime.Now;
            CollectionRequest.UKPRN = "12345678";
            CollectionRequest.TouchPointId = "9000000000";

            var jsonString = JsonConvert.SerializeObject(CollectionRequest);

            CosmosHelper.Initialise(Env.CosmosEndPoint, Env.CosmosAccountKey);
            string document;
            var response = CosmosHelper.InsertDocumentFromJson("collections", "collections", JsonConvert.SerializeObject(CollectionRequest), out document);
            document.Should().Contain(CollectionRequest.CollectionId.ToString());

            //store document details for teardown
            loadItem.ParentType = "CollectionId";
            loadItem.ParentId = CollectionRequest.CollectionId.ToString();
            loadItem.LoadedToSqlServer = false;
            LoaderData.Add(loadItem);

            var SCList = scenarioContext["TestData"] as List<Loader>;
            SCList.Add(loadItem);
            scenarioContext["TestData"] = SCList;
        }

        [Given(@"DC has generated the report")]
        public void GivenDCHasGeneratedTheReport()
        {
            // SPECFLOW loads a zip file to blob storage
            ScenarioContext.Current.Pending();
        }

        [Given(@"DC has notified DSS that the report is ready")]
        public void GivenDCHasNotifiedDSSThatTheReportIsReady()
        {
            // SPECFLOW enqueues an item on the response Service Bus queue
            ScenarioContext.Current.Pending();
        }

        [Then(@"the push subscription service informs the TouchPoint the report is ready")]
        public void ThenThePushSubscriptionServiceInformsTheTouchPointTheReportIsReady()
        {
            // SPECFLOW checks the notification collection to confirm the notification was sent
            ScenarioContext.Current.Pending();
        }

        [Then(@"the TouchPoint can retrieve the file")]
        public void ThenTheTouchPointCanRetrieveTheFile()
        {
            // SPECFLOW makes a GET request to the collections API with the URI included in the push message
            ScenarioContext.Current.Pending();
        }




    }
}
