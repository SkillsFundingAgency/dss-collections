using NCS.DSS.Collections.Mappers;
using Newtonsoft.Json;
using System;

namespace NCS.DSS.Collections.ServiceBus.DataCollections.Messages
{
    [Serializable]
    public sealed class MessageCrossLoadFromNCSDto
    {

        /// <summary>
        /// Unique job id of job.
        /// </summary>
        public Guid JobId { get; set; }

        /// <summary>
        /// The TouchpointId of the provider
        /// </summary>
        public string TouchpointId { get; set; }

        /// <summary>
        /// The timestamp of the report request
        /// </summary>
        public string Timestamp { get; set; }

        /// <summary>
        /// The Ukprn of the provider.
        /// </summary>
        public long Ukprn { get; set; }

        /// <summary>
        /// The storage container where the report zip file is stored.
        /// </summary>
        public string ContainerName { get; set; }

        /// <summary>
        /// The requested file name for the report zip file on the storage account.
        /// </summary>
        public string ReportFilename { get; set; }

    }

}
