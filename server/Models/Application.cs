
using System.ComponentModel.DataAnnotations;

namespace ats.Models
{
    public class Application
    {
        [Key]
        public long jobId { get; set; }

        [Key]
        public string username { get; set; }

        [Required]
        public string status { get; set; }
        
    }
}
