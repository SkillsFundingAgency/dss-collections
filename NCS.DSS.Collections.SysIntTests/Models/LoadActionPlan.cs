using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace NCS.DSS.Collections.SysIntTests.Models
{
    class LoadActionPlan : ActionPlan, ILoader
    {
        public string LoaderRef { get; set; }
        public string ParentRef { get; set; }
        [JsonIgnore]
        public string SubcontractorId { get; set; }
    }
}
