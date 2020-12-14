using DFC.Swagger.Standard;
using Microsoft.AspNetCore.Http;
using Moq;
using NCC.DSS.Collections.Tests.Helpers;
using NCS.DSS.Collections.APIDefinition;
using NUnit.Framework;

namespace NCC.DSS.Collections.Tests
{
    [TestFixture]
    public class APIDefinitionTests
    {
        private ApiDefinition function;
        private Mock<ISwaggerDocumentGenerator> swaggerGenerator;

        [SetUp]
        public void Setup()
        {
            swaggerGenerator = new Mock<ISwaggerDocumentGenerator>();
            function = new ApiDefinition(swaggerGenerator.Object);
        }

        [Test]
        public void API_Definition_RunAsync_Test()
        {
            //Assign
            HttpRequest req = new Mock<HttpRequest>().Object;

            //Act
            var res = function.Run(req);

            //Assert
            Assert.IsNotNull(res);
        }

        [Test]
        public void API_Definition_RunAsync_Cause_Exception()
        {
            //Assign
            HttpRequest req = null;

            //Act
            var res = function.Run(req);

            //Assert
            Assert.IsNotNull(res);
        }
    }
}
