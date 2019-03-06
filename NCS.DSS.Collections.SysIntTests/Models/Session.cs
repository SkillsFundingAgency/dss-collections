using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.SysIntTests.Models
{
    class Session
    {

        public string SessionId { get; set; }
        public string CustomerId { get; set; }
        public string InteractionId { get; set; }
        public string DateandTimeOfSession { get; set; }
        public string VenuePostCode { get; set; }
        public string SessionAttended { get; set; }
        public string ReasonForNonAttendance { get; set; }
        public string LastModifiedDate { get; set; }
        public string LastModifiedTouchpointID { get; set; }

    }
}
