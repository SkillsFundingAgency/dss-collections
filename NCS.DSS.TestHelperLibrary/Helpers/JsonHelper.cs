using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace NCS.DSS.TestHelperLibrary.Helpers
{
    public static class JsonHelper
    {
        public static Boolean CheckJsonPropertyHasValue(string json, string property)
        {
            var obj = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(json.ToLower());
            return obj.GetValue(property.ToLower()).ToString().Length > 0;
        }

        public static Boolean CheckJsonPropertyHasNoValueValue(string json, string property)
        {
            return !CheckJsonPropertyHasValue(json, property);
        }

        public static string RemovePropertyFromJsonString(string json, string property)
        {
            var obj = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(json);
            obj.Property(property).Remove();
            return obj.ToString();
        }

		public static string AddPropertyToJsonString(string json, string property, string value)
		{
			var obj = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(json);
			obj.Add(property, value);
			return obj.ToString();
		}

		public static string GetPropertyFromJsonString(string json, string property)
        {
            var obj = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(json);
            return obj.Property(property).Value.ToString();
        }
    }
}
