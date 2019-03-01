using Microsoft.WindowsAzure.Storage.Blob;
using System.IO;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.Helpers
{
    public class CloudBlobStreamHelper : ICloudBlobStreamHelper
    {
        public async Task<MemoryStream> MakeStream(CloudBlob blob)
        {
            Stream memoryStream = new MemoryStream();

            await blob.DownloadToStreamAsync(memoryStream);

            return (MemoryStream)memoryStream;
        }
    }
}
