using DFC.Common.Standard.Logging;
using DFC.Functions.DI.Standard.Attributes;
using DFC.HTTP.Standard;
using DFC.JSON.Standard;
using DFC.Swagger.Standard.Annotations;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service;
using NCS.DSS.Collections.Models;
using System;
using System.ComponentModel.DataAnnotations;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Function
{
    public static class GetCollectionByIdHttpTrigger
    {
        [FunctionName("GetById")]
        [ProducesResponseType(typeof(Collection), (int)HttpStatusCode.OK)]
        [Response(HttpStatusCode = (int)HttpStatusCode.OK, Description = "Collection Plan found", ShowSchema = true)]
        [Response(HttpStatusCode = (int)HttpStatusCode.NoContent, Description = "Collection does not exist", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.BadRequest, Description = "Request was malformed", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Unauthorized, Description = "API key is unknown or invalid", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Forbidden, Description = "Insufficient access", ShowSchema = false)]
        [Display(Name = "Get", Description = "Ability to retrieve a collection for the given collection id")]
        public static async Task<HttpResponseMessage> RunAsync(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "collections/{collectionId}")] HttpRequest req, string collectionId,
            ILogger log,
            [Inject]IGetCollectionByIdHtppTriggerService service,
            [Inject]IJsonHelper jsonHelper,
            [Inject]IHttpRequestHelper requestHelper,
            [Inject]IHttpResponseMessageHelper responseMessageHelper,
            [Inject]ILoggerHelper loggerHelper)
        {            
            log.LogInformation("Get Collection C# HTTP trigger function processing a request. For CollectionId " + collectionId);            

            try
            {
                var correlationId = requestHelper.GetDssCorrelationId(req);

                if (string.IsNullOrEmpty(correlationId))
                    log.LogInformation("Unable to locate 'DssCorrelationId' in request header");

                if (!Guid.TryParse(correlationId, out var correlationGuid))
                {
                    log.LogInformation("Unable to parse 'DssCorrelationId' to a Guid");
                    correlationGuid = Guid.NewGuid();
                }

                var touchpointId = requestHelper.GetDssTouchpointId(req);

                if (string.IsNullOrEmpty(touchpointId))
                {
                    loggerHelper.LogInformationMessage(log, correlationGuid, "Unable to locate 'TouchpointId' in request header");
                    return responseMessageHelper.BadRequest();
                }

                if (!Guid.TryParse(touchpointId, out var touchpointGuid))
                {
                    log.LogInformation("Unable to parse 'DssTouchpointId' to a Guid");                    
                }

                if (!Guid.TryParse(collectionId, out var collectionGuid))
                    return responseMessageHelper.BadRequest(collectionGuid);

                var collection = await service.ProcessRequestAsync(touchpointGuid, collectionGuid);
                
                if (collection == null)
                {
                    return responseMessageHelper.NoContent();
                }

                return responseMessageHelper.Ok(jsonHelper.SerializeObjectAndRenameIdProperty<Collection>(collection, "id", "CollectionId"));
            }
            catch (Exception ex)
            {
                log.LogError(ex, "Get Collection C# HTTP trigger function");
                return responseMessageHelper.UnprocessableEntity();
            }            
        }
    }
}
