namespace NCS.DSS.Collections.Helpers
{
    public interface IDataCollectionsReportHelper
    {
        string FileName(Models.Collection collection);
        string ContainerName { get; }
    }
}
