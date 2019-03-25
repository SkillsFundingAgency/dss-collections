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
        public static Boolean CheckJsonPropertyIsPresent(string json, string property)
        {
            var obj = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(json.ToLower());
            var check = obj[property.ToLower()];
            return (check != null);//.GetValue(property.ToLower()).ToString().Length > 0;
        }

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

        public static Dictionary<string,string> ReplaceFutureDates(ref string json, DateTime replacement, Dictionary<string,int> offsets)
        {
            Dictionary<string, string> returnDict = new Dictionary<string, string>();
            var obj = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(json);
            int offset;
            foreach( var property in obj )
            {
                if (property.Key.ToLower().Contains("date"))
                {
                    DateTime dateCheck;
                    if (DateTime.TryParse(property.Value.ToString(), out dateCheck)
                            && dateCheck > DateTime.Today/*.AddDays(-365) */)
                    {
                        try
                        {
                            offset = offsets[property.Key];
                        }
                        catch
                        {
                            offset = 0;
                        }
                        obj[property.Key] = DateTime.Today.AddDays(offset).ToString("yyyy-MM-ddTHH:mm:ssZ");
                        returnDict.Add(property.Key, dateCheck.ToString("yyyy-MM-ddTHH:mm:ssZ"));
                    }
                }
            }
            if (returnDict.Count() > 0)
            {
                json = obj.ToString();
            }
            return returnDict;
        }

		public static string AddPropertyToJsonString(string json, string property, string value)
		{
            if (CheckJsonPropertyIsPresent(json, property) )
            {
                return SetPropertyInJsonString(json, property, value);
            }
			var obj = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(json);
			obj.Add(property, value);
			return obj.ToString();
		}

        public static string SetPropertyInJsonString(string json, string property, string value)
        {
            var obj = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(json);
            obj[property] = value;
            return obj.ToString();
        }

        public static string GetPropertyFromJsonString(string json, string property)
        {
            var obj = (Newtonsoft.Json.Linq.JObject)JsonConvert.DeserializeObject(json);
            return obj.Property(property).Value.ToString();
        }
    }
}
