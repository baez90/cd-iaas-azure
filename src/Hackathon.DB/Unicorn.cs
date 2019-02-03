using System;

namespace Hackathon.DB
{
    public class Unicorn
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public DateTime? CreationTime { get; set; } = DateTime.UtcNow;
    }
}