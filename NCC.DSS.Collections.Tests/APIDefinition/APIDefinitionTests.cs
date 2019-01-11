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
        public void API_Definition_RunAsync_Test()
        {
            //Assign
            HttpRequest req = new Mock<HttpRequest>().Object;                        

            //Act
            var res = ApiDefinition.RunAsync(req, MockingHelper.GetMockLogger(), MockingHelper.GetMockSwaggerGenerator());

            //Assert
            Assert.IsNotNull(res);
        }
    }
}
