using Microsoft.AspNetCore.Http;
using NCS.DSS.Collections.Models;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service
{
    public interface IGetCollectionByIdHtppTriggerService
    {
        Task<Collection> ProcessRequestAsync(string collectionId);
    }
}
