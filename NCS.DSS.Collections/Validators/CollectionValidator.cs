using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using NCS.DSS.Collections.Models;

namespace NCS.DSS.Collections.Validators
{
    public class CollectionValidator : ICollectionValidator
    {
        public async Task<List<ValidationError>> Validate(Collection entity)
        {
            List<ValidationError> result = new List<ValidationError>();

            if (entity.CollectionId == Guid.Empty)
            {
                entity.CollectionId = Guid.NewGuid();
            }

            if (string.IsNullOrEmpty(entity.TouchPointId))
            {
                result.Add(new ValidationError("Null TouchPointId"));
            }

            if (string.IsNullOrWhiteSpace(entity.Ukprn))
            {
                result.Add(new ValidationError("Null UKPRN"));
            }

            if (entity.Ukprn.Length != 8)
            {
                result.Add(new ValidationError("Invalid Length UKPRN"));
            }

            if (entity.LastModifiedDate == null)
            {
                result.Add(new ValidationError("Null Last Modified Date"));
            }

            return await Task.FromResult(result);
        }
    }
}
