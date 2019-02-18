using NCS.DSS.Collections.Models;
using System;

namespace NCS.DSS.Collections.Helpers
{
    public class DataCollectionsFileNameHelper : IDataCollectionsFileNameHelper
    {
        public string BuildFileName(Collection collection)
        {
            return "NCS-ABD-" + collection.TouchPointId + "-" + DateTime.UtcNow.ToLongDateString() + ".xml";            
        }
    }
}
