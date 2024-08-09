using Azure.Storage.Blobs;
using DFC.Common.Standard.Logging;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Helpers;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.Storage.Configuration;
using System;
using System.IO;
using System.Threading.Tasks;


namespace NCS.DSS.Collections.Storage
{
    public class DCBlobStorage : IDCBlobStorage
    {
        private readonly IStorageConfiguration _storageConfiguration;
        private readonly ILoggerHelper _loggerHelper;
        private readonly ICloudBlobStreamHelper _cloudBlobStreamHelper;
        public DCBlobStorage(IStorageConfiguration storageConfiguration, ILoggerHelper loggerHelper,
                             ICloudBlobStreamHelper cloudBlobStreamHelper)
        {
            _storageConfiguration = storageConfiguration;
            _loggerHelper = loggerHelper;
            _cloudBlobStreamHelper = cloudBlobStreamHelper;
        }

        public async Task<MemoryStream> Get(PersistedCollection collection, ILogger log)
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
                    _loggerHelper.LogError(log, correlationGuidId, new Exception($"Unable to locate Data Collections Report File - {collection.ReportFileName}"));

                }
            }
            catch (Exception ex)
            {
                _loggerHelper.LogError(log, correlationGuidId, ex);
            }
            finally
            {
                await blobContainer.DeleteAsync();
            }
            return resultStream;

        }
    }
}
