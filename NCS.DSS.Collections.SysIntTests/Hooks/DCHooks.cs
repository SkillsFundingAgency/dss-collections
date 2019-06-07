using FluentAssertions;
using NCS.DSS.Collections.SysIntTests.Helpers;
using NCS.DSS.Collections.SysIntTests.Models;
using NCS.DSS.TestHelperLibrary.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;


namespace NCS.DSS.Collections.SysIntTests.Hooks
{
    [Binding]
    public sealed class DCHooks
    {
        // For additional details on SpecFlow hooks see http://go.specflow.org/doc-hooks
        private readonly ScenarioContext scenarioContext;

        public DCHooks(ScenarioContext context)
        {
            scenarioContext = context;
         }

        [BeforeScenario]
        public void BeforeScenario()
        {
            //TODO: implement logic that has to run before executing each scenario
        }

        [AfterFeature]
        public static void AfterFeature()
        {
            List<Loader> testData;
            try
            {
                testData = (List<Loader>)FeatureContext.Current["TestData"];
            }
            catch (Exception e)
            {
                Console.WriteLine("Feature Cleanup: No data found to tear down");
                return;
            }
            Console.WriteLine("Feature Cleanup: About to process teardown list");

            TearDownData(testData);
        }


        private static bool TearDownData(List<Loader> testData)
        {
            //return true;
            SQLServerHelper sqlHelper = new SQLServerHelper();
            EnvironmentSettings envSettings = new EnvironmentSettings();
            CosmosHelper.Initialise(envSettings.CosmosEndPoint, envSettings.CosmosAccountKey);
            sqlHelper.SetConnection(envSettings.SqlConnectionString);
            // loop through the data load list and check each is now in the SQL server data store
            foreach (var item in testData)
            {
                if (item.LoadedToSqlServer) // temp measure until change feed has been delivered
                                            // may not be required in all cases if change feed sends deletes
                {
                    sqlHelper.AddReplacementRule(item.ParentType, "id");
                    Console.WriteLine("Delete from SQL server " + item.ParentType + " : " + item.ParentId);
                    var result = sqlHelper.DeleteRecord(constants.BackupTableNameFromId(item.ParentType), item.ParentType, item.ParentId);
                    result.Should().BeTrue("Because otherwise a record was not deleted");
                }
                Console.WriteLine("Delete from Document Store " + item.ParentType + " : " + item.ParentId);
                CosmosHelper.DeleteDocument(constants.CollectionNameFromId(item.ParentType), constants.CollectionNameFromId(item.ParentType), item.ParentId);
            }
            sqlHelper.CloseConnection();
            return true;
        }
        [AfterScenario]
        public void AfterScenario()
        {
            List<Loader> testData;

            try
            {
                testData = (List<Loader>)scenarioContext["TestData"];
            }
            catch ( Exception e)
            {
                Console.WriteLine("Scenario Cleanup: No data found to tear down");
                return;
            }
            Console.WriteLine("Scenario Cleanup: About to process teardown list");
            TearDownData(testData);
           
        }
    }
}
