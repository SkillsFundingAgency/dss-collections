﻿using System.Dynamic;

namespace NCS.DSS.Collections.Cosmos.Helper
{
    public interface IDynamicHelper
    {
        public void AddProperty(ExpandoObject expando, string propertyName, object propertyValue);
        public ExpandoObject ExcludeProperty(Exception exception, string[] names);
    }
}
