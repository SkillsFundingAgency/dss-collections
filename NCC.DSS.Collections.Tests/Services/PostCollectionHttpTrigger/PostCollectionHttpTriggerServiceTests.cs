using DFC.Common.Standard.Logging;
using DFC.HTTP.Standard;
using DFC.JSON.Standard;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.Internal;
using Microsoft.Extensions.Logging;
using NCS.DSS.Collections.Cosmos.Helper;
using NCS.DSS.Collections.Models;
using NCS.DSS.Collections.PostCollectionHttpTrigger.Service;
using NCS.DSS.Collections.Validators;
using Newtonsoft.Json;
using Moq;
using NUnit.Framework;
using System;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.Mappers;
using NCS.DSS.Collections.ServiceBus;
using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;
using Microsoft.Azure.Documents;
using Microsoft.Azure.Documents.Client;
using NCS.DSS.Collections.Helpers;

namespace NCC.DSS.Collections.Tests.Services.PostCollectionHttpTrigger
{

    [TestFixture]    
    public class PostCollectionHttpTriggerServiceTests
    {
        private const string ValidDssCorrelationId = "452d8e8c-2516-4a6b-9fc1-c85e578ac066";
        private Mock<ILogger> _log;
        private DefaultHttpRequest _request;      
        private Mock<IPostCollectionHttpTriggerService> _postCollectionHttpTriggerService;
        private Mock<ILoggerHelper> _loggerHelper;
        private Mock<IHttpRequestHelper> _httpRequestHelper;
        private IHttpResponseMessageHelper _httpResponseMessageHelper;
        private IJsonHelper _jsonHelper;
        private Collection _collection;
        private Mock<IDssCorrelationValidator> _dssCorrelationValidator;
        private Mock<IDssTouchpointValidator> _dssTouchpointValidator;
        private Mock<IDssSubcontractorValidator> _dssSubcontractorValidator;
        private Mock<IApimUrlValidator> _apimValidator;
        private NCS.DSS.Collections.PostCollectionHttpTrigger.Function.PostCollectionHttpTrigger function;
        private Mock<IDataCollectionsReportHelper> _dataCollectionsReportHelper;

        [SetUp]
        public void Setup()
        {
            _collection = new Collection();
            _collection.Ukprn = "10005262";
            _collection.CollectionReports = new Uri("http://url/path/");
            _collection.TouchPointId = "0000000001";
            _collection.SubcontractorId = "9999999999";
            _request = null;

            _loggerHelper = new Mock<ILoggerHelper>();
            _httpRequestHelper = new Mock<IHttpRequestHelper>();
            _httpResponseMessageHelper = new HttpResponseMessageHelper();
            _jsonHelper = new JsonHelper();
            _log = new Mock<ILogger>();

            _dssCorrelationValidator = new Mock<IDssCorrelationValidator>();
            _dssTouchpointValidator = new Mock<IDssTouchpointValidator>();
            _apimValidator = new Mock<IApimUrlValidator>();

            _postCollectionHttpTriggerService = new Mock<IPostCollectionHttpTriggerService>();

            function = new NCS.DSS.Collections.PostCollectionHttpTrigger.Function.PostCollectionHttpTrigger(_postCollectionHttpTriggerService.Object, _httpResponseMessageHelper, _loggerHelper.Object, _dssCorrelationValidator.Object, _dssTouchpointValidator.Object, _jsonHelper, _apimValidator.Object, _httpRequestHelper.Object);
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
            Assert.IsInstanceOf<HttpResponseMessage>(result);
            Assert.AreEqual(HttpStatusCode.BadRequest, result.StatusCode);
        }

        [Test]
        public async Task PostCollectionHttpTrigger_ReturnsStatusCodeBadRequest_WhenSubcontractorIdIsNotProvided()
        {
            //Assign
            _httpRequestHelper.Setup(x => x.GetResourceFromRequest<Collection>(_request)).Returns(Task.FromResult(Task.FromResult(_collection).Result));
            _httpRequestHelper.Setup(x => x.GetDssSubcontractorId(_request)).Returns((string)null);

            // Act
            var result = await RunFunction();

            // Assert
            Assert.IsInstanceOf<HttpResponseMessage>(result);
            Assert.AreEqual(HttpStatusCode.BadRequest, result.StatusCode);
        }

        [Test]
        public async Task PostCollectionHttpTrigger_ReturnsStatusCodeBadRequest_WhenApimUrlIsNotProvided()
        {
            //Assign
            _httpRequestHelper.Setup(x => x.GetDssApimUrl(_request)).Returns((string)null);

            // Act
            var result = await RunFunction();

            // Assert
            Assert.IsInstanceOf<HttpResponseMessage>(result);
            Assert.AreEqual(HttpStatusCode.BadRequest, result.StatusCode);
        }

        [Test]
        public async Task PostCollectionHttpTrigger_ReturnsStatusCodeUnprocessableEntity_WhenACollectionRequestIsInvalid()
        {
            //Assign
            _httpRequestHelper.Setup(x => x.GetDssCorrelationId(_request)).Returns(ValidDssCorrelationId);
            _httpRequestHelper.Setup(x => x.GetDssTouchpointId(_request)).Returns("0000000001");
            _httpRequestHelper.Setup(x => x.GetDssTouchpointId(_request)).Returns("9999999999");
            _httpRequestHelper.Setup(x => x.GetDssApimUrl(_request)).Returns("http://localhost:7071");
            _httpRequestHelper.Setup(x => x.GetResourceFromRequest<Collection>(_request)).Throws(new JsonException());

            //Act
            var result = await RunFunction();

            // Assert
            Assert.IsInstanceOf<HttpResponseMessage>(result);
            Assert.AreEqual((HttpStatusCode)422, result.StatusCode);
        }

        [Test]
        public async Task PostCollectionHttpTrigger_ReturnsStatusCodeCreated_WhenRequestIsValid()
        {
            //Assign
            _httpRequestHelper.Setup(x => x.GetDssCorrelationId(_request)).Returns(ValidDssCorrelationId);
            _httpRequestHelper.Setup(x => x.GetDssTouchpointId(_request)).Returns("0000000001");
            _httpRequestHelper.Setup(x => x.GetDssTouchpointId(_request)).Returns("9999999999");
            _httpRequestHelper.Setup(x => x.GetDssApimUrl(_request)).Returns("http://localhost:7071");

            _httpRequestHelper.Setup(x => x.GetResourceFromRequest<Collection>(_request)).Returns(Task.FromResult(_collection));

            _postCollectionHttpTriggerService.Setup(x => x.ProcessRequestAsync(_collection, It.IsAny<string>())).Returns(Task.FromResult<Collection>(_collection));

            var result = await RunFunction();

            // Assert
            Assert.IsInstanceOf<HttpResponseMessage>(result);
            Assert.AreEqual(HttpStatusCode.Created, result.StatusCode);
        }

        private async Task<HttpResponseMessage> RunFunction()
        {
            return await function.Run(
                _request,
                _log.Object
                ).ConfigureAwait(false);
        }
    }
}
