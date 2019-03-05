using System;

namespace NCS.DSS.Collections.Storage.Configuration
{
    public class StorageConfiguration : IStorageConfiguration
    {
        public string ConnectionString => Environment.GetEnvironmentVariable("StorageConnectionString");

        //public string ShareReference => Environment.GetEnvironmentVariable("StorageShareReference");
    }
}
