﻿using System;

namespace NCS.DSS.Collections.Models
{
    public class MessageModel
    {
        public string TitleMessage { get; set; }
        public Guid? CustomerGuid { get; set; }
        public DateTime? LastModifiedDate { get; set; }
        public string URL { get; set; }
        public bool IsNewCustomer { get; set; }
        public string TouchpointId { get; set; }
        public string SubcontractorId { get; set; }
        public bool? DataCollections { get; set; }
    }
}
