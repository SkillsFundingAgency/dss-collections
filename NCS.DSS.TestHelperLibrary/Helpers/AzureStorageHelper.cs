using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Auth;
using Microsoft.WindowsAzure.Storage.Blob;
using Microsoft.WindowsAzure.Storage.RetryPolicies;

namespace NCS.DSS.TestHelperLibrary.Helpers
{
    public class AzureStorageHelper
    {
        CloudStorageAccount storageAccount;
        CloudBlobClient serviceClient;
        CloudBlobContainer serviceContainer;

        public void Initialise(string connectionString, string countainerName )
        {
            storageAccount = CloudStorageAccount.Parse(connectionString);
            storageAccount.CreateCloudBlobClient();
            serviceClient =  storageAccount.CreateCloudBlobClient();

            serviceContainer = serviceClient.GetContainerReference(countainerName);
            serviceContainer.CreateIfNotExists();
        }

        public bool WriteBlobAsText(string name, string text)
        {
            bool success = true;
            try
            {
                // write a blob to the container
                CloudBlockBlob blob = serviceContainer.GetBlockBlobReference(name);
                blob.UploadTextAsync(text).Wait();
            }
            catch (Exception e) 
            {
                Console.WriteLine("error uploading blob text: " + e.Message);
                success = false;
            }

            return success;
        }

       
        public string WriteBlobAsFile(string name, string fileName)
        {
            string blobLocation = "";
            try
            {
                // Retrieve reference to a blob named "myblob".
                CloudBlockBlob blockBlob = serviceContainer.GetBlockBlobReference(name);

                // Create or overwrite the "myblob" blob with contents from a local file.
                using (var fileStream = System.IO.File.OpenRead(fileName))
                {
                    blockBlob.UploadFromStream(fileStream);
                }
                blobLocation = blockBlob.StorageUri.PrimaryUri.ToString();
            }
            catch (Exception e)
            {
                Console.WriteLine("error uploading blob text: " + e.Message);
            }

            return blobLocation;
        }

        public bool DeleteBlob(string name)
        {
            try
            {
                // Retrieve reference to a blob named "myblob".
                CloudBlockBlob blockBlob = serviceContainer.GetBlockBlobReference(name);
                blockBlob.Delete();
            }
            catch (Exception e)
            {
                Console.WriteLine("error deleting blob text: " + e.Message);
            }
            return false;
        }

    }
}
