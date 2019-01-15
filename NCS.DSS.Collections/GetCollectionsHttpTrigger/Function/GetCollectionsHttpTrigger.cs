using DFC.Functions.DI.Standard.Attributes;
using DFC.HTTP.Standard;
using DFC.JSON.Standard;
using DFC.Swagger.Standard.Annotations;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.GetCollectionsHttpTrigger.Service;
using NCS.DSS.Collections.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.GetCollectionsHttpTrigger.Function
{
    public static class GetCollectionsHttpTrigger
    {
        [FunctionName("Get")]
        [ProducesResponseType(typeof(Collection), (int)HttpStatusCode.OK)]
        [Response(HttpStatusCode = (int)HttpStatusCode.OK, Description = "Collections found", ShowSchema = true)]
        [Response(HttpStatusCode = (int)HttpStatusCode.NoContent, Description = "Collections do not exist", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.BadRequest, Description = "Request was malformed", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Unauthorized, Description = "API key is unknown or invalid", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Forbidden, Description = "Insufficient access", ShowSchema = false)]
        [Display(Name = "Get", Description = "Ability to return all collections for the touchpoint.")]
        public static async Task<HttpResponseMessage> RunAsync(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "collections")] HttpRequest req,
            ILogger log,
            [Inject]IGetCollectionsHttpTriggerService service,
            [Inject]IJsonHelper jsonHelper,
            [Inject]IHttpRequestHelper requestHelper,
            [Inject]IHttpResponseMessageHelper responseMessageHelper)
        {
            log.LogInformation("Get Collections C# HTTP trigger function processing a request. TouchpointId " + requestHelper.GetDssTouchpointId(req));            

            try
            {
                var results = await service.ProcessRequestAsync();

                if (results.Count == 0)
                {
                    return responseMessageHelper.NoContent();
                }

                return responseMessageHelper.Ok(jsonHelper.SerializeObjectsAndRenameIdProperty<Collection>(results, "id", "CollectionId"));
            }
            catch (Exception ex)
            {
                log.LogError(ex, "Get Collections C# HTTP trigger function");
                return responseMessageHelper.UnprocessableEntity();
            }            
        }
    }
}
