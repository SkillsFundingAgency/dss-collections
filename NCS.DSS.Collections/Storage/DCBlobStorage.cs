using Azure.Storage.Blobs;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Helpers;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.Storage.Configuration;


namespace NCS.DSS.Collections.Storage
{
    public class DCBlobStorage : IDCBlobStorage
    {
        private readonly IStorageConfiguration _storageConfiguration;
        private readonly ICloudBlobStreamHelper _cloudBlobStreamHelper;
        private readonly ILogger<DCBlobStorage> _logger;

        public DCBlobStorage(IStorageConfiguration storageConfiguration,
                             ICloudBlobStreamHelper cloudBlobStreamHelper,
                             ILogger<DCBlobStorage> logger)
        {
            _storageConfiguration = storageConfiguration;
            _cloudBlobStreamHelper = cloudBlobStreamHelper;
            _logger = logger;
        }

        public async Task<MemoryStream> Get(PersistedCollection collection)
        {
            var resultStream = new MemoryStream();
            var correlationGuidId = Guid.NewGuid();
            var blobContainer = new BlobContainerClient(_storageConfiguration.ConnectionString, collection.ContainerName);

            try
            {
                BlobClient blob = blobContainer.GetBlobClient(collection.ReportFileName);

                if (await blob.ExistsAsync())
                {
                    resultStream = await _cloudBlobStreamHelper.MakeStream(blob);
                }
                else
                {
                    _logger.LogError($"Unable to locate Data Collections Report File - {0}", collection.ReportFileName);
                    return null;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError($"Failed to get Blob file. Error: [{ex.Message}] and Stack Trace: [{ex.StackTrace}]");
            }
            return resultStream;

        }
    }
}
