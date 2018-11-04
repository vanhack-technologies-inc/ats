using Microsoft.EntityFrameworkCore;

namespace ats.Models
{
    public class CandidateContext : DbContext
    {
        public CandidateContext(DbContextOptions<CandidateContext> options)
            : base(options)
        {
        }

        public DbSet<CandidateContext> Candidates { get; set; }
    }
}
