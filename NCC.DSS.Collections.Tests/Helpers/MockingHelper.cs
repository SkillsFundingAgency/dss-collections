using DFC.Common.Standard.Logging;
using Microsoft.Extensions.Logging;
using Moq;
using NCS.DSS.Collections.Cosmos.Provider;
using NUnit.Framework;

namespace NCC.DSS.Collections.Tests.Helpers
{
    public static class MockingHelper
    {        
        //public static Mock<ILogger> GetMockLogger()
        //{
        //    return new Mock<ILogger>();            
        //}        

        public static Mock<ILoggerHelper> GetMockLoggerHelper()
        {
            return new Mock<ILoggerHelper>();            
        }

        public static Mock<IDocumentDBProvider> GetMockDBProvider()
        {
            return new Mock<IDocumentDBProvider>();                        
        }
    }
}
