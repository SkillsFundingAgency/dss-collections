using NCS.DSS.Collections.Models;

namespace NCS.DSS.Collections.Helpers
{
    public class DataCollectionsReportHelper : IDataCollectionsReportHelper
    {
        private const string reportName = "NCS-Reports.zip";
        private const string fileNameSeparator = "/";

        public string ContainerName => Environment.GetEnvironmentVariable("DCContainerName");

        public string FileName(Collection collection)
        {
            return $"{collection.TouchPointId}{fileNameSeparator}{collection.CollectionId}{fileNameSeparator}{reportName}";
        }
    }
}
