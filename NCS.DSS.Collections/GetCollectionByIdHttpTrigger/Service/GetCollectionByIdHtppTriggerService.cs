using DFC.Common.Standard.Logging;
using DFC.Functions.DI.Standard.Attributes;
using DFC.HTTP.Standard;
using DFC.JSON.Standard;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.DataStore;
using NCS.DSS.Collections.Models;
using System;
using System.Collections.ObjectModel;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service
{
    public class GetCollectionByIdHtppTriggerService : IGetCollectionByIdHtppTriggerService
    {        
        private readonly IDocumentDBProvider _documentDBProvider;        
        public GetCollectionByIdHtppTriggerService([Inject]IDocumentDBProvider documentDBProvider)
        {            
            _documentDBProvider = documentDBProvider;            
        }
        public async Task<Collection> ProcessRequestAsync(Guid touchPointId, Guid collectionId)
        {
            return await _documentDBProvider.GetCollectionForTouchpointAsync(touchPointId, collectionId);
        }
    }
}
