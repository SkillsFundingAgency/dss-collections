using DFC.Common.Standard.Logging;
using DFC.JSON.Standard;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Moq;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.DataStore;
using NCS.DSS.Collections.Models;
using Newtonsoft.Json;
using System;
using System.IO;
using System.Net.Http;
using System.Text;

namespace NCC.DSS.Collections.Tests.Helpers
{
    public static class MockingHelper
    {        
        public static ILogger GetMockLogger()
        {
            return new Mock<ILogger>() as ILogger;
        }        

        public static ILoggerHelper GetMockLoggerHelper()
        {
            return new Mock<ILoggerHelper>() as ILoggerHelper;
        }

        public static ICollectionDataStore GetMockCollectionDataStore()
        {
            return new Mock<ICollectionDataStore>() as ICollectionDataStore;
        }

        public static IDocumentDBProvider GetMockDBProvider()
        {
            return new Mock<IDocumentDBProvider>() as IDocumentDBProvider;
        }
    }
}
