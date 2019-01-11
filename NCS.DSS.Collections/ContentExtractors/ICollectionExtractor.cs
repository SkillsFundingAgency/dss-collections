using NCS.DSS.Collections.Models;
using System.Net.Http;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.ContentExtractors
{
    public interface ICollectionExtractor
    {
        Task<T> Extract<T>(HttpRequestMessage req);        
    }
}
