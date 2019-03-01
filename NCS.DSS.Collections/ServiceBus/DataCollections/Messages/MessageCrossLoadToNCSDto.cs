using System;
using System.Collections.Generic;
using System.Text;

namespace NCS.DSS.Collections.ServiceBus.DataCollections.Messages
{
    [Serializable]
    public sealed class MessageCrossLoadToNCSDto
    {

        /// <summary>
        /// Unique job id of job.
        /// </summary>
        public Guid JobId { get; set; }


        /// <summary>
        /// The status of the job (expecting Success)
        /// </summary>
        public string Status { get; set; }

    }

}
