namespace NCS.DSS.Collections.GetCollectionByIdHttpTrigger.Service
{
    public interface IGetCollectionByIdHttpTriggerService
    {
        Task<MemoryStream> ProcessRequestAsync(string touchPointId, Guid collectionId);
    }
}
