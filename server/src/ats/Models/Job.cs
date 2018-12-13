
using System.ComponentModel.DataAnnotations;

namespace ats.Models
{
    public class Job
    {
        [Key]
        public long id { get; set; }
        [Required]
        public string name { get; set; }
        public string description { get; set; }
        public string company { get; set; }
        public string recruiter { get; set; }
        [Required]
        public bool open { get; set; }
    }
}
