using DFC.Swagger.Standard;
using Microsoft.AspNetCore.Http;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using NCC.DSS.Collections.Tests.Helpers;
using NCS.DSS.Collections.APIDefinition;
using NUnit.Framework;

namespace NCC.DSS.Collections.Tests
{
    [TestFixture]
    public class APIDefinitionTests
    {
        [Test]
        public void API_Definition_RunAsync_Test()
        {
            //Assign
            HttpRequest req = new Mock<HttpRequest>().Object;
            ISwaggerDocumentGenerator swaggerGenerator = new SwaggerDocumentGenerator();

            //Act
            var res = ApiDefinition.Run(req);

            //Assert
            Assert.IsNotNull(res);
        }

        [Test]
        public void API_Definition_RunAsync_Cause_Exception()
        {
            //Assign
            HttpRequest req = null;
            ISwaggerDocumentGenerator swaggerGenerator = new SwaggerDocumentGenerator();

            //Act
            var res = ApiDefinition.Run(req);

            //Assert
            Assert.IsNotNull(res);
        }
    }
}
