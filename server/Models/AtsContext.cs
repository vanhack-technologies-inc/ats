using Microsoft.EntityFrameworkCore;

namespace ats.Models
{
    public class AtsContext : DbContext
    {
        public AtsContext(DbContextOptions<AtsContext> options)
            : base(options)
        {
        }

        public DbSet<Candidate> Candidates { get; set; }
        public DbSet<Job> Jobs { get; set; }
    }
}
