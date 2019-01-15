using NCS.DSS.Collections.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.DataStore
{
    public interface ICollectionDataStore
    {
        Task<List<Collection>> GetCollections();
        Task<Collection> GetCollectionById(string collectionId);
        Task<bool> InsertCollection(Collection collection);
    }
}
