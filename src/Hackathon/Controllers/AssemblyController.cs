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
    }
}