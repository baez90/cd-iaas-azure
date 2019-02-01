using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace Hackathon
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var urls = Environment.GetEnvironmentVariable("APPLICATION_URLS")?.Split(";") ?? new []{"http://localhost:5000"};
            CreateWebHostBuilder(args, urls).Build().Run();
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args, string[] urls) =>
            WebHost.CreateDefaultBuilder(args)
                .UseUrls(urls)
                .UseStartup<Startup>();
    }
}