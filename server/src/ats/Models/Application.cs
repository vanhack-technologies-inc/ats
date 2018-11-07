
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


namespace ats.Models
{
    public class Application
    {
        [Key, Column(Order = 1)]
        public long jobId { get; set; }

        [Key, Column(Order = 2)]
        public string username { get; set; }

        [Required]
        public string status { get; set; }
        
    }
}
