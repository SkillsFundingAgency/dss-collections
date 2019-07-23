using FluentAssertions;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Linq.Expressions;
using System.Net;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using NCS.DSS.Collections.SysIntTests.Helpers;
using NCS.DSS.Collections.SysIntTests.Models;
using NCS.DSS.Collections.SysIntTests.Singletons;
using NCS.DSS.TestHelperLibrary.Helpers;
using RestSharp;
using System.Text;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace NCS.DSS.Collections.SysIntTests.Steps
{
    [Binding]
    public sealed class StepDefinitions : RestHelper
    {
        private string SearchClause = "";
        private string FilterClause = "";
        private string SelectClause = "";
        private string PagingClause = "";
        private String CountClause = "";
        private int PageSize;
        private int NumberOfPages;
        private List<string> PreviousResults = new List<string>();
        private IRestResponse response;
        private EnvironmentSettings envSettings = new EnvironmentSettings();
        private SearchResponse SearchResults;
        private readonly List<Loader> LoaderData = new List<Loader>();
        internal static readonly AzureSearchSingleton CustomerDataLoad = AzureSearchSingleton.Instance;
        private List<Models.ReportRow> ReportRows;
        private readonly ScenarioContext scenarioContext;
        private readonly FeatureContext featureContext;
        private DateTime ReportPeriodStartDate = DateTime.Today;
        private DateTime ReportPeriodEndDate = DateTime.Today;
        private bool storeTearDownAtScenarioLevel = false;

        private DateTime ReportDate = DateTime.Today;

        private DateTime FeedStartDate = new DateTime(2019, 4, 1);
        private string collectionId;
        

        public StepDefinitions(ScenarioContext context, FeatureContext fcontext)
        {
            scenarioContext = context;
            featureContext = fcontext;
        }

        string AssertAndExtract(string key, IRestResponse response)
        {
            string extractedValue = "";
            if (response.IsSuccessful)
            {
                Dictionary<string, string> values = JsonConvert.DeserializeObject<Dictionary<string, string>>(response.Content);
                extractedValue = values[key];
                Console.WriteLine("Storing context information:" + key + " - " + extractedValue);
                if (extractedValue.Trim().Length == 0)
                {
                    Console.WriteLine("extraction failed, response.content:\n" + response.Content);
                    Console.WriteLine("");
                }
                extractedValue.Should().NotBeNullOrEmpty();
            }
            else
            {
                Console.WriteLine("Request was unsuccessful");
                Console.WriteLine("response status: " + response.StatusCode);
                Console.WriteLine("response status description: " + response.StatusDescription);
                Console.WriteLine("response message: " + response.ErrorMessage);
                Console.WriteLine("response expection: " + response.ErrorException);
            }
            return extractedValue;
        }
        public void SubmitTheSearch()
        {
            string url = envSettings.TempSearchUrl + SearchClause + FilterClause + SelectClause + PagingClause + CountClause;
            response = /*RestHelper.*/GetSearch(url, envSettings.TouchPointId, envSettings.TempSearchKey);
            SearchResults = JsonConvert.DeserializeObject<SearchResponse>(response.Content);
        }

        [When(@"I search")]
        public void WhenISearch()
        {
          //  ScenarioContext.Current.Pending();
        }

        [When(@"I submit the search")]
        public void WhenISubmitTheSearch()
        {
            SubmitTheSearch();
        }

        [Given(@"I filter the results as follows")]
        public void GivenIFilterTheResultsAsFollows(Table table)
        {
            // need to build a search clause with the items in the table
            string filterClause = @"";
            Boolean firstItem = true;
            Dictionary<string,string> dict = table.Rows.ToDictionary(r => r["FilterTerm"], r => r["Value"]);

            foreach (var item in dict)
            {
                filterClause += (firstItem ? "&$filter=" : " AND ") + item.Key + " " + item.Value;
                firstItem = false;
            }
            FilterClause = filterClause;
        }

        [Given(@"I enter a search with the following terms")]
        public void GivenIEnterASearchWithTheFollowingTerms(Table table)
        {
            // need to build a search clause with the items in the table
            string searchClause = @"&search=";
            bool firstItem = true;
            Dictionary<string, string> dict = table.Rows.ToDictionary(r => r["SearchTerm"], r => r["Value"]);
            
            foreach ( var item in dict)
            {
                searchClause += (firstItem ? "" : ", ") + item.Key + ":" + item.Value;
                firstItem = false;
            }
            SearchClause = searchClause;
        }

        [Given(@"I request a count of records")]
        public void GivenIRequestACountOfRecords()
        {
            CountClause = "&$count=true";
        }

        [Given(@"I request a page limit of (.*) records")]
        public void GivenIRequestAPageLimitOfRecords(int p0)
        {
            PageSize = p0;
        }

        [Given(@"I request page (.*)")]
        [When(@"I request page (.*)")]
        public void GivenIRequestPage(int p0)
        {
            // work out pagination requirements
            PagingClause = "&$top=" + PageSize;
            PagingClause += "&$skip=" + PageSize * (p0 - 1);

            SubmitTheSearch();
        }

        [When(@"I request the last page")]
        public void WhenIRequestTheLastPage()
        {
            // calculate number of pages expected
            NumberOfPages = Convert.ToInt32(Math.Ceiling((decimal) SearchResults.RecordCount / PageSize ));
            PagingClause = "&$top=" + PageSize;
            PagingClause += "&$skip=" + PageSize * ( NumberOfPages - 1 );

            SubmitTheSearch();
        }

        [Then(@"results are returned")]
        public void ThenResultsAreReturned()
        {
          //  ScenarioContext.Current.Pending();
        }

        [Then(@"there should be a (.*) response")]
        public void ThenThereShouldBeAResponse(int expectedResponseCode)
        {
            HttpStatusCode statusCode = response.StatusCode;
            int numericStatusCode = (int)statusCode;
            numericStatusCode.Should().Be(expectedResponseCode);
        }

        private int AssertValueInCustomerList ( IEnumerable<Customer> list, string key, string value)
        {
            IEnumerable<Customer> tempList;//= null;// list.Where<Customer>(item => item.GivenName.ToLower() == "");
            switch (key)
            {
                case "GivenName":
                    tempList = SearchResults.Results.Where<Customer>(item => item.GivenName.ToLower() == value.ToLower());
                    break;
                case "FamilyName":
                    tempList = SearchResults.Results.Where<Customer>(item => item.FamilyName.ToLower() == value.ToLower());
                    break;
                case "DateofBirth":
                    tempList = SearchResults.Results.Where<Customer>(item => item.DateofBirth.ToLower() == value.ToLower());
                    break;
                default:
                    throw new Exception("The field: " + key + " is not supported");
            }
            tempList.Count().Should().BeGreaterThan(0, "because documents with " + key + " = " + value + " are expected in the response");
            return tempList.Count();
        }

        [Then(@"the response should include ""(.*)"" matches for:")]
        public void ThenTheResponseShouldIncludeMatchesFor(string p0, Table table)
        {
            //ictionary<string,string> dict = table.Rows.ToDictionary(r =>  r => r["Value"]);
            int tally = 0;
         
            foreach (var text in table.Rows[0].Values)
            {
                tally += AssertValueInCustomerList(SearchResults.Results, p0, text);

                //// first call to create the list (  haven't worked out how to do this more neatly yet )
                //var list = SearchResults.Results.Where<Customer>(item => item.GivenName.ToLower() == "" /*&& TODO restrict by test tag*/);
                //switch (p0)
                //{
                //    case "GivenName":
                //        list = SearchResults.Results.Where<Customer>(item => item.GivenName.ToLower() == text.ToLower());
                //        break;
                //    case "FamilyName":
                //        list = SearchResults.Results.Where<Customer>(item => item.FamilyName.ToLower() == text.ToLower());
                //        break;
                //    case "DateofBirth":
                //        list = SearchResults.Results.Where<Customer>(item => item.DateofBirth.ToLower() == text.ToLower());
                //        break;
                //    default:
                //        throw new Exception("The field: " + text + " is not supported");
                //}
                //// var list = SearchResults.value.Where<Customer>(item => item.GivenName.ToLower() == testCondition.Value.ToLower());
                //list.Count().Should().BeGreaterThan(0);
                //Tally += list.Count();
            }
            tally.Should().Be(SearchResults.Results.Count(),"Because otherwise documents where " + p0 + " does not match one of the specified values");

        }

        [Then(@"the response should include results for:")]
        public void ThenTheResponseShouldIncludeResultsFor(Table table)
        {
            Dictionary<string, string> dict = table.Rows.ToDictionary(r => r["FieldName"], r => r["Value"]);
            int tally = 0;
            foreach (var testCondition in dict)
            {

                tally += AssertValueInCustomerList(SearchResults.Results, testCondition.Key, testCondition.Value);

                //// first call to create the list (  haven't worked out how to do this more neatly yet )
                //var list = SearchResults.Results.Where<Customer>(item => item.GivenName.ToLower() == "");
                //switch (testCondition.Key)
                //{
                //    case "GivenName":
                //        list = SearchResults.Results.Where<Customer>(item => item.GivenName.ToLower() == testCondition.Value.ToLower());
                //        break;
                //    case "FamilyName":
                //        list = SearchResults.Results.Where<Customer>(item => item.FamilyName.ToLower() == testCondition.Value.ToLower());
                //        break;
                //    case "DateofBirth":
                //        list = SearchResults.Results.Where<Customer>(item => item.DateofBirth.ToLower() == testCondition.Value.ToLower());
                //        break;
                //    default:
                //        throw new Exception("The field: " + testCondition.Key + " is not supported");
                //}
                //// var list = SearchResults.value.Where<Customer>(item => item.GivenName.ToLower() == testCondition.Value.ToLower());
                //Console.WriteLine("Checking that " + testCondition.Key + ": " + testCondition.Value + " is inculded in the results");
                //list.Count().Should().BeGreaterThan(0, "because documents with " + testCondition.Key + " = " + testCondition.Value + " are expected in the response");
                //tally += list.Count();
            }
            tally.Should().Be(SearchResults.Results.Count(), "Because otherwise results have been returned that do not match those expected");
        }

        [Then(@"The response includes values for")]
        public void ThenTheResponseIncludesValuesFor(Table table)
        {
            foreach (var result in SearchResults.Results)
            {
                string json = JsonConvert.SerializeObject(result, Formatting.Indented);
                foreach (var text in table.Rows[0].Values)
                {
                    JsonHelper.CheckJsonPropertyHasValue(json, text).Should().BeTrue();
                }
            }
        }

        [Then(@"The response includes no values for")]
        public void ThenTheResponseIncludesNoValuesFor(Table table)
        {
            foreach (var result in SearchResults.Results)
            {
                string json = JsonConvert.SerializeObject(result, Formatting.Indented);
                foreach (var text in table.Rows[0].Values)
                {
                    JsonHelper.CheckJsonPropertyHasNoValueValue(json, text).Should().BeTrue();
                }
            }
        }

        [Given(@"I remember the records returned")]
        public void GivenIRememberTheRecordsReturned()
        {
            var list = SearchResults.Results
                .Select(i => i.CustomerId);
            PreviousResults.AddRange(list);
        }

        [Given(@"I restrict the returned fields to")]
        public void GivenIRestrictTheReturnedFieldsTo(Table table)
        {
            bool firstItem = true;
            foreach (var text in table.Rows[0].Values)
            {
                SelectClause += (firstItem ? "&$select=" : ", ") + text;
                firstItem = false;
            }
        }

        [Then(@"the number of records returned should be (.*)")]
        public void ThenTheNumberOfRecordsReturnedShouldBe(int p0)
        {
            SearchResults.Results.Count().Should().Be(p0,"because this is the number of documents expected in the search");
        }

        [Then(@"the records should not include the ealier results")]
        public void ThenTheRecordsShouldNotIncludeTheEalierResults()
        {
            // check retured results do not include those previously returned
            var resultList = SearchResults.Results
                            .Select(s => s.CustomerId);
            bool matches = resultList.Any(x => PreviousResults.Any(y => y == x));
            matches.Should().BeFalse("because there shouldn't be any documents returned that were seen on an ealier page");
        }

        [Then(@"the remainder of the results are returned")]
        public void ThenTheRemainderOfTheResultsAreReturned()
        {
            SearchResults.Results.Count().Should().Be(SearchResults.RecordCount - ( PageSize * ( NumberOfPages - 1 ) ),"because pagination should return all remaining documents on the last page");
        }

        public bool DataSetupIsComplete()
        {
            bool dataSetupComplete = false;
            if ( featureContext.ContainsKey("DataSetupExecuted") )
            {
                dataSetupComplete = (bool)featureContext["DataSetupExecuted"];
            }
            else
            {
                featureContext["DataSetupExecuted"] = dataSetupComplete;
            }
            return dataSetupComplete;
        }

        public void SetDataSetupAsComplete()
        {
            featureContext["DataSetupExecuted"] = true;
        }


        [Given(@"I load test customer data for this feature:")]
        public void GivenILoadTestCustomerDataForThisFeature(Table table)
        {
            //CustomerDataLoad.DataSetupExecuted = true;
            if (DataSetupIsComplete())
            {
                return;
            }
            DataLoadHelper<LoadCustomer> dataLoadHelper = new DataLoadHelper<LoadCustomer>();
            dataLoadHelper.FieldToRemoveFromJsonBeforeSQLInsert = "OptInMarketResearch";
            //Table processedTable = DataLoadHelper<LoadCustomer>.ReplaceTokensInTable(table);
            var list = dataLoadHelper.ProcessDataTable(table, LoaderData, constants.CustomersPath ,string.Empty, constants.CustomerId);
            LoaderData.AddRange(list);
        }

        [Given(@"I load test address data for this feature:")]
        public void GivenILoadTestAddressDataForThisFeature(Table table)
        {
            if (DataSetupIsComplete())
            {
                return;
            }

            DataLoadHelper<LoadAddress> dataLoadHelper = new DataLoadHelper<LoadAddress>();
            var list = dataLoadHelper.ProcessDataTable(table, LoaderData, constants.AddressesPath, constants.CustomerId, constants.AddressId);
            LoaderData.AddRange(list);
        }

        [Given(@"I load test contact data for this feature:")]
        public void GivenILoadTestContactDataForThisFeature(Table table)
        {
            if (DataSetupIsComplete())
            {
                return;
            }

            DataLoadHelper<LoadContact> dataLoadHelper = new DataLoadHelper<LoadContact>();
            var list = dataLoadHelper.ProcessDataTable(table, LoaderData, constants.ContactsPath,constants.CustomerId, constants.ContactId);
            LoaderData.AddRange(list);

        }

        [Given(@"I load test interaction data for this feature")]
        public void GivenILoadTestInteractionDataForThisFeature(Table table)
        {
            if (DataSetupIsComplete())
            {
                return;
            }

            DataLoadHelper<LoadInteraction> dataLoadHelper = new DataLoadHelper<LoadInteraction>();
            var list = dataLoadHelper.ProcessDataTable(table, LoaderData, constants.InteractionsPath, constants.CustomerId, constants.InteractionId);
            LoaderData.AddRange(list);
        }

        [Given(@"I load test session data for the feature")]
        public void GivenILoadTestSessionDataForTheFeature(Table table)
        {
            if (DataSetupIsComplete())
            {
                return;
            }
            DataLoadHelper<LoadSession> dataLoadHelper = new DataLoadHelper<LoadSession>();
            var list = dataLoadHelper.ProcessDataTable(table, LoaderData, constants.SessionsPath, constants.InteractionId, constants.SessionId);
            LoaderData.AddRange(list);
        }

        [Given(@"I load action plan data for the feature")]
        public void GivenILoadActionPlanDataForTheFeature(Table table)
        {
            if (DataSetupIsComplete())
            {
                return;
            }
            DataLoadHelper<LoadActionPlan> dataLoadHelper = new DataLoadHelper<LoadActionPlan>();
            dataLoadHelper.FieldToAddToJsonBeforeMakingRequest = constants.SessionId;
           // dataLoadHelper.FieldToRemoveFromJsonBeforeSQLInsert = constants.SessionId;
            var list = dataLoadHelper.ProcessDataTable(table, LoaderData, constants.ActionPlansPathV2, constants.SessionId, constants.ActionPlanId );
            LoaderData.AddRange(list);
         }

        [Given(@"I load action data for the feature")]
        public void GivenILoadActionDataForTheFeature(Table table)
        {
            if (DataSetupIsComplete())
            {
                return;
            }

            DataLoadHelper<LoadAction> dataLoadHelper = new DataLoadHelper<LoadAction>();
            var list = dataLoadHelper.ProcessDataTable(table, LoaderData, constants.ActionsPathV2, constants.ActionPlanId, constants.ActionId);
            LoaderData.AddRange(list);
        }

        [Given(@"I load outcome data for the feature")]
        public void GivenILoadOutcomeDataForTheFeature(Table table)
        {
            if (DataSetupIsComplete())
            {
                return;
            }
            DataLoadHelper<LoadOutcome> dataLoadHelper = new DataLoadHelper<LoadOutcome>();
            dataLoadHelper.FieldToAddToJsonBeforeMakingRequest = constants.SessionId;
            dataLoadHelper.FieldToRemoveFromJsonBeforeSQLInsert = constants.SessionId;
            var list = dataLoadHelper.ProcessDataTable(table, LoaderData, constants.OutcomesPathV2, constants.ActionPlanId, constants.OutcomeId);
            LoaderData.AddRange(list);
        }

        [Given(@"I have made any data fudging updates required")]
        public void GivenIHaveMadeAnyDataFudgingUpdatesRequired()
        {
            if (DataSetupIsComplete())
            {
                return;
            }
            SQLServerHelper sqlHelper = new SQLServerHelper();
            sqlHelper.SetConnection(envSettings.SqlConnectionString);
            // cycle through LoaderData where postprocessing is set to true
            var items = LoaderData.Where(i => i.requiresPostProcessing == true);

            foreach ( var item in items)
            {
                // find out what kind of resource it is
                // get the id
                CosmosHelper.Initialise(envSettings.CosmosEndPoint, envSettings.CosmosAccountKey);
                    var doc = CosmosHelper.UpdateDocument(constants.CollectionNameFromId(item.ParentType), constants.CollectionNameFromId(item.ParentType),item.ParentId,item.DateOverrides);

                var updateJson = JsonConvert.SerializeObject(item.DateOverrides);
                updateJson = JsonHelper.AddPropertyToJsonString(updateJson, "id", item.ParentId);
                sqlHelper.UpdateRecordFromJson(constants.BackupTableNameFromId(item.ParentType), updateJson, "id");
            }

        }


        [Given(@"I update the following sessions")]
        public void GivenIUpdateTheFollowingSessions(Table table)
        {
            if (DataSetupIsComplete())
            {
                return;
            }
            Table detokenisedTable = DataLoadHelper<ILoader>.ReplaceTokensInTable(table);
            // find the passing in string in the DataLoad collection and get the customer id
            //List<Loader> testData = (List<Loader>)featureContext["TestData"];

            foreach ( var row in detokenisedTable.Rows)
            {

                string loaderReference = row["LoaderRef"];
                string sessionRef = row["SessionRef"];
                string newSessionDate = row["DateandTimeOfSession"];
                string url = constants.SessionsPath;// + "/SessionId";

                var list = LoaderData.Where((i, index) => i.LoaderReference == loaderReference && i.ParentType == constants.SessionId);// && index == Convert.ToInt32(sessionRef) );

                //list.Count().Should().Be(1, "Because we are looking for 1 record which matches of patch criteria");
                Session patchSession = new Session();

                patchSession.CustomerId = list.ElementAt(Convert.ToInt32(sessionRef) - 1).AllParents.Where( j => j.Key == constants.CustomerId).ElementAt(0).Value;
                patchSession.InteractionId = list.ElementAt(Convert.ToInt32(sessionRef) -1).AllParents.Where(j => j.Key == constants.InteractionId).ElementAt(0).Value;
                patchSession.SessionId = list.ElementAt(Convert.ToInt32(sessionRef) -1).ParentId;
                patchSession.DateandTimeOfSession = newSessionDate;

                url = url.Replace(constants.CustomerId, patchSession.CustomerId);
                url = url.Replace(constants.InteractionId, patchSession.InteractionId);
              //  url = url.Replace(constants.SessionId, patchSession.SessionID);

                // Now patch

                var response = RestHelper.Patch(envSettings.BaseUrl + url, JsonConvert.SerializeObject(patchSession), envSettings.TouchPointId, envSettings.SubscriptionKey, patchSession.SessionId);
                response.StatusCode.Should().Be(System.Net.HttpStatusCode.OK);//, "Because  " + item.LoaderRef + ": " + response.Content);

                // load to SQL
                SQLServerHelper sqlHelper = new SQLServerHelper();
                sqlHelper.SetConnection(envSettings.SqlConnectionString);
                sqlHelper.AddReplacementRule(constants.SessionId, "id");
                sqlHelper.UpdateRecordFromJson(constants.BackupTableNameFromId(constants.SessionId), JsonConvert.SerializeObject(patchSession), constants.SessionId);
                //sqlHelper.AddReplacementRule(tokenToStore, "id");
            }        
        }

        [Given(@"I update the following sessions directly")]
        public void GivenIUpdateTheFollowingSessionsDirectly(Table table)
        {
            if (DataSetupIsComplete())
            {
                return;
            }
            Table detokenisedTable = DataLoadHelper<ILoader>.ReplaceTokensInTable(table);
            // find the passing in string in the DataLoad collection and get the customer id
            //List<Loader> testData = (List<Loader>)featureContext["TestData"];

            var sessionsForUpdate = detokenisedTable.CreateSet<Session>();
            int iCount = 0;

            foreach (var row in detokenisedTable.Rows)
            {
                
                string loaderReference = row["LoaderRef"];
                string sessionRef = row["SessionRef"];
                string newSessionDate = row["DateandTimeOfSession"];
                string url = constants.SessionsPath;// + "/SessionId";
                Dictionary<string, string> updateFields = new Dictionary<string, string>();
                foreach ( var item in row)
                {
                    if (item.Key != "LoaderRef" && item.Key != "SessionRef")
                    {
                        updateFields.Add(item.Key, item.Value);
                    }
                }

                var list = LoaderData.Where((i, index) => i.LoaderReference == loaderReference && i.ParentType == constants.SessionId);// && index == Convert.ToInt32(sessionRef) );

                //list.Count().Should().Be(1, "Because we are looking for 1 record which matches of patch criteria");

                Session patchSession = sessionsForUpdate.ElementAt(iCount);

 //               patchSession.CustomerId = list.ElementAt(Convert.ToInt32(sessionRef) - 1).AllParents.Where(j => j.Key == constants.CustomerId).ElementAt(0).Value;
 //               patchSession.InteractionId = list.ElementAt(Convert.ToInt32(sessionRef) - 1).AllParents.Where(j => j.Key == constants.InteractionId).ElementAt(0).Value;
               patchSession.SessionId = list.ElementAt(Convert.ToInt32(sessionRef) - 1).ParentId;
 //               patchSession.DateandTimeOfSession = newSessionDate;

                CosmosHelper.Initialise(envSettings.CosmosEndPoint, envSettings.CosmosAccountKey);
                //CosmosHelper.UpsertDocument<Session>("sessions", "sessions", patchSession);

                var doc = CosmosHelper.UpdateDocument("sessions", "sessions", list.ElementAt(Convert.ToInt32(sessionRef) - 1).ParentId, updateFields);


                /*     url = url.Replace(constants.CustomerId, patchSession.CustomerId);
                     url = url.Replace(constants.InteractionId, patchSession.InteractionId);
                     //  url = url.Replace(constants.SessionId, patchSession.SessionID);

                     // Now patch

                     var response = RestHelper.Patch(envSettings.BaseUrl + url, JsonConvert.SerializeObject(patchSession), envSettings.TouchPointId, envSettings.SubscriptionKey, patchSession.SessionId);
                     response.StatusCode.Should().Be(System.Net.HttpStatusCode.OK);//, "Because  " + item.LoaderRef + ": " + response.Content);
     */
                // load to SQL
        //        SQLServerHelper sqlHelper = new SQLServerHelper();
        //        sqlHelper.SetConnection(envSettings.SqlConnectionString);
        //        sqlHelper.AddReplacementRule(constants.SessionId, "id");
        //        sqlHelper.UpdateRecordFromJson(constants.BackupTableNameFromId(constants.SessionId), JsonConvert.SerializeObject(patchSession), constants.SessionId);
                //sqlHelper.AddReplacementRule(tokenToStore, "id");
                iCount++;
            }
        }


        [Given(@"I update the following outcomes directly")]
        public void GivenIUpdateTheFollowingOutcomesDirectly(Table table)
        {
            if (DataSetupIsComplete())
            {
                return;
            }
            Table detokenisedTable = DataLoadHelper<ILoader>.ReplaceTokensInTable(table);
            // find the passing in string in the DataLoad collection and get the customer id
            //List<Loader> testData = (List<Loader>)featureContext["TestData"];

            var outcomesForUpdate = detokenisedTable.CreateSet<Outcome>();
            int iCount = 0;

            foreach (var row in detokenisedTable.Rows)
            {

                string loaderReference = row["LoaderRef"];
                string outcomeRef = row["OutcomeRef"];

                Dictionary<string, string> updateFields = new Dictionary<string, string>();
                foreach (var item in row)
                {
                    if (item.Key != "LoaderRef" && item.Key != "OutcomeRef")
                    {
                        updateFields.Add(item.Key, item.Value);
                    }
                }

                var list = LoaderData.Where((i, index) => i.LoaderReference == loaderReference && i.ParentType == constants.OutcomeId);// && index == Convert.ToInt32(sessionRef) );

                //list.Count().Should().Be(1, "Because we are looking for 1 record which matches of patch criteria");

                Outcome patchOutcome = outcomesForUpdate.ElementAt(iCount);

                //               patchSession.CustomerId = list.ElementAt(Convert.ToInt32(sessionRef) - 1).AllParents.Where(j => j.Key == constants.CustomerId).ElementAt(0).Value;
                //               patchSession.InteractionId = list.ElementAt(Convert.ToInt32(sessionRef) - 1).AllParents.Where(j => j.Key == constants.InteractionId).ElementAt(0).Value;
                patchOutcome.OutcomeId = list.ElementAt(Convert.ToInt32(outcomeRef) - 1).ParentId;
                //               patchSession.DateandTimeOfSession = newSessionDate;

                CosmosHelper.Initialise(envSettings.CosmosEndPoint, envSettings.CosmosAccountKey);
                var doc = CosmosHelper.UpdateDocument("outcomes", "outcomes", list.ElementAt(Convert.ToInt32(outcomeRef) - 1).ParentId, updateFields);

                iCount++;
            }
        }


        [Given(@"I have completed loading data and don't want to repeat for each test")]
        public void GivenIHaveCompletedLoadingDataAndDonTWantToRepeatForEachTest()
        {
            Console.WriteLine("List of entities created during data load");
            Console.WriteLine("-----------------------------------------");
            foreach ( var item in LoaderData)
            {
                Console.WriteLine("Test Customer: " + item.LoaderReference + ", " +item.ParentType + ": " + item.ParentId);
            }
            SetDataSetupAsComplete();
            //CustomerDataLoad.DataSetupExecuted = true;
        }

        [Given(@"I am creating data in scenario context")]
        public void GivenIAmCreatingDataInScenarioContext()
        {
            storeTearDownAtScenarioLevel = true;
        }


        [Given(@"I have confirmed all test data is now in the backup data store")]
        public void GivenIHaveConfirmedAllTestDataIsNowInTheBackupDataStore()
        {
            if (DataSetupIsComplete())
            {
                return;
            }
            SQLServerHelper sqlHelper = new SQLServerHelper();
            sqlHelper.SetConnection(envSettings.SqlConnectionString);
            // loop through the data load list and check each is now in the SQL server data store
            foreach ( var item in LoaderData)
            {
                if (item.LoadedToSqlServer) // temp measure until change feed has been delivered
                {
                    sqlHelper.AddReplacementRule(item.ParentType, "id");
                    sqlHelper.CheckRecordExists(constants.BackupTableNameFromId(item.ParentType), item.ParentType, item.ParentId).Should().BeTrue();
                }
            }
            sqlHelper.CloseConnection();

            if (storeTearDownAtScenarioLevel)
            {
                scenarioContext["TestData"] = LoaderData;
            }
            else
            {
                featureContext["TestData"] = LoaderData;
            }
            

        }

        [When(@"I check the report data")]
        public void WhenICheckTheReportData()
        {
            if (storeTearDownAtScenarioLevel)
            {
                ReportRows = (List<Models.ReportRow>)scenarioContext["ReportRows"];
            }
            else
            {
                ReportRows = (List<Models.ReportRow>)featureContext["ReportRows"];
            }
        }


        [Given(@"a request has been made for tax year ""(.*)"" and touch point (.*) and the report data is available")]
        public void GivenARequestHasBeenMadeForTaxYearAndTouchPointAndTheReportDataIsAvailable(int p0, Decimal p1)
        {
            ScenarioContext.Current.Pending();
        }


        [Given(@"a request has been made and the report data is available")]
        public void GivenARequestHasBeenMadeAndTheReportDataIsAvailable()
        {
            if (DataSetupIsComplete())
            {

                ReportRows = (List<Models.ReportRow>)featureContext["ReportRows"];

                return;
            }

            SQLServerHelper sqlInstance = new SQLServerHelper();
            sqlInstance.SetConnection(envSettings.SqlConnectionString);

            //      int dateOffSet = ( ReportDate - DateTime.Today).Days;
            //    sqlInstance.UpsertParameterValue("dss-data-collections-params", "TimeTravel", dateOffSet.ToString());


            //int feedinDate = (ReportDate - DateTime.Today).Days;
            //     sqlInstance.UpsertParameterValue("dss-data-collections-params", "FeedStartDate", FeedStartDate.ToShortDateString());

            var ds = sqlInstance.ExecuteTableFunction("dcc-collections", new string[] { envSettings.TouchPointId, ReportPeriodStartDate.ToString("yyyy-MM-dd"), ReportPeriodEndDate.ToString("yyyy-MM-dd") });

            //revert time travel setting
            //      sqlInstance.UpsertParameterValue("dss-data-collections-params", "TimeTravel", "0");

            /*****SP METHOD   List<SqlParameter> parameters = new List<SqlParameter>()
               {
                   new SqlParameter() {ParameterName = "@TouchPointId", SqlDbType = SqlDbType.VarChar, Value = envSettings.TouchPointId },
                   new SqlParameter() {ParameterName = "@StartDate", SqlDbType = SqlDbType.DateTime, Value = ReportPeriodStartDate},
                   new SqlParameter() {ParameterName = "@EndDate", SqlDbType = SqlDbType.DateTime, Value = ReportPeriodEndDate},
               };


               var ds = sqlInstance.ExecuteStoredProcedure("sp-dcc-collections", parameters);

            *****************SP METHOD */
            ds.Tables[0].Rows.Count.Should().BeGreaterThan(0, "Because we want data to be present in the report");

            ReportRows = ds.Tables[0].AsEnumerable().Select(
                            dataRow => new ReportRow
                            {
                                CustomerId = dataRow.Field<Guid>("CustomerId").ToString(),
                                DateofBirth = ( dataRow.IsNull("DateofBirth") ? "": dataRow.Field<DateTime>("DateofBirth").ToString("yyyy-MM-dd")),
                                HomePostCode = ( dataRow.IsNull("HomePostCode") ? "" : dataRow.Field<string>("HomePostCode")),
                                ActionPlanID = dataRow.Field <Guid> ("ActionPlanID").ToString(),
                               SessionDate  = dataRow.Field<DateTime>("SessionDate").ToString("yyyy-MM-dd"),
                                SubContractorId = (dataRow.IsNull("SubContractorId") ? "" : dataRow.Field<string>("SubContractorId").ToString()),
                                AdviserName = dataRow.Field<string>("AdviserName").ToString(),
                                OutcomeID = dataRow.Field<Guid>("OutcomeID").ToString(),
                                OutcomeType = dataRow.Field<int>("OutcomeType").ToString(),
                                OutcomeEffectiveDate = dataRow.Field<DateTime>("OutcomeEffectiveDate").ToString("yyyy-MM-dd"),
                                OutcomePriorityCustomer = dataRow.Field<int>("OutcomePriorityCustomer").ToString()
                            }).ToList();
            if (storeTearDownAtScenarioLevel)
            {
                scenarioContext["ReportRows"] = ReportRows;
            }
            else
            {
                featureContext["ReportRows"] = ReportRows;
            }
  
        }


        [Then(@"test customer ""(.*)"" is included in the report")]
        public void ThenTestCustomerIsIncludedInTheReport(string p0)
        {
            // find the passing in string in the DataLoad collection and get the customer id
            List<Loader> testData = (storeTearDownAtScenarioLevel ? (List<Loader>)scenarioContext["TestData"]
                                                                   : (List<Loader>)featureContext["TestData"]);

            var list = testData.Where(i => i.LoaderReference == p0 && i.ParentType == constants.CustomerId);
            list.Count().Should().Be(1, "Because the should be 1 match for customer id and test data reference in the test data collection");
            string customerId = list.First().ParentId;

            // confirm if the customer id is in the ReportRows item list
            var checkList = ReportRows.Where(j => j.CustomerId == customerId);
            checkList.Count().Should().BeGreaterOrEqualTo(1, "Because otherwise the test customer " + p0 + "has not been found in the report");
        }





        [Then(@"test customer ""(.*)"" is not included in the report")]
        public void ThenTestCustomerIsNotIncludedInTheReport(string p0)
        {
            // find the passing in string in the DataLoad collection and get the customer id
            List<Loader> testData = (storeTearDownAtScenarioLevel ? (List<Loader>)scenarioContext["TestData"]
                                                                    : (List<Loader>)featureContext["TestData"]);

            var list = testData.Where(i => i.LoaderReference == p0 && i.ParentType == constants.CustomerId);
            list.Count().Should().Be(1, "Because the should be 1 match for customer id and test data reference in the test data collection");
            string customerId = list.First().ParentId;

            // confirm if the customer id is in the ReportRows item list
            var checkList = ReportRows.Where(j => j.CustomerId == customerId);
            checkList.Count().Should().Be(0, "Because otherwise the test customer " + p0 + "has been unexpectedly found in the report");
        }

        [Then(@"Outcome (.*) for test customer ""(.*)"" is not included in the report")]
        public void ThenOutcomeForTestCustomerIsNotIncludedInTheReport(int p0, string p1)
        {
            // find the passing in string in the DataLoad collection and get the customer id
            List<Loader> testData = (storeTearDownAtScenarioLevel ? (List<Loader>)scenarioContext["TestData"]
                                                                    : (List<Loader>)featureContext["TestData"]);

            // get records matching this customer
            var list = testData.Where(i => i.LoaderReference == p1 && i.ParentType == constants.OutcomeId);
            list.Count().Should().BeGreaterOrEqualTo(p0, "Because otherwise not enough outcomes have been loaded for this customer");
            var item = list.ElementAt(p0 - 1);


            // check that this outcome is included in the report
            var checkList = ReportRows.Where(j => j.OutcomeID.ToLower() == item.ParentId.ToLower());
            checkList.Count().Should().Be(0, "Because otherwise Outcome " + p0 + " for the test customer " + p1 + "has been unexpectedly included in the report");
        }

        [Then(@"Outcome (.*) for test customer ""(.*)"" is included in the report")]
        public void ThenOutcomeForTestCustomerIsIncludedInTheReport(int p0, string p1)
        {
            // find the passing in string in the DataLoad collection and get the customer i
            List<Loader> testData = (storeTearDownAtScenarioLevel ? (List<Loader>)scenarioContext["TestData"]
                                                                    : (List<Loader>)featureContext["TestData"]);

            // get records matching this customer
            var list = testData.Where(i => i.LoaderReference == p1 && i.ParentType == constants.OutcomeId);
            list.Count().Should().BeGreaterOrEqualTo(p0, "Because otherwise not enough outcomes have been loaded for this customer");
            var item = list.ElementAt(p0 - 1);

            // check that this outcome is included in the report
            var checkList = ReportRows.Where(j => j.OutcomeID.ToLower() == item.ParentId.ToLower());
            checkList.Count().Should().BeGreaterThan(0, "Because otherwise Outcome " + p0 + " for the test customer " + p1 + "has been unexpectedly ommited from the report");
            checkList.Count().Should().Be(1, "Because otherwise Outcome " + p0 + " for the test customer " + p1 + "has been duplicated in the report");
        }

        [Then(@"Either Outcome (.*) or (.*) for test customer ""(.*)"" is included in the report")]
        public void ThenEitherOutcomeOrForTestCustomerIsIncludedInTheReport(int p0, int p1, string p2)
        {
            int matchedOutcomes = 0;
            // find the passing in string in the DataLoad collection and get the customer i
            List<Loader> testData = (storeTearDownAtScenarioLevel ? (List<Loader>)scenarioContext["TestData"]
                                                                    : (List<Loader>)featureContext["TestData"]);

            // get records matching this customer
            var list = testData.Where(i => i.LoaderReference == p2 && i.ParentType == constants.OutcomeId);
            list.Count().Should().BeGreaterOrEqualTo(p0, "Because otherwise not enough outcomes have been loaded for this customer");

            var item = list.ElementAt(p0 - 1);
            // check that the first outcome is included in the report
            var checkList = ReportRows.Where(j => j.OutcomeID.ToLower() == item.ParentId.ToLower());
            matchedOutcomes += checkList.Count();

            item = list.ElementAt(p1 - 1);
            // check that the first outcome is included in the report
            checkList = ReportRows.Where(j => j.OutcomeID.ToLower() == item.ParentId.ToLower());
            matchedOutcomes += checkList.Count();

            matchedOutcomes.Should().BeGreaterThan(0, "Because otherwise neither of the indicated outcome have been included in the report");
            matchedOutcomes.Should().Be(1, "Because otherwise both of the indicated outcome have been included in the report");

        }





        [Then(@"Outcome (.*) for test customer ""(.*)"" is included in the report with outcome type of (.*)")]
        public void ThenOutcomeForTestCusdtomerIsIncludedInTheReportWithOutcomeTypeOf(int p0, string p1, int p2)
        {
            // find the passing in string in the DataLoad collection and get the customer i
            List<Loader> testData = (storeTearDownAtScenarioLevel ? (List<Loader>)scenarioContext["TestData"]
                                                                    : (List<Loader>)featureContext["TestData"]);

            // get records matching this customer
            var list = testData.Where(i => i.LoaderReference == p1 && i.ParentType == constants.OutcomeId);
            list.Count().Should().BeGreaterOrEqualTo(p0, "Because otherwise not enough outcomes have been loaded for this customer");
            var item = list.ElementAt(p0 - 1);

            // check that this outcome is included in the report
            var checkList = ReportRows.Where(j => j.OutcomeID.ToLower() == item.ParentId.ToLower());
            checkList.Count().Should().BeGreaterThan(0, "Because otherwise Outcome " + p0 + " for the test customer " + p1 + "has been unexpectedly ommited from the report");
            checkList.Count().Should().Be(1, "Because otherwise Outcome " + p0 + " for the test customer " + p1 + "has been duplicated in the report");

            checkList.First<ReportRow>().OutcomeType.Should().Be(p2.ToString(), "Because the expected outcome type is " + p2 + " But got " + checkList.First<ReportRow>().OutcomeType);

        }

        [Then(@"Outcome (.*) for test customer ""(.*)"" is included in the report with the following values")]
        public void ThenOutcomeForTestCustomerIsIncludedInTheReportWithTheFollowingValues(int p0, string p1, Table table)
        {
            // find the passing in string in the DataLoad collection and get the customer i
            List<Loader> testData = (storeTearDownAtScenarioLevel ? (List<Loader>)scenarioContext["TestData"]
                                                                    : (List<Loader>)featureContext["TestData"]);

            // get records matching this customer
            var list = testData.Where(i => i.LoaderReference == p1 && i.ParentType == constants.OutcomeId);
            list.Count().Should().BeGreaterOrEqualTo(p0, "Because otherwise not enough outcomes have been loaded for this customer");
            var item = list.ElementAt(p0 - 1);

            // check that this outcome is included in the report
            var checkList = ReportRows.Where(j => j.OutcomeID.ToLower() == item.ParentId.ToLower());
            checkList.Count().Should().BeGreaterThan(0, "Because otherwise Outcome " + p0 + " for the test customer " + p1 + "has been unexpectedly ommited from the report");
            checkList.Count().Should().Be(1, "Because otherwise Outcome " + p0 + " for the test customer " + p1 + "has been duplicated in the report");
            var results = checkList.ElementAt<ReportRow>(0);
            // now check table data, first process an tokens
            Table updatedData = DataLoadHelper<LoadCustomer>.ReplaceTokensInTable(table);
            ReportRow checkData = updatedData.CreateInstance<ReportRow>();

            //populate with outcome id
            checkData.OutcomeID = item.ParentId;

            //populate with parent IDs
            foreach ( var parents in item.AllParents)
            {
                switch (parents.Key)
                {
                    case constants.CustomerId:
                        checkData.CustomerId = parents.Value;
                        break;
                    case constants.ActionPlanId:
                        checkData.ActionPlanID = parents.Value;
                        break;
                }
            }


            Console.WriteLine("CustomerId Match: " + (checkData.CustomerId == results.CustomerId ? "Yes" : "No" ) );
            Console.WriteLine("DateofBirth Match: " + (checkData.DateofBirth == results.DateofBirth ? "Yes" : "No"));
            Console.WriteLine("HomePostCode Match: " + (checkData.HomePostCode == results.HomePostCode ? "Yes" : "No"));
            Console.WriteLine("ActionPlanID Match: " + (checkData.ActionPlanID == results.ActionPlanID ? "Yes" : "No"));
            Console.WriteLine("SessionDate Match: " + (checkData.SessionDate == results.SessionDate ? "Yes" : "No"));
            Console.WriteLine("SubContractorId Match: " + (checkData.SubContractorId == results.SubContractorId ? "Yes" : "No"));
            Console.WriteLine("AdviserName Match: " + (checkData.AdviserName == results.AdviserName ? "Yes" : "No"));
            Console.WriteLine("OutcomeID Match: " + (checkData.OutcomeID == results.OutcomeID ? "Yes" : "No"));
            Console.WriteLine("OutcomeType Match: " + (checkData.OutcomeType == results.OutcomeType ? "Yes" : "No"));
            Console.WriteLine("OutcomeEffectiveDate Match: " + (checkData.OutcomeEffectiveDate == results.OutcomeEffectiveDate ? "Yes" : "No"));
            Console.WriteLine("OutcomePriorityCustomer Match: " + (checkData.OutcomePriorityCustomer == results.OutcomePriorityCustomer ? "Yes" : "No"));

            string becauseText = "Because that is defined result for " + p1 + ", outcome " + p0;
            results.CustomerId.Should().Be(checkData.CustomerId, becauseText);
            results.DateofBirth.Should().Be(checkData.DateofBirth, becauseText);
            results.HomePostCode.Should().Be(checkData.HomePostCode, becauseText);
            results.ActionPlanID.Should().Be(checkData.ActionPlanID, becauseText);
            results.SessionDate.Should().Be(checkData.SessionDate, becauseText);
            results.SubContractorId.Should().Be(checkData.SubContractorId, becauseText);
            results.AdviserName.Should().Be(checkData.AdviserName, becauseText);
            results.OutcomeID.Should().Be(checkData.OutcomeID, becauseText);
            results.OutcomeType.Should().Be(checkData.OutcomeType, becauseText);
            results.OutcomeEffectiveDate.Should().Be(checkData.OutcomeEffectiveDate, becauseText);
            results.OutcomePriorityCustomer.Should().Be(checkData.OutcomePriorityCustomer, becauseText);
        }


        [Given(@"I post a report request for ukprn (.*)")]
        public void GivenIPostAReportRequestForUkprn(int p0)
        {
            string url = envSettings.BaseUrl + "/collections/api/collections";
            string json = "{ UKPRN : \"" + p0.ToString() + "\" }";
            response = Post(url, json, envSettings.TouchPointId, envSettings.SubscriptionKey, string.Empty);
            collectionId = AssertAndExtract("CollectionId", response);
        }

        [Given(@"I post a report request with missing ukprn")]
        public void GivenIPostAReportRequestWithMissingUkprn()
        {
            string url = envSettings.BaseUrl + "/collections/api/collections";
            string json = "{ UKPRNOT : \"12345678\" }";
            response = Post(url, json, envSettings.TouchPointId, envSettings.SubscriptionKey, string.Empty);
        }


        [When(@"I get the report")]
        public void WhenIGetTheReport()
        {
            string url = envSettings.BaseUrl + "/collections/api/collections/"+ collectionId;
            response = Get(url, envSettings.TouchPointId, envSettings.SubscriptionKey);
        }


        [Given(@"a report is loaded into storage")]
        public void GivenAReportIsLoadedIntoStorage()
        {
            string filePath;
            AzureStorageHelper blobStore = new AzureStorageHelper();
            blobStore.Initialise(envSettings.StorageConnectionString, envSettings.StorageContainerName);
            filePath = envSettings.TouchPointId + "/" + collectionId + "/NCS-Reports.zip";
            blobStore.WriteBlobAsFile(filePath, AppDomain.CurrentDomain.SetupInformation.ApplicationBase + "TestResource\\NCS-Reports.zip");
            
        }

        [Given(@"The current date is ""(.*)""")]
        public void GivenTheCurrentDateIs(string p0)
        {
            ReportDate = DateTime.Parse(p0);

        }

        [Given(@"The service start date is ""(.*)""")]
        public void GivenTheServiceStartDateIs(string p0)
        {
            FeedStartDate = DateTime.Parse(p0);
        }

        [Given(@"the report period start date is ""(.*)""")]
        public void GivenTheReportPeriodStartDateIs(string p0)
        {
            ReportPeriodStartDate = DataLoadHelper<ILoader>.TranslateDateToken(p0);
        }

        [Given(@"the report period end date is ""(.*)""")]
        public void GivenTheReportPeriodEndDateIs(string p0)
        {
            ReportPeriodEndDate = DataLoadHelper<ILoader>.TranslateDateToken(p0);
        }

        [Given(@"I have an invalid collection id")]
        public void GivenIHaveAnInvalidCollectionId()
        {
            collectionId = new Guid().ToString();
        }


    }
}
