using System.Reflection;

namespace Hackathon.DTO
{
    public class AppVersionDto
    {        
        public AppVersionDto()
        {
            AppVersion = typeof(AppVersionDto).Assembly.GetCustomAttribute<AssemblyInformationalVersionAttribute>()?.InformationalVersion;
        }
        
        public string AppVersion { get; }
    }
}