using NCS.DSS.Collections.Models;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.DataStore
{
    public interface ICollectionDataStore
    {
        Task<List<Collection>> GetCollections();
        Task<Collection> GetCollectionById(Guid collectionId);
        Task<bool> InsertCollection(Collection collection);
    }
}
