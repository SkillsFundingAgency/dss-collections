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
using Assert = NUnit.Framework.Assert;
using NCS.DSS.Collections.Cosmos.Provider;
using NCS.DSS.Collections.Mappers;
using NCS.DSS.Collections.ServiceBus;

namespace NCC.DSS.Collections.Tests.Services.PostCollectionHttpTrigger
{

    [TestFixture]    
    public class PostCollectionHttpTriggerServiceTests
    {
        private const string ValidCustomerId = "7E467BDB-213F-407A-B86A-1954053D3C24";
        private const string ValidInteractionId = "1e1a555c-9633-4e12-ab28-09ed60d51cb3";
        private const string ValidDssCorrelationId = "452d8e8c-2516-4a6b-9fc1-c85e578ac066";
        private const string ValidTouchPointId = "9000000093";
        private const string InValidId = "1111111-2222-3333-4444-555555555555";

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
        private Mock<IApimUrlValidator> _apimValidator;
        private Mock<IDocumentDBProvider> _documentDBProvider;
        private Mock<ICollectionMapper> _collectionMapper;
        private Mock<ICollectionValidator> _validator;
        private Mock<IDataCollectionsServiceBusClient> _serviceBusClient;
        private NCS.DSS.Collections.PostCollectionHttpTrigger.Function.PostCollectionHttpTrigger function;

        [SetUp]
        public void Setup()
        {
            _collection = new Collection();
            //_collection.Ukprn = "10005262";
            //_collection.CollectionReports = new Uri("http://url/path/");
            _request = null;
            _loggerHelper = new Mock<ILoggerHelper>();
            _httpRequestHelper = new Mock<IHttpRequestHelper>();
            _httpResponseMessageHelper = new HttpResponseMessageHelper();
            _jsonHelper = new JsonHelper();
            _log = new Mock<ILogger>();
            _collectionMapper = new Mock<ICollectionMapper>();
            _documentDBProvider = new Mock<IDocumentDBProvider>();
            _validator = new Mock<ICollectionValidator>();
            _serviceBusClient = new Mock<IDataCollectionsServiceBusClient>();

            _dssCorrelationValidator = new Mock<IDssCorrelationValidator>();
            _dssTouchpointValidator = new Mock<IDssTouchpointValidator>();
            _apimValidator = new Mock<IApimUrlValidator>();
            
            _httpRequestHelper.Setup(x => x.GetDssCorrelationId(_request)).Returns(ValidDssCorrelationId);
            _httpRequestHelper.Setup(x => x.GetDssTouchpointId(_request)).Returns("0000000001");
            _httpRequestHelper.Setup(x => x.GetDssApimUrl(_request)).Returns("http://localhost:7071");

            _postCollectionHttpTriggerService = new Mock<IPostCollectionHttpTriggerService>();
            function = new NCS.DSS.Collections.PostCollectionHttpTrigger.Function.PostCollectionHttpTrigger(_postCollectionHttpTriggerService.Object, _httpResponseMessageHelper, _loggerHelper.Object, _dssCorrelationValidator.Object, _dssTouchpointValidator.Object, _jsonHelper, _apimValidator.Object, _httpRequestHelper.Object);
        }

        [Test]
        public async Task PostCollectionHttpTrigger_ReturnsStatusCodeBadRequest_WhenTouchpointIdIsNotProvided()
        {
            //Assign
            _httpRequestHelper.Setup(x => x.GetResourceFromRequest<Collection>(_request)).Returns(Task.FromResult(Task.FromResult(_collection).Result));
            _httpRequestHelper.Setup(x => x.GetDssTouchpointId(_request)).Returns((string)null);

            //_httpResponseMessageHelper.Setup(x => x.BadRequest()).Returns(new HttpResponseMessage(HttpStatusCode.BadRequest));

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

            //_httpResponseMessageHelper.Setup(x => x.BadRequest()).Returns(new HttpResponseMessage(HttpStatusCode.BadRequest));

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
            _httpRequestHelper.Setup(x => x.GetDssApimUrl(_request)).Returns("http://localhost:7071");
            _httpRequestHelper.Setup(x => x.GetResourceFromRequest<Collection>(_request)).Throws(new JsonException());

            //_httpResponseMessageHelper.Setup(x => x
            //    .UnprocessableEntity(It.IsAny<JsonException>())).Returns(new HttpResponseMessage((HttpStatusCode)422));

            _postCollectionHttpTriggerService.Setup(x => x.ProcessRequestAsync(It.IsAny<Collection>(), "0000000001")).Returns(Task.FromResult<Collection>(null));

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
            _httpRequestHelper.Setup(x => x.GetDssApimUrl(_request)).Returns("http://localhost:7071");
            _httpRequestHelper.Setup(x => x.GetResourceFromRequest<Collection>(_request)).Returns(Task.FromResult(Task.FromResult((_collection)).Result));

            //_postCollectionHttpTriggerService.ProcessRequestAsync(It.IsAny<Collection>(), It.IsAny<string>()).Returns/(Task.FromResult(_collection).Result);
            _postCollectionHttpTriggerService.Setup(x => x.ProcessRequestAsync(It.IsAny<Collection>(), "0000000001")).Returns(Task.FromResult<Collection>(_collection));

            // _httpResponseMessageHelper.Setup(x => x
            //     .Created(It.IsAny<string>())).Returns(new HttpResponseMessage(HttpStatusCode.Created));

            //Act
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
