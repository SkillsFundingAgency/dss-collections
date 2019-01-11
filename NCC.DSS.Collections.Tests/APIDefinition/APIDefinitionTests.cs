using Microsoft.AspNetCore.Http;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using NCC.DSS.Collections.Tests.Helpers;
using NCS.DSS.Collections.APIDefinition;

namespace NCC.DSS.Collections.Tests
{
    [TestClass]
    public class APIDefinitionTests
    {
        [TestMethod]
        [DataRow("http://localhost/")]
        [DataRow("https://localhost/")]
        public void API_Definition_RunAsync_Test(string url)
        {
            //Assign
            HttpRequest req = new Mock<HttpRequest>().Object;            
            //req.RequestUri = new Uri(url);

            //Act
            var res = ApiDefinition.RunAsync(req, MockingHelper.GetMockLogger(), MockingHelper.GetMockSwaggerGenerator());

            //Assert
            Assert.IsNotNull(res);
        }
    }
}
