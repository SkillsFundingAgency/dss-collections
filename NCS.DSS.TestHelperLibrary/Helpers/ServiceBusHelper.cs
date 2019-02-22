using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Azure.ServiceBus;

namespace NCS.DSS.Collections.SysIntTests.Helpers
{
	public class ServiceBusHelper
	{
        static IQueueClient queueClient;
        public static string ServiceBusConnectionString { get; set; }
        public static string QueueName { get; set; }

        static bool Intialise()
        {
            bool _success = true;
            queueClient = new QueueClient(ServiceBusConnectionString, QueueName);
            return _success;
        }

        static void Dispose()
        {
            queueClient.CloseAsync().GetAwaiter().GetResult();
        }

        static bool SendMessages(string messageText)
        {
            bool _success = true;
            try
            {
                // Create a new message to send to the queue.
                var message = new Message(Encoding.UTF8.GetBytes(messageText));

                // Write the body of the message to the console.
                Console.WriteLine($"Sending message: {messageText}");

                // Send the message to the queue.
                queueClient.SendAsync(message).GetAwaiter().GetResult();
            }
            catch (Exception exception)
            {
                _success = false;
                Console.WriteLine($"{DateTime.Now} :: Exception: {exception.Message}");
            }
            return _success;
        }


        static async Task SendMessagesAsync(string messageText)
        {
            try
            {
                // Create a new message to send to the queue.
                var message = new Message(Encoding.UTF8.GetBytes(messageText));

                // Write the body of the message to the console.
                Console.WriteLine($"Sending message: {messageText}");

                // Send the message to the queue.
                await queueClient.SendAsync(message);
            }
            catch (Exception exception)
            {
                Console.WriteLine($"{DateTime.Now} :: Exception: {exception.Message}");
            }
        }
    }
}
    