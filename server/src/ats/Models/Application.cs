
using System.ComponentModel.DataAnnotations;

namespace ats.Models
{
    public class Application
    {
        [Required]
        public long jobId { get; set; }

        [Required]
        public string username { get; set; }

        [Required]
        public string status { get; set; }
        
    }
}
