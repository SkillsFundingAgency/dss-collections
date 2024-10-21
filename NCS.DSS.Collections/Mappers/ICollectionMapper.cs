namespace NCS.DSS.Collections.Mappers
{
    public interface ICollectionMapper
    {
        Models.Collection Map(Models.PersistedCollection entity);
        Models.PersistedCollection Map(Models.Collection entity);
        List<Models.Collection> Map(List<Models.PersistedCollection> entities);
        List<Models.PersistedCollection> Map(List<Models.Collection> entities);
    }
}
