
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


namespace ats.Models
{
    public class Application
    {
        [Key]
        public long id { get; set; }

        [ForeignKey("application_jobid")]
        [Column(Order = 1)]
        public long jobId { get; set; }

        [ForeignKey("application_username")]
        [Column(Order = 2)]
        public string username { get; set; }

        [Required]
        public string status { get; set; }
        
    }
}
