using NCS.DSS.Collections.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace NCS.DSS.Collections.Validators
{
    public class CollectionValidator : ICollectionValidator
    {
        public List<ValidationResult> Validate(Collection entity)
        {
            List<ValidationResult> result = new List<ValidationResult>();

            if (entity.CollectionId == Guid.Empty)
            {
                entity.CollectionId = Guid.NewGuid();
            }

            if (string.IsNullOrEmpty(entity.TouchPointId))
            {
                result.Add(new ValidationResult("Null TouchPointId", new[] { "TouchPointId" }));
            }

            if (string.IsNullOrWhiteSpace(entity.Ukprn))
            {
                result.Add(new ValidationResult("Null UKPRN", new[] { "Ukprn" }));
            }

            if (!string.IsNullOrWhiteSpace(entity.Ukprn) && entity.Ukprn.Length != 8)
            {
                result.Add(new ValidationResult("Invalid Length UKPRN", new[] { "Ukprn" }));
            }

            if (entity.LastModifiedDate == null)
            {
                result.Add(new ValidationResult("Null Last Modified Date", new[] { "LastModifiedDate" }));
            }

            return result;
        }
    }
}
