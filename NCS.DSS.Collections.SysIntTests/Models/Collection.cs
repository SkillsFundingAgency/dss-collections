
using Newtonsoft.Json;
using System;
using System.ComponentModel.DataAnnotations;

namespace NCS.DSS.Collections.SysIntTests.Models
{
    public class Collection
    {
        [JsonProperty(PropertyName = "id")]
        public Guid CollectionId { get; set; }

        public string TouchPointId { get; set; }
        public string CollectionReports { get; set; }

        public string UKPRN { get; set; }

        public DateTime? LastModifiedDate { get; set; }
    }
}
