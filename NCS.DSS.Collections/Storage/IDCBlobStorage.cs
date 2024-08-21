using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Models;
using System.IO;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.Storage
{
    public interface IDCBlobStorage
    {
        Task<MemoryStream> Get(PersistedCollection collection, ILogger log);
    }
}
