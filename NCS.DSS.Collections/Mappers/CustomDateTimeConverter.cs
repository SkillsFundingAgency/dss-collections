using Newtonsoft.Json.Converters;

namespace NCS.DSS.Collections.Mappers
{
    public class CustomDateTimeConverter : IsoDateTimeConverter
    {
        public CustomDateTimeConverter(string format)
        {
            DateTimeFormat = format;
        }  
    }
}
