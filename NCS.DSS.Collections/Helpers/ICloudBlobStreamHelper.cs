using Microsoft.WindowsAzure.Storage.Blob;
using System.IO;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.Helpers
{
    public interface ICloudBlobStreamHelper
    {
        Task<MemoryStream> MakeStream(CloudBlob blob);
    }
}
