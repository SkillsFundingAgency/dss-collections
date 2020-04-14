using DFC.Functions.DI.Standard.Attributes;
using DFC.Swagger.Standard;
using Microsoft.AspNetCore.Http;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using System.Net;
using System.Net.Http;
using System.Reflection;

namespace NCS.DSS.Collections.APIDefinition
{
    public static class ApiDefinition
    {
        public const string APITitle = "Collections";
        public const string APIDefinitionName = "API-Definition";
        public const string APIDefRoute = APITitle + "/" + APIDefinitionName;
        public const string APIDescription = "To trigger Data Collections submissions and retrieve corresponding funding calculations and occupancy reports";

        [FunctionName(APIDefinitionName)]
        public static HttpResponseMessage Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, new string[] { "get", "post" }, Route = APIDefRoute)] HttpRequest req,
            ILogger log,
            [Inject]ISwaggerDocumentGenerator swaggerDocumentGenerator)
        {          
            try
            {
                return new HttpResponseMessage(HttpStatusCode.OK)
                {
                    Content = new StringContent(swaggerDocumentGenerator.GenerateSwaggerDocument(req, APITitle, APIDescription, APIDefinitionName, Assembly.GetExecutingAssembly()))
                };
            }
            catch
            {
                return new HttpResponseMessage(HttpStatusCode.NoContent);                
            }
        }

    }
}
