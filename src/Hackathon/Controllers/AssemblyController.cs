using System.Reflection;
using Microsoft.AspNetCore.Mvc;

namespace Hackathon.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AssemblyController :ControllerBase
    {
        [HttpGet("version")]
        public ActionResult<string> GetVersion()
        {
            return "";
        }
    }
}