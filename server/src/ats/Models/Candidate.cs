using System.ComponentModel.DataAnnotations;

namespace ats.Models
{
    public class Candidate
    {
        [Key]
        public string username { get; set; }
        [Required]
        public string email { get; set; }
        public string name { get; set; }
        public bool verified { get; set; }
    }
}
