using DFC.Common.Standard.Logging;
using Microsoft.Extensions.Logging;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;
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
            var correlationGuidId = Guid.NewGuid();

            if (CloudStorageAccount.TryParse(_storageConfiguration.ConnectionString, out var cloudstorageAccount))
            {
                CloudBlobClient blobClient = cloudstorageAccount.CreateCloudBlobClient();

                CloudBlobContainer blobContainer = blobClient.GetContainerReference(collection.ContainerName);                

                CloudBlockBlob blob = blobContainer.GetBlockBlobReference(collection.ReportFileName);

                if (await blob.ExistsAsync())
                {
                    return await _cloudBlobStreamHelper.MakeStream(blob);
                }                
                else
                {
                    _loggerHelper.LogError(log, correlationGuidId, new Exception($"Unable to locate Data Collections Report File - {collection.ReportFileName}"));
                    return null;
                }
            }
            else
            {
                _loggerHelper.LogError(log, correlationGuidId, new Exception($"Unable to location Data Collections storage account - {collection.ContainerName}"));
                return null;
            }
        }
    }
}
