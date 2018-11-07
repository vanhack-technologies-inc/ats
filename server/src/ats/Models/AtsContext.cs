using Microsoft.EntityFrameworkCore;

namespace ats.Models
{
    public class AtsContext : DbContext
    {
        public AtsContext(DbContextOptions<AtsContext> options)
            : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Application>()
                .HasKey(c => new { c.jobId, c.username });
        }

        public DbSet<Candidate> Candidates { get; set; }
        public DbSet<Job> Jobs { get; set; }
        public DbSet<Application> Applications { get; set; }
    }
}
