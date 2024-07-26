using DFC.Common.Standard.Logging;
using DFC.HTTP.Standard;
using DFC.JSON.Standard;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.PostCollectionHttpTrigger.Service;
using NCS.DSS.Collections.Validators;
using Newtonsoft.Json;
using Moq;
using NUnit.Framework;
using System;
using System.Net;
using System.Threading.Tasks;
using NCS.DSS.Collections.Helpers;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PostCollectionHttpLogger = NCS.DSS.Collections.PostCollectionHttpTrigger.Function;

namespace NCC.DSS.Collections.Tests.Services.PostCollectionHttpTrigger
{

    [TestFixture]    
    public class PostCollectionHttpTriggerServiceTests
    {
        private const string ValidDssCorrelationId = "452d8e8c-2516-4a6b-9fc1-c85e578ac066";
        private HttpRequest _request;      
        private Mock<IPostCollectionHttpTriggerService> _postCollectionHttpTriggerService;
        private Mock<ILogger<PostCollectionHttpLogger.PostCollectionHttpTrigger>> _loggerHelper;
        private Mock<IHttpRequestHelper> _httpRequestHelper;
        private IHttpResponseMessageHelper _httpResponseMessageHelper;
        private IJsonHelper _jsonHelper;
        private Collection _collection;
        private Mock<IDssCorrelationValidator> _dssCorrelationValidator;
        private Mock<IDssTouchpointValidator> _dssTouchpointValidator;
        private Mock<IApimUrlValidator> _apimValidator;
        private PostCollectionHttpLogger.PostCollectionHttpTrigger function;
        private Mock<IDataCollectionsReportHelper> _dataCollectionsReportHelper;

        [SetUp]
        public void Setup()
        {
            _collection = new Collection();
            _collection.Ukprn = "10005262";
            _collection.CollectionReports = new Uri("http://url/path/");
            _collection.TouchPointId = "0000000001";
            _request = (new DefaultHttpContext()).Request;

            _loggerHelper = new Mock<ILogger<PostCollectionHttpLogger.PostCollectionHttpTrigger>>();
            _httpRequestHelper = new Mock<IHttpRequestHelper>();
            _jsonHelper = new JsonHelper();

            _dssCorrelationValidator = new Mock<IDssCorrelationValidator>();
            _dssTouchpointValidator = new Mock<IDssTouchpointValidator>();
            _apimValidator = new Mock<IApimUrlValidator>();

            _postCollectionHttpTriggerService = new Mock<IPostCollectionHttpTriggerService>();

            function = new PostCollectionHttpLogger.PostCollectionHttpTrigger(_postCollectionHttpTriggerService.Object, _loggerHelper.Object, _dssCorrelationValidator.Object, _dssTouchpointValidator.Object, _jsonHelper, _apimValidator.Object, _httpRequestHelper.Object);
        }

        [Test]
        public async Task PostCollectionHttpTrigger_ReturnsStatusCodeBadRequest_WhenTouchpointIdIsNotProvided()
        {
            //Assign
            _httpRequestHelper.Setup(x => x.GetResourceFromRequest<Collection>(_request)).Returns(Task.FromResult(Task.FromResult(_collection).Result));
            _httpRequestHelper.Setup(x => x.GetDssTouchpointId(_request)).Returns((string)null);

            // Act
            var result = await RunFunction();

            // Assert
            Assert.That(result,Is.InstanceOf<BadRequestResult>());
            
        }       

        [Test]
        public async Task PostCollectionHttpTrigger_ReturnsStatusCodeBadRequest_WhenApimUrlIsNotProvided()
        {
            //Assign
            _httpRequestHelper.Setup(x => x.GetDssApimUrl(_request)).Returns((string)null);

            // Act
            var result = await RunFunction();

            // Assert
            Assert.That(result, Is.InstanceOf<BadRequestResult>());
        }

        [Test]
        public async Task PostCollectionHttpTrigger_ReturnsStatusCodeUnprocessableEntity_WhenACollectionRequestIsInvalid()
        {
            //Assign
            _httpRequestHelper.Setup(x => x.GetDssCorrelationId(_request)).Returns(ValidDssCorrelationId);
            _httpRequestHelper.Setup(x => x.GetDssTouchpointId(_request)).Returns("0000000001");
            _httpRequestHelper.Setup(x => x.GetDssApimUrl(_request)).Returns("http://localhost:7071");
            _httpRequestHelper.Setup(x => x.GetResourceFromRequest<Collection>(_request)).Throws(new JsonException());

            //Act
            var result = await RunFunction();

            // Assert
            Assert.That(result, Is.InstanceOf<UnprocessableEntityObjectResult>());
        }

        [Test]
        public async Task PostCollectionHttpTrigger_ReturnsStatusCodeCreated_WhenRequestIsValid()
        {
            //Assign
            _httpRequestHelper.Setup(x => x.GetDssCorrelationId(_request)).Returns(ValidDssCorrelationId);
            _httpRequestHelper.Setup(x => x.GetDssTouchpointId(_request)).Returns("0000000001");
            _httpRequestHelper.Setup(x => x.GetDssApimUrl(_request)).Returns("http://localhost:7071");

            _httpRequestHelper.Setup(x => x.GetResourceFromRequest<Collection>(_request)).Returns(Task.FromResult(_collection));

            _postCollectionHttpTriggerService.Setup(x => x.ProcessRequestAsync(_collection, It.IsAny<string>())).Returns(Task.FromResult<Collection>(_collection));

            var result = await RunFunction();

            // Assert
            Assert.That(result, Is.InstanceOf<ObjectResult>());
            Assert.That((int)HttpStatusCode.Created == (int) ((ObjectResult) result).StatusCode);
        }

        private async Task<IActionResult> RunFunction()
        {
            return await function.Run(
                _request
                ).ConfigureAwait(false);
        }
    }
}
