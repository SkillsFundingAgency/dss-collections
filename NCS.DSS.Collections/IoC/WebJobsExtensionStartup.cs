using DFC.Common.Standard.Logging;
using DFC.Functions.DI.Standard;
using DFC.HTTP.Standard;
using DFC.JSON.Standard;
using DFC.Swagger.Standard;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Hosting;
using Microsoft.Extensions.DependencyInjection;
using NCS.DSS.Collections.Cosmos.Helper;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service;
using NCS.DSS.Collections.GetCollectionsHttpTrigger.Service;
using NCS.DSS.Collections.Helpers;
using NCS.DSS.Collections.IoC;
using NCS.DSS.Collections.Mappers;
using NCS.DSS.Collections.PostCollectionHttpTrigger.Service;
using NCS.DSS.Collections.ServiceBus;
using NCS.DSS.Collections.ServiceBus.Configs;
using NCS.DSS.Collections.ServiceBus.ContentEnhancer;
using NCS.DSS.Collections.ServiceBus.ContentEnhancer.Client;
using NCS.DSS.Collections.ServiceBus.DataCollections.Config;
using NCS.DSS.Collections.ServiceBus.Messages.ContentEnhancer;
using NCS.DSS.Collections.ServiceBus.Messages.DataCollections;
using NCS.DSS.Collections.ServiceBus.Processor.Service;
using NCS.DSS.Collections.Storage.Configuration;
using NCS.DSS.Collections.Validators;

[assembly: WebJobsStartup(typeof(WebJobsExtensionStartup), "Web Jobs Extension Startup")]

namespace NCS.DSS.Collections.IoC
{
    public class WebJobsExtensionStartup : IWebJobsStartup
    {      
        public void Configure(IWebJobsBuilder builder)
        {
            builder.AddDependencyInjection();

            ConfigureSwagger(builder);
            ConfigureFunctionServices(builder);
            ConfigureServiceBusConfigurations(builder);
            ConfigureServiceBusClients(builder);
            ConfigureMessageProviders(builder);
            ConfigureStorage(builder);
            ConfigureValidators(builder);
            ConfigureHelpers(builder);
            ConfigureValidators(builder);
            ConfigureCosmosProvider(builder);
            ConfigureMappers(builder);
        }

        private void ConfigureSwagger(IWebJobsBuilder builder)
        {
            builder.Services.AddScoped<ISwaggerDocumentGenerator, SwaggerDocumentGenerator>();
        }

        private void ConfigureFunctionServices(IWebJobsBuilder builder)
        {
            builder.Services.AddScoped<IGetCollectionByIdHtppTriggerService, GetCollectionByIdHtppTriggerService>();
            builder.Services.AddScoped<IGetCollectionsHttpTriggerService, GetCollectionsHttpTriggerService>();
            builder.Services.AddScoped<IPostCollectionHttpTriggerService, PostCollectionHttpTriggerService>();
            builder.Services.AddScoped<IDataCollectionsQueueProcessorService, DataCollectionsQueueProcessorService>();            
        }

        private void ConfigureServiceBusConfigurations(IWebJobsBuilder builder)
        {
            builder.Services.AddScoped<IContentEnhancerMessageBusConfig, ContentEnhancerMessageBusConfig>();
            builder.Services.AddScoped<IDataCollectionsServiceBusConfig, DataCollectionsServiceBusConfig>();            
        }

        private void ConfigureServiceBusClients(IWebJobsBuilder builder)
        {
            builder.Services.AddScoped<IContentEnhancerServiceBusClient, ContentEnhancerServiceBusClient>();
            builder.Services.AddScoped<IDataCollectionsServiceBusClient, DataCollectionsServiceBusClient>();            
        }

        private void ConfigureMessageProviders(IWebJobsBuilder builder)
        {
            builder.Services.AddScoped<IContentEnhancerMessageProvider, ContentEnhancerMessageProvider>();
            builder.Services.AddScoped<IDataCollectionsMessageProvider, DataCollectionsMessageProvider>();                      
        }

        private void ConfigureStorage(IWebJobsBuilder builder)
        {
            builder.Services.AddScoped<IStorageConfiguration, StorageConfiguration>();
            builder.Services.AddScoped<Storage.IDCBlobStorage, Storage.DCBlobStorage>();
        }

        private void ConfigureValidators(IWebJobsBuilder builder)
        {
            builder.Services.AddScoped<IApimUrlValidator, ApimUrlValidator>();
            builder.Services.AddScoped<ICollectionValidator, CollectionValidator>();
            builder.Services.AddScoped<IDssCorrelationValidator, DssCorrelationValidator>();
            builder.Services.AddScoped<IDssTouchpointValidator, DssTouchpointValidator>();
            //builder.Services.AddSingleton<IValidate, Validate>();
        }

        private void ConfigureHelpers(IWebJobsBuilder builder)
        {
            builder.Services.AddScoped<IResourceHelper, ResourceHelper>();            
            builder.Services.AddScoped<ILoggerHelper, LoggerHelper>();
            builder.Services.AddScoped<IHttpRequestHelper, HttpRequestHelper>();
            builder.Services.AddScoped<IHttpResponseMessageHelper, HttpResponseMessageHelper>();
            builder.Services.AddScoped<IJsonHelper, JsonHelper>();
            builder.Services.AddScoped<IDataCollectionsReportHelper, DataCollectionsReportHelper>();
            builder.Services.AddScoped<ICloudBlobStreamHelper, CloudBlobStreamHelper>();
        }

        private void ConfigureCosmosProvider(IWebJobsBuilder builder)
        {
            builder.Services.AddScoped<IDocumentDBProvider, DocumentDBProvider>();
        }

        private void ConfigureMappers(IWebJobsBuilder builder)
        {
            builder.Services.AddScoped<ICollectionMapper, CollectionMapper>();
        }
    }
}
