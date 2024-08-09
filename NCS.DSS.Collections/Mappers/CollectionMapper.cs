using NCS.DSS.Collections.Helpers;
using NCS.DSS.Collections.Models;
using System.Collections.Generic;

namespace NCS.DSS.Collections.Mappers
{
    public class CollectionMapper : ICollectionMapper
    {
        private readonly IDataCollectionsReportHelper _dataCollectionsReportHelper;
        public CollectionMapper(IDataCollectionsReportHelper dataCollectionsReportHelper)
        {
            _dataCollectionsReportHelper = dataCollectionsReportHelper;
        }
        public Collection Map(PersistedCollection entity)
        {
            return new Collection
            {
                CollectionId = entity.CollectionId,
                CollectionReports = entity.CollectionReports,
                LastModifiedDate = entity.LastModifiedDate,
                TouchPointId = entity.TouchPointId,
                Ukprn = entity.Ukprn
            };
        }

        public PersistedCollection Map(Collection entity)
        {
            return new PersistedCollection
            {
                CollectionId = entity.CollectionId,
                CollectionReports = entity.CollectionReports,
                ContainerName = _dataCollectionsReportHelper.ContainerName,
                LastModifiedDate = entity.LastModifiedDate,
                ReportFileName = _dataCollectionsReportHelper.FileName(entity),
                TouchPointId = entity.TouchPointId,
                Ukprn = entity.Ukprn
            };
        }

        public List<Collection> Map(List<PersistedCollection> entities)
        {
            List<Collection> result = new List<Collection>();

            foreach (PersistedCollection entity in entities)
            {
                result.Add(Map(entity));
            }

            return result;
        }

        public List<PersistedCollection> Map(List<Collection> entities)
        {
            List<PersistedCollection> result = new List<PersistedCollection>();

            foreach (Collection entity in entities)
            {
                result.Add(Map(entity));
            }

            return result;
        }
    }
}
