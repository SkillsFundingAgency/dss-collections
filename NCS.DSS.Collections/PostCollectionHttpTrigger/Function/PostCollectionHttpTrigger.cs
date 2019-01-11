using DFC.Functions.DI.Standard.Attributes;
using DFC.HTTP.Standard;
using DFC.Swagger.Standard.Annotations;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.PostCollectionHttpTrigger.Service;
using System;
using System.ComponentModel.DataAnnotations;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.PostCollectionHttpTrigger.Function
{
    public static class PostCollectionHttpTrigger
    {
        [FunctionName("Post")]
        [Response(HttpStatusCode = (int)HttpStatusCode.Created, Description = "Collection Created", ShowSchema = true)]
        [Response(HttpStatusCode = (int)HttpStatusCode.NoContent, Description = "Collection does not exist", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.BadRequest, Description = "Request was malformed", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Unauthorized, Description = "API key is unknown or invalid", ShowSchema = false)]
        [Response(HttpStatusCode = (int)HttpStatusCode.Forbidden, Description = "Insufficient access", ShowSchema = false)]
        [Response(HttpStatusCode = 422, Description = "Collection validation error(s)", ShowSchema = false)]
        [Display(Name = "Post", Description = "Ability to create a new collection for a touchpoint.")]
        public static async Task<IActionResult> RunAsync(
            [HttpTrigger(AuthorizationLevel.Anonymous, "post", Route = "Collections")] HttpRequestMessage req,
            ILogger log,
            [Inject]IPostCollectionHttpTriggerService service)
        {
            log.LogInformation("Post Collection C# HTTP trigger function processing a request.");            

            try
            {
                return await service.ProcessRequest(req);
            }
            catch (Exception ex)
            {
                return new BadRequestObjectResult("Please pass a Collection in the request body " + ex.Message);
            }            
        }
    }
}
