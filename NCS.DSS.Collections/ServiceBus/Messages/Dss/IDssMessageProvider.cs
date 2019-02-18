using ESFA.DC.CrossLoad.Dto;

namespace NCS.DSS.Collections.ServiceBus.Messages.Dss
{
    public interface IDssMessageProvider
    {
        MessageCrossLoadDctToDcftDto GenerateDCMessage(Models.Collection collection);
    }
}
