using DFC.HTTP.Standard;
using DFC.JSON.Standard;
using DFC.Swagger.Standard;
using Microsoft.Azure.Functions.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection;
using NCS.DSS.Collections;
using NCS.DSS.Collections.Cosmos.Helper;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service;
using NCS.DSS.Collections.GetCollectionsHttpTrigger.Service;
using NCS.DSS.Collections.Mappers;
using NCS.DSS.Collections.PostCollectionHttpTrigger.Service;
using NCS.DSS.Collections.ServiceBus;
using NCS.DSS.Collections.ServiceBus.DataCollections.Client;
using NCS.DSS.Collections.ServiceBus.Processor.Service;
using NCS.DSS.Collections.Storage;
using NCS.DSS.Collections.Storage.Configuration;
using NCS.DSS.Collections.Validators;

[assembly: FunctionsStartup(typeof(Startup))]
namespace NCS.DSS.Collections
{
    public class Startup : FunctionsStartup
    {
        public override void Configure(IFunctionsHostBuilder builder)
        {
            builder.Services.AddScoped<ISwaggerDocumentGenerator, SwaggerDocumentGenerator>();
            builder.Services.AddTransient<IGetCollectionByIdHtppTriggerService, GetCollectionByIdHtppTriggerService>();
            builder.Services.AddTransient<IGetCollectionsHttpTriggerService, GetCollectionsHttpTriggerService>();
            builder.Services.AddTransient<IPostCollectionHttpTriggerService, PostCollectionHttpTriggerService>();
            builder.Services.AddTransient<IResourceHelper, ResourceHelper>();
            builder.Services.AddTransient<IApimUrlValidator, ApimUrlValidator>();
            builder.Services.AddTransient<ICollectionValidator, CollectionValidator>();
            builder.Services.AddTransient<IDssCorrelationValidator, DssCorrelationValidator>();
            builder.Services.AddTransient<IDssTouchpointValidator, DssTouchpointValidator>();
            builder.Services.AddTransient<IDssSubcontractorValidator, DssSubcontractorValidator>();
            builder.Services.AddTransient<IDCBlobStorage, DCBlobStorage>();
            builder.Services.AddTransient<IStorageConfiguration, StorageConfiguration>();
            builder.Services.AddTransient<IJsonHelper, JsonHelper>();
            builder.Services.AddTransient<IHttpResponseMessageHelper, HttpResponseMessageHelper>();
            builder.Services.AddTransient<IHttpRequestHelper, HttpRequestHelper>();
            builder.Services.AddTransient<IDataCollectionsQueueProcessorService, DataCollectionsQueueProcessorService>();
            builder.Services.AddTransient<IDocumentDBProvider, DocumentDBProvider>(); ;
            builder.Services.AddTransient<IDataCollectionsServiceBusClient, DataCollectionsServiceBusClient>();
            builder.Services.AddTransient<ICollectionMapper, CollectionMapper>();
        }
    }
}
