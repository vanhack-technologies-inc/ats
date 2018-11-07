using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;
using ats.Models;

namespace ats.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class ApplicationController : ControllerBase
    {
        private readonly AtsContext _context;

        public ApplicationController ( AtsContext context )
        {
            _context = context;
        }

        #region CRUD Controllers

        #region Retrieve - List All

        /// <summary>
        /// List All Application saved
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     GET /api/Application/list
        ///
        ///
        /// </remarks>
        /// <returns>List of Candidates</returns>
        /// <response code="200">List of Application in Database(memory)</response>
        [ProducesResponseType(200)]
        [HttpGet("list", Name = "ListApplication")]
        public ActionResult<List<Application>> GetAll()
        {
            return _context.Applications.ToList();
        }

        #endregion

        

        #endregion

    }

}
