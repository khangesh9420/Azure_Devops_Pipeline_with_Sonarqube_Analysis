using Microsoft.AspNetCore.Mvc;

namespace WeatherApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class WeatherController : ControllerBase
    {
        [HttpGet]
        public IActionResult Get()
        {
            var weatherData = new
            {
                Temperature = 20,
                Condition = "Sunny",
                Location = "stuttgart"
            };

            return Ok(weatherData);
        }
    }
}
