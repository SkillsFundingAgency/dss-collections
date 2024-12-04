using Azure.Messaging.ServiceBus;
using DFC.HTTP.Standard;
using DFC.Swagger.Standard;
using Microsoft.Azure.Cosmos;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Cosmos.Helper;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service;
using NCS.DSS.Collections.GetCollectionsHttpTrigger.Service;
using NCS.DSS.Collections.Helpers;
using NCS.DSS.Collections.Mappers;
using NCS.DSS.Collections.PostCollectionHttpTrigger.Service;
using NCS.DSS.Collections.ServiceBus;
using NCS.DSS.Collections.ServiceBus.Configs;
using NCS.DSS.Collections.ServiceBus.ContentEnhancer;
using NCS.DSS.Collections.ServiceBus.ContentEnhancer.Client;
using NCS.DSS.Collections.ServiceBus.DataCollections.Client;
using NCS.DSS.Collections.ServiceBus.DataCollections.Config;
using NCS.DSS.Collections.ServiceBus.Messages.ContentEnhancer;
using NCS.DSS.Collections.ServiceBus.Messages.DataCollections;
using NCS.DSS.Collections.ServiceBus.Processor.Service;
using NCS.DSS.Collections.Storage;
using NCS.DSS.Collections.Storage.Configuration;
using NCS.DSS.Collections.Validators;

namespace NCS.DSS.Collections
{
    internal class Program
    {
        private static async Task Main(string[] args)
        {
            var host = new HostBuilder()
                .ConfigureFunctionsWebApplication()
                .ConfigureServices(services =>
                {
                    services.AddApplicationInsightsTelemetryWorkerService();
                    services.ConfigureFunctionsApplicationInsights();

                    services.AddScoped<ISwaggerDocumentGenerator, SwaggerDocumentGenerator>();
                    services.AddTransient<IGetCollectionByIdHttpTriggerService, GetCollectionByIdHttpTriggerService>();
                    services.AddTransient<IGetCollectionsHttpTriggerService, GetCollectionsHttpTriggerService>();
                    services.AddTransient<IPostCollectionHttpTriggerService, PostCollectionHttpTriggerService>();
                    services.AddTransient<IResourceHelper, ResourceHelper>();
                    services.AddTransient<IApimUrlValidator, ApimUrlValidator>();
                    services.AddTransient<ICollectionValidator, CollectionValidator>();
                    services.AddTransient<IDssCorrelationValidator, DssCorrelationValidator>();
                    services.AddTransient<IDssTouchpointValidator, DssTouchpointValidator>();
                    services.AddTransient<IDCBlobStorage, DCBlobStorage>();
                    services.AddTransient<IStorageConfiguration, StorageConfiguration>();
                    services.AddTransient<IHttpResponseMessageHelper, HttpResponseMessageHelper>();
                    services.AddTransient<IHttpRequestHelper, HttpRequestHelper>();
                    services.AddTransient<IDataCollectionsQueueProcessorService, DataCollectionsQueueProcessorService>();
                    services.AddTransient<ICosmosDbProvider, CosmosDbProvider>(); ;
                    services.AddTransient<IDataCollectionsServiceBusClient, DataCollectionsServiceBusClient>();
                    services.AddTransient<ICollectionMapper, CollectionMapper>();

                    services.AddScoped<IContentEnhancerMessageBusConfig, ContentEnhancerMessageBusConfig>();
                    services.AddScoped<IDataCollectionsServiceBusConfig, DataCollectionsServiceBusConfig>();

                    services.AddScoped<IContentEnhancerServiceBusClient, ContentEnhancerServiceBusClient>();

                    services.AddScoped<IContentEnhancerMessageProvider, ContentEnhancerMessageProvider>();
                    services.AddScoped<IDataCollectionsMessageProvider, DataCollectionsMessageProvider>();

                    services.AddScoped<IDCBlobStorage, DCBlobStorage>();

                    services.AddScoped<IDataCollectionsReportHelper, DataCollectionsReportHelper>();
                    services.AddScoped<ICloudBlobStreamHelper, CloudBlobStreamHelper>();

                    services.AddSingleton<IDynamicHelper, DynamicHelper>();

                    services.AddSingleton(s =>
                    {
                        var options = new CosmosClientOptions() { ConnectionMode = ConnectionMode.Gateway };
                        var cosmosEndpoint = Environment.GetEnvironmentVariable("Endpoint");
                        var cosmosKey = Environment.GetEnvironmentVariable("Key");

                        return new CosmosClient(cosmosEndpoint, cosmosKey, options);
                    });

                    services.AddSingleton(s =>
                    {
                        var serviceBusConnectionString = Environment.GetEnvironmentVariable("ServiceBusConnectionString");
                        return new ServiceBusClient(serviceBusConnectionString);
                    });

                    services.Configure<LoggerFilterOptions>(options =>
                    {
                        LoggerFilterRule toRemove = options.Rules.FirstOrDefault(rule => rule.ProviderName
                            == "Microsoft.Extensions.Logging.ApplicationInsights.ApplicationInsightsLoggerProvider");
                        if (toRemove is not null)
                        {
                            options.Rules.Remove(toRemove);
                        }
                    });
                })
                .Build();

            await host.RunAsync();
        }
    }
}
