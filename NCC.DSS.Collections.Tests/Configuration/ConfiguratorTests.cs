﻿using NCS.DSS.Collections.ServiceBus.Configs;
using NCS.DSS.Collections.ServiceBus.ContentEnhancer;
using NCS.DSS.Collections.ServiceBus.DataCollections.Config;
using NCS.DSS.Collections.Storage.Configuration;
using NUnit.Framework;
using System;

namespace NCC.DSS.Collections.Tests.Configuration
{
    [TestFixture]
    public class ConfiguratorTests
    {
        private string _connString;
        private IContentEnhancerMessageBusConfig _ceMessageBusConfig;
        private IDataCollectionsServiceBusConfig _dcMessageBusConfig;
        private IStorageConfiguration _storageConfiguration;
        [SetUp]
        public void Setup()
        {
            _connString = "ServiceBusConnectionString";
            _ceMessageBusConfig = new ContentEnhancerMessageBusConfig();
            _dcMessageBusConfig = new DataCollectionsServiceBusConfig();
            _storageConfiguration = new StorageConfiguration();
        }

        [Test]
        public void Content_Enhancer_ServiceBus_Configuration_Passing()
        {
            //Assign        
            var queueName = "CEQueueName";
            Environment.SetEnvironmentVariable(queueName, queueName, EnvironmentVariableTarget.Process);
            Environment.SetEnvironmentVariable(_connString, _connString, EnvironmentVariableTarget.Process);

            //Assert
            Assert.That(queueName == _ceMessageBusConfig.QueueName);
            Assert.That(_connString == _ceMessageBusConfig.ServiceBusConnectionString);
        }

        [Test]
        public void Content_Enhancer_ServiceBus_Configuration_Failing()
        {
            //Assign
            var queueName = "CEQueueName";
            Environment.SetEnvironmentVariable(queueName, queueName, EnvironmentVariableTarget.Process);
            Environment.SetEnvironmentVariable(_connString, _connString, EnvironmentVariableTarget.Process);

            //Assert
            Assert.That($"{queueName} " == _ceMessageBusConfig.QueueName, Is.False);
            Assert.That($"{_connString} " == _ceMessageBusConfig.ServiceBusConnectionString, Is.False);
        }

        [Test]
        public void Data_Collections_Out_ServiceBus_Configuration_Passing()
        {
            //Assign
            var queueName = "DCQueueName_Out";

            Environment.SetEnvironmentVariable(queueName, queueName, EnvironmentVariableTarget.Process);
            Environment.SetEnvironmentVariable(_connString, _connString, EnvironmentVariableTarget.Process);

            //Assert
            Assert.That(queueName == _dcMessageBusConfig.QueueName);
            Assert.That(_connString == _dcMessageBusConfig.ServiceBusConnectionString);
        }

        [Test]
        public void Data_Collections_ServiceBus_Configuration_Failing()
        {
            //Assign
            var queueName = "DCQueueName_Out";
            Environment.SetEnvironmentVariable(queueName, queueName, EnvironmentVariableTarget.Process);
            Environment.SetEnvironmentVariable(_connString, _connString, EnvironmentVariableTarget.Process);

            //Assert
            Assert.That($"{queueName} " == _dcMessageBusConfig.QueueName, Is.False);
            Assert.That($"{_connString} " == _dcMessageBusConfig.ServiceBusConnectionString, Is.False);
        }

        [Test]
        public void Storage_Configuration_Passing()
        {
            //Assign
            var connString = "StorageConnectionString";

            Environment.SetEnvironmentVariable(connString, connString, EnvironmentVariableTarget.Process);

            //Assert
            Assert.That(connString == _storageConfiguration.ConnectionString);
        }

        [Test]
        public void Storage_Configuration_Failing()
        {
            //Assign
            var connString = "StorageConnectionString";

            Environment.SetEnvironmentVariable(connString, connString, EnvironmentVariableTarget.Process);

            //Assert
            Assert.That($"{connString} " == _storageConfiguration.ConnectionString, Is.False);
        }
    }
}
