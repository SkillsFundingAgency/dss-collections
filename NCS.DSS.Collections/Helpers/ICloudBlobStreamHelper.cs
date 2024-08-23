using Azure.Storage.Blobs;

namespace NCS.DSS.Collections.Helpers
{
    public interface ICloudBlobStreamHelper
    {
        Task<MemoryStream> MakeStream(BlobClient blob);
    }
}
