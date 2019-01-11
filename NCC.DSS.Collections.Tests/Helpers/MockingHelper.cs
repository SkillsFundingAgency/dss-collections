using DFC.HTTP.Standard;
using DFC.Swagger.Standard;
using Microsoft.Extensions.Logging;
using Moq;
using NCS.DSS.Collections.ContentExtractors;
using NCS.DSS.Collections.Validators;

namespace NCC.DSS.Collections.Tests.Helpers
{
    public static class MockingHelper
    {
        public static ICollectionValidator GetMockValidator()
        {
            return new Mock<ICollectionValidator>() as ICollectionValidator;
        }

        public static ICollectionExtractor GetMockExtractor()
        {
            return new Mock<ICollectionExtractor>() as ICollectionExtractor;
        }

        public static ILogger GetMockLogger()
        {
            return new Mock<ILogger>() as ILogger;
        }

        public static ISwaggerDocumentGenerator GetMockSwaggerGenerator()
        {
            return new Mock<ISwaggerDocumentGenerator>() as ISwaggerDocumentGenerator;
        }

        public static IHttpRequestHelper GetHttpRequestHelper()
        {
            return new Mock<IHttpRequestHelper>() as IHttpRequestHelper;
        }
    }
}
