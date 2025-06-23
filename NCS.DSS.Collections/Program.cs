using Azure.Identity;
using Azure.Messaging.ServiceBus;
using DFC.HTTP.Standard;
using DFC.Swagger.Standard;
using Microsoft.Azure.Cosmos;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using NCS.DSS.Collections.Cosmos.Helper;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service;
using NCS.DSS.Collections.GetCollectionsHttpTrigger.Service;
using NCS.DSS.Collections.Helpers;
using NCS.DSS.Collections.Mappers;
using NCS.DSS.Collections.Models;
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
                .ConfigureServices((context, services) =>
                {
                    var configuration = context.Configuration;
                    services.AddOptions<CollectionConfigurationSettings>()
                        .Bind(configuration);

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
                        var logger = s.GetRequiredService<ILogger<Program>>();

                        var connectionString = configuration["StorageConnectionString"];
                        var endpoint = configuration["CosmosDbEndpoint"];

                        var options = new CosmosClientOptions
                        {
                            ConnectionMode = ConnectionMode.Gateway
                        };

                        if (!string.IsNullOrWhiteSpace(endpoint))
                        {
                            logger.LogInformation("Using DefaultAzureCredential for Cosmos DB (managed identity)");
                            return new CosmosClient(endpoint, new DefaultAzureCredential(), options);
                        }
                        else if (!string.IsNullOrWhiteSpace(connectionString))
                        {
                            logger.LogInformation("No managed identity found: using Cosmos DB connection string (local development)");
                            return new CosmosClient(connectionString, options);
                        }
                        else
                        {
                            throw new InvalidOperationException("Neither CosmosDbEndpoint or a ConnectionString are configured");
                        }
                    });

                    services.AddSingleton(s =>
                    {
                        var settings = s.GetRequiredService<IOptions<CollectionConfigurationSettings>>().Value;
                        return new ServiceBusClient(settings.ServiceBusConnectionString);
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
