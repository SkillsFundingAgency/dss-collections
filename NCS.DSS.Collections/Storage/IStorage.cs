using Microsoft.WindowsAzure.Storage.File;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.Storage
{
    public interface IStorage
    {
        Task<CloudFile> Get(string filename);
    }
}
