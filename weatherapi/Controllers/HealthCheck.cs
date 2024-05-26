using Microsoft.AspNetCore.Mvc;

namespace weatherapi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HealthController : ControllerBase
    {
        [HttpGet]
        public IActionResult CheckHealth()
        {
            // Implement your health check logic here
            // For simplicity, always return HTTP 200 OK
            return Ok();
        }
    }
}
