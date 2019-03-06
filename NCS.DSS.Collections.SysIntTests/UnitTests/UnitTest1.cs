using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading;
using FluentAssertions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using NCS.DSS.Collections.SysIntTests.Helpers;
using NCS.DSS.Collections.SysIntTests.Models;
using NCS.DSS.TestHelperLibrary.Helpers;
using System.Reflection;

namespace NCS.DSS.Collections.SysIntTests.UnitTests
{

    /*  class ShouldSerializeContractResolver : DefaultContractResolver
      {
          public static readonly ShouldSerializeContractResolver Instance = new ShouldSerializeContractResolver();

          protected override JsonProperty CreateProperty(MemberInfo member, MemberSerialization memberSerialization)
          {
              JsonProperty property = base.CreateProperty(member, memberSerialization);

              if (property.DeclaringType == typeof(Customer) && property.PropertyName == "LoaderRef")
              {
                  property.ShouldSerialize =
                      instance =>
                      {
                          Customer e = (Customer)instance;
                          return e.LoaderRef != e.LoaderRef;
                      };
              }

              return property;
          }
      }*/

    
    [TestClass]
    public class UnitTest1
    {
        private EnvironmentSettings envSettings = new EnvironmentSettings();
        private readonly List<Loader> LoaderData = new List<Loader>();

        [TestMethod]
        [Ignore]
        public void CreateCosmosRecordFromJson()
        {
            CosmosHelper.Initialise(envSettings.CosmosEndPoint, envSettings.CosmosAccountKey);
            Customer c = new Customer();
            c.DateofBirth = DateTime.Today.ToShortDateString();
            string response;

            bool retVl =  CosmosHelper.InsertDocumentFromJson("notifications", "notifications", JsonConvert.SerializeObject(c), out response);
            retVl.Should().BeTrue("Because a record should have been created");
            var id = JsonHelper.GetPropertyFromJsonString(response, "id");
            retVl = CosmosHelper.DeleteDocument("notifications", "notifications", id);
            retVl.Should().BeTrue("Because a record should have been deleted");

        }

        [TestMethod]
        [Ignore]
        public void CreateCosmosRecordFromObj()
        {
            CosmosHelper.Initialise(envSettings.CosmosEndPoint, envSettings.CosmosAccountKey);
            Customer c = new Customer();
            c.DateofBirth = DateTime.Today.ToShortDateString();
            string response;
            bool retVl = CosmosHelper.InsertDocumentFromJson("notifications", "notifications", c, out response);
            retVl.Should().BeTrue("Because a record should have been created");
            var id = JsonHelper.GetPropertyFromJsonString(response, "id");
            retVl = CosmosHelper.DeleteDocument("notifications", "notifications", id);
            retVl.Should().BeTrue("Because a record should have been deleted");
        }
    }
}
