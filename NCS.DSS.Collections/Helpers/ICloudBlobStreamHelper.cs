using Azure.Storage.Blobs;
using System.IO;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.Helpers
{
    public interface ICloudBlobStreamHelper
    {
        Task<MemoryStream> MakeStream(BlobClient blob);
    }
}
