

using DFC.Functions.DI.Standard;
using DFC.Swagger.Standard;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Hosting;
using Microsoft.Extensions.DependencyInjection;
using NCS.DSS.Collections.IoC;

[assembly: WebJobsStartup(typeof(WebJobsExtensionStartup), "Web Jobs Extension Startup")]

namespace NCS.DSS.Collections.IoC
{
    public class WebJobsExtensionStartup : IWebJobsStartup
    {
        public void Configure(IWebJobsBuilder builder)
        {
            builder.AddDependencyInjection();

            //ConfigureServices(builder);
            //ConfigureHelpers(builder);
            //ConfigureValidators(builder);
            //ConfigureLogging(builder);
            //ConfigureServiceBuses(builder);
            ConfigureSwaggerGeneration(builder);
            //ConfigureDataStorage(builder);
            //ConfigureConfigs(builder);
        }

        //private void ConfigureConfigs(IWebJobsBuilder builder)
        //{
        //    builder.Services.AddSingleton<IStorageConfiguration, StorageConfiguration>();
        //    builder.Services.AddSingleton<IDssServiceBusConfig, DssServiceBusConfig>();
        //    builder.Services.AddSingleton<IDataCollectionsServiceBusConfig, DataCollectionsServiceBusConfig>();
        //    builder.Services.AddSingleton<IContentEnhancerMessageBusConfig, ContentEnhancerMessageBusConfig>();
        //}

        //private void ConfigureServices(IWebJobsBuilder builder)
        //{
        //    builder.Services.AddScoped<IPostCollectionHttpTriggerService, PostCollectionHttpTriggerService>();
        //    builder.Services.AddScoped<IGetCollectionByIdHtppTriggerService, GetCollectionByIdHtppTriggerService>();
        //    builder.Services.AddScoped<IGetCollectionsHttpTriggerService, GetCollectionsHttpTriggerService>();
        //    builder.Services.AddScoped<IDataCollectionsQueueProcessorService, DataCollectionsQueueProcessorService>();
        //}

        //private void ConfigureHelpers(IWebJobsBuilder builder)
        //{
        //    builder.Services.AddScoped<IHttpRequestHelper, HttpRequestHelper>();
        //    builder.Services.AddScoped<IHttpResponseMessageHelper, HttpResponseMessageHelper>();
        //    builder.Services.AddScoped<IJsonHelper, JsonHelper>();
        //    builder.Services.AddScoped<IDataCollectionsFileNameHelper, DataCollectionsFileNameHelper>();            
        //}

        //private void ConfigureServiceBuses(IWebJobsBuilder builder)
        //{            
        //    builder.Services.AddScoped<IDataCollectionsServiceBusConfig, DataCollectionsServiceBusConfig>();
        //    builder.Services.AddScoped<IDataCollectionsMessageProvider, DataCollectionsMessageProvider>();
        //    builder.Services.AddScoped<IDataCollectionsServiceBusClient, DataCollectionsServiceBusClient>();

        //    builder.Services.AddScoped<IDssServiceBusConfig, DssServiceBusConfig>();
        //    builder.Services.AddScoped<IDssMessageProvider, DssMessageProvider>();
        //    builder.Services.AddScoped<IDssServiceBusClient, DssServiceBusClient>();
        //}

        //private void ConfigureValidators(IWebJobsBuilder builder)
        //{
        //    builder.Services.AddScoped<ICollectionValidator, CollectionValidator>();
        //    builder.Services.AddScoped<IDssCorrelationValidator, DssCorrelationValidator>();
        //    builder.Services.AddScoped<IDssTouchpointValidator, DssTouchpointValidator>();
        //}

        //private void ConfigureLogging(IWebJobsBuilder builder)
        //{
        //    builder.Services.AddScoped<ILoggerHelper, LoggerHelper>();
        //}

        private void ConfigureSwaggerGeneration(IWebJobsBuilder builder)
        {
            builder.Services.AddScoped<ISwaggerDocumentGenerator, SwaggerDocumentGenerator>();
        }

        //private void ConfigureDataStorage(IWebJobsBuilder builder)
        //{
        //    builder.Services.AddScoped<IDocumentDBProvider, DocumentDBProvider>();
        //}

        //private void ConfigureBuilder(IWebJobsBuilder builder)
        //{
        //    builder.Services.AddSingleton(builder);
        //}

        //public void Configure(IWebJobsBuilder builder)
        //{
        //    throw new System.NotImplementedException();
        //}
    }
}
