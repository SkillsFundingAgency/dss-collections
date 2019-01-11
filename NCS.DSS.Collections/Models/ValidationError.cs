namespace NCS.DSS.Collections.Models
{
    public class ValidationError
    {
        public ValidationError(string errorMessage)
        {
            ErrorMessage = errorMessage;
        }
        string ErrorMessage { get; set; }
    }
}
