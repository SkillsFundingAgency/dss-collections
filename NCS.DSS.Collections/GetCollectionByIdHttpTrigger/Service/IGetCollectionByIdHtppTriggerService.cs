using Microsoft.Extensions.Logging;
using System;
using System.IO;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service
{
    public interface IGetCollectionByIdHtppTriggerService
    {
        Task<MemoryStream> ProcessRequestAsync(string touchPointId, Guid collectionId, ILogger log);
    }
}
