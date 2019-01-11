using DFC.Functions.DI.Standard.Attributes;
using DFC.Swagger.Standard;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using System.Dynamic;
using System.Net.Http;
using System.Reflection;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.APIDefinition
{
    public static class ApiDefinition
    {
        public const string APITitle = "Collections";
        public const string APIDefinitionName = "API-Definition";
        public const string APIDefRoute = APITitle + "/" + APIDefinitionName;
        public const string APIDescription = "Basic details of a National Careers Service " + APITitle + " Resource";

        [FunctionName(APIDefinitionName)]
        public static async Task<IActionResult> RunAsync(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = APIDefRoute)] HttpRequest req,
            ILogger log,
            [Inject]ISwaggerDocumentGenerator swaggerGenerator)
        {            
            return await Task.FromResult((ActionResult)new OkObjectResult(swaggerGenerator.GenerateSwaggerDocument(req, APITitle, APIDescription, APIDefinitionName, Assembly.GetExecutingAssembly())));            
        }        
    }
}
