using Azure.Storage.Blobs;
using System.IO;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.Helpers
{
    public class CloudBlobStreamHelper : ICloudBlobStreamHelper
    {
        public async Task<MemoryStream> MakeStream(BlobClient blob)
        {
            var memoryStream = new MemoryStream();

            var result = await blob.DownloadStreamingAsync();
            await result.Value.Content.CopyToAsync(memoryStream);

            return memoryStream;
        }
    }
}
