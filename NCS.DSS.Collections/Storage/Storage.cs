using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.File;
using NCS.DSS.Collections.Storage.Configuration;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.Storage
{
    public class Storage : IStorage
    {
        private readonly IStorageConfiguration _storageConfiguration;
        public Storage(IStorageConfiguration storageConfiguration)
        {
            _storageConfiguration = storageConfiguration;
        }
        public async Task<CloudFile> Get(string filename)
        {
            var storageAccount = CloudStorageAccount.Parse(_storageConfiguration.ConnectionString);
            var fileClient = storageAccount.CreateCloudFileClient();

            var shareReference = fileClient.GetShareReference(_storageConfiguration.ShareReference);

            if (await shareReference.ExistsAsync())
            {
                var rootDirectory = shareReference.GetRootDirectoryReference();

                if (await rootDirectory.ExistsAsync())
                {
                    CloudFile file = rootDirectory.GetFileReference(filename);

                    if (await file.ExistsAsync())
                    {
                        return file;
                    }
                    else
                    {
                        return null;
                    }
                }
                else
                {
                    return null;
                }
            }
            else
            {
                return null;
            }

        }
    }
}
