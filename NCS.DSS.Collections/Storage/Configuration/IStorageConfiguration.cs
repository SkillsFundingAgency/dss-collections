namespace NCS.DSS.Collections.Storage.Configuration
{
    public interface IStorageConfiguration
    {
        string ConnectionString { get; }
        string ShareReference { get; }
    }
}
