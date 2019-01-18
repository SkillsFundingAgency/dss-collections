using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using NCS.DSS.Collections.Models;

namespace NCS.DSS.Collections.DataStore
{
    public class CollectionDataStore : ICollectionDataStore
    {
        public async Task<Collection> GetCollectionById(Guid collectionId)
        {
            return new Collection()
            {
                CollectionId = Guid.NewGuid(),
                LastModifiedDate = DateTime.Now,
                TouchPointId = Guid.NewGuid(),
                UKPRN = "12345678"
            };
        }

        public async Task<List<Collection>> GetCollections()
        {
            return new List<Collection>()
            {
                new Collection()
                {
                    CollectionId = Guid.NewGuid(),
                    LastModifiedDate = DateTime.Now,
                    TouchPointId = Guid.NewGuid(),
                    UKPRN = "12345678"
                },
                new Collection()
                {
                    CollectionId = Guid.NewGuid(),
                    LastModifiedDate = DateTime.Now,
                    TouchPointId = Guid.NewGuid(),
                    UKPRN = "12345678"
                }
            };
        }

        public async Task<bool> InsertCollection(Collection collection)
        {
            return true;
        }
    }
}
