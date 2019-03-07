using Newtonsoft.Json.Converters;

namespace NCS.DSS.Collections.Mappers
{
    public class CustomerDateTimeConverter : IsoDateTimeConverter
    {
        public CustomerDateTimeConverter(string format)
        {
            DateTimeFormat = format;
        }
    }
}
