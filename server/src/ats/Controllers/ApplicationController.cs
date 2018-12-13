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

        public ApplicationController(AtsContext context)
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


        #region Retrieve - Get by {jobId} / {username}

        /// <summary>
        /// Get an Application with Candidate's {username} and {jobId}
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     GET /api/Application/get/{jobId}/{username}
        ///
        /// </remarks>
        /// <param name="jobId">Job's id username </param>
        /// <param name="username">Candidate's username </param>
        /// <returns>The Candidate requested</returns>
        /// <response code="200">Returns the Application requested using the its {username} and {jobId}</response>
        /// <response code="404">If the Application could not be find on Database(memory)</response>
        [ProducesResponseType(200)]
        [ProducesResponseType(404)]
        [HttpGet("get/{jobId}/{username}", Name = "GetApplication")]
        [ProducesResponseType(200)]
        public ActionResult<Application> GetByUsernameAndJobId(long jobId, string username)
        {
            var application = _context.Applications.Find(jobId, username);
            if (application == null)
            {
                return NotFound();
            }

            return application;
        }

        #endregion


        #region Create or Update - save or update a Candidate

        /// <summary>
        /// Create or Update an Application of some candidate for some specific application.
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     POST /api/Application/save
        ///             {
        ///               "jobId": 0,
        ///               "username": "string",
        ///               "status": "string"
        ///             }
        ///
        /// </remarks>
        /// <param name="application"> see Application's model</param>
        /// <returns>Returns the save proccess status</returns>
        /// <response code="200">Returns the save proccess worked properly</response>
        [ProducesResponseType(200)]
        [HttpPost("save", Name = "SaveApplication")]
        public ActionResult Save(Application application)
        {
            Application lookup = _context.Applications.Find(application.jobId, application.username);

            if (lookup != null)
            {
                _context.Applications.Remove(lookup);
            }
            _context.Applications.Add(application);
            _context.SaveChanges();

            return Ok();
        }

        #endregion

        #region Delete - Delete Candidate by {username}
        /// <summary>
        /// Get an Application with Candidate's {username} and {jobId}
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     DELETE /api/Application/get/{jobId}/{username}
        ///
        /// </remarks>
        /// <param name="jobId">Job's id username </param>
        /// <param name="username">Candidate's username </param>
        /// <returns>The Application deletion status</returns>
        /// <response code="200">Returns if the Application was successfully removed</response>
        /// <response code="404">The Application could not be found on Database(memory)</response>
        [ProducesResponseType(200)]
        [ProducesResponseType(404)]

        [HttpDelete("remove/{jobId}/{username}", Name = "RemoveApplication")]
        public ActionResult RemoveByUsernameAndJobId(long jobId, string username)
        {
            var application = _context.Applications.Find(jobId, username);
            if (application == null)
            {
                return NotFound();
            }
            _context.Applications.Remove(application);
            _context.SaveChanges();

            return Ok();

        }

        #endregion

        #endregion

    }

}
