using DFC.Swagger.Standard;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using System.Reflection;

namespace NCS.DSS.Collections.APIDefinition
{
    public class ApiDefinition
    {
        public const string APITitle = "Collections";
        public const string APIDefinitionName = "API-Definition";
        public const string APIDefRoute = APITitle + "/" + APIDefinitionName;
        public const string APIDescription = "To trigger Data Collections submissions and retrieve corresponding funding calculations and occupancy reports";
        public const string ApiVersion = "3.0.0";

        private ISwaggerDocumentGenerator swaggerDocumentGenerator;
        public ApiDefinition(ISwaggerDocumentGenerator swaggerDocumentGenerator)
        {
            this.swaggerDocumentGenerator = swaggerDocumentGenerator;
        }

        [Function(APIDefinitionName)]
        public IActionResult RunAsync([HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = APIDefRoute)] HttpRequest req)
        {
            var swagger = swaggerDocumentGenerator.GenerateSwaggerDocument(req, APITitle, APIDescription,
                APIDefinitionName, ApiVersion, Assembly.GetExecutingAssembly());

            if (string.IsNullOrEmpty(swagger))
            {
                return new NoContentResult();
            }

            return new OkObjectResult(swagger);
        }
    }
}
