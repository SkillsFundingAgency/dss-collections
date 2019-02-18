﻿using NCS.DSS.Collections.Models;
using System;
using System.IO;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service
{
    public interface IGetCollectionByIdHtppTriggerService
    {
        Task<MemoryStream> ProcessRequestAsync(Guid touchPointId, Guid collectionId);
    }
}
