using NCS.DSS.Collections.Models;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace NCS.DSS.Collections.Validators
{
    public interface ICollectionValidator
    {
        List<ValidationResult> Validate(Collection entity);
    }
}
