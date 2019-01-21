using DFC.Common.Standard.Logging;
using DFC.Functions.DI.Standard.Attributes;
using DFC.HTTP.Standard;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.Models;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.GetCollectionsHttpTrigger.Service
{
    public class GetCollectionsHttpTriggerService : IGetCollectionsHttpTriggerService
    {
        private readonly IHttpRequestHelper _requestHelper;        
        private readonly IDocumentDBProvider _documentDBProvider;
        public GetCollectionsHttpTriggerService([Inject]IHttpRequestHelper requestHelper,                                                 
                                                [Inject]IDocumentDBProvider documentDBProvider)
        {
            _requestHelper = requestHelper;            
            _documentDBProvider = documentDBProvider;
        }
        public async Task<List<Collection>> ProcessRequestAsync(Guid touchpointId)
        {
            //return await _documentDBProvider.GetCollectionsForTouchpointAsync(touchpointId);

            return new List<Collection>
            {
                new Collection
                {
                    CollectionId = Guid.NewGuid(),
                    CollectionReports = new Uri("http://localhost"),
                    LastModifiedDate = DateTime.Now,
                    TouchPointId = touchpointId,
                    UKPRN = "12345678"
                },
                new Collection
                {
                    CollectionId = Guid.NewGuid(),
                    CollectionReports = new Uri("http://localhost"),
                    LastModifiedDate = DateTime.Now,
                    TouchPointId = touchpointId,
                    UKPRN = "12345678"
                }
            };
        }
    }
}
