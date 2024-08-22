using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Models;

namespace NCS.DSS.Collections.Storage
{
    public interface IDCBlobStorage
    {
        Task<MemoryStream> Get(PersistedCollection collection, ILogger log);
    }
}
