using DFC.HTTP.Standard;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Moq;
using NCS.DSS.Collections.Cosmos.Helper;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.PostCollectionHttpTrigger.Service;
using NUnit.Framework;
using System;
using System.Net;
using System.Text.Json;
using System.Threading.Tasks;
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
        private Mock<IDynamicHelper> _dynamicHelper;
        private Collection _collection;
        private PostCollectionHttpLogger.PostCollectionHttpTrigger function;

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
            _dynamicHelper = new Mock<IDynamicHelper>();

            _postCollectionHttpTriggerService = new Mock<IPostCollectionHttpTriggerService>();

            function = new PostCollectionHttpLogger.PostCollectionHttpTrigger(_postCollectionHttpTriggerService.Object, _loggerHelper.Object, _httpRequestHelper.Object, _dynamicHelper.Object);
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
            Assert.That(result, Is.InstanceOf<BadRequestResult>());

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
            Assert.That(result, Is.InstanceOf<JsonResult>());
            Assert.That((int)HttpStatusCode.Created == (int)((JsonResult)result).StatusCode);
        }

        private async Task<IActionResult> RunFunction()
        {
            return await function.RunAsync(
                _request
                ).ConfigureAwait(false);
        }
    }
}
