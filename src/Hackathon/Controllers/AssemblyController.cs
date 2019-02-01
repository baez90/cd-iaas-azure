using System;
using System.Reflection;
using Microsoft.AspNetCore.Mvc;

namespace Hackathon.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AssemblyController : ControllerBase
    {
        [HttpGet("version")]
        public ActionResult<Version> GetVersion()
        {
            var version = typeof(AssemblyController).Assembly
                .GetCustomAttribute<AssemblyInformationalVersionAttribute>()?.InformationalVersion;
            return Ok(version);
        }
    }
}