using Hackathon.DTO;
using Microsoft.AspNetCore.Mvc;

namespace Hackathon.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AssemblyController : ControllerBase
    {
        [HttpGet("version")]
        public ActionResult<AppVersionDto> GetVersion()
        {
            return Ok(new AppVersionDto());
        }

        [HttpGet("name")]
        public ActionResult<string> GetAssemblyName()
        {
            return Ok(new {typeof(AssemblyController).Assembly.GetName().Name});
        }
    }
}