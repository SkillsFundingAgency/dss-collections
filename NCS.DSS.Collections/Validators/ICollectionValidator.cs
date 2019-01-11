using NCS.DSS.Collections.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace NCS.DSS.Collections.Validators
{
    public interface ICollectionValidator
    {
        Task<List<ValidationError>> Validate(Collection entity);
    }
}
