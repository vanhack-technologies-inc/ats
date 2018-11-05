using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;
using ats.Models;

namespace ats.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class JobController : ControllerBase
    {
        private readonly AtsContext _context;

        public JobController( AtsContext context )
        {
            _context = context;
        }

        #region CRUD Controllers

        #region Retrieve - List All

        /// <summary>
        /// List All Jobs saved
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     GET /api/Job/list
        ///
        ///
        /// </remarks>
        /// <returns>List of Jobs</returns>
        /// <response code="200">List of Jobs in Database(memory)</response>
        [ProducesResponseType(200)]
        [HttpGet("list", Name = "ListJob")]
        public ActionResult<List<Job>> GetAll()
        {
            return _context.Jobs.ToList();
        }

        #endregion

        #region Retrieve - Get by {id}

        /// <summary>
        /// Get a Job by id
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     GET /api/Job/get/{id}
        ///
        /// </remarks>
        /// <param name="id">Job Iid</param>
        /// <returns>The Job requested</returns>
        /// <response code="200">Returns the Job requested using the its {id}</response>
        /// <response code="404">If the Job could not be find on Database(memory)</response>
        [ProducesResponseType(200)]
        [ProducesResponseType(404)]
        [HttpGet("get/{id}", Name = "GetJob")]
        [ProducesResponseType(200)]
        public ActionResult<Job> GetByid(long id)
        {
            var item = _context.Jobs.Find(id);
            if (item == null)
            {
                return NotFound();
            }

            return item;
        }

        #endregion

        #region Create or Update - save or update a Job

        /// <summary>
        /// Create or Update a Job.
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     POST /api/Job/save
        ///     {
        ///       "id": 0,
        ///       "name": "string",
        ///       "description": "string",
        ///       "company": "string",
        ///       "recruiter": "string",
        ///       "open": true
        ///      }
        ///
        /// </remarks>
        /// <param name="job"> see Job's model</param>
        /// <returns>Returns the save proccess status</returns>
        /// <response code="200">Returns the save proccess worked properly</response>
        [ProducesResponseType(200)]
        [HttpPost("save", Name = "SaveJob")]
        public ActionResult Save(Job job)
        {
            Job lookup=_context.Jobs.Find(job.id);

            if ( lookup != null)
            {
              _context.Jobs.Remove(lookup);
            }
            _context.Jobs.Add(job);
            _context.SaveChanges();

            return Ok();
        }

        #endregion

        #region Delete - Delete Job by {id}

        /// <summary>
        /// Remove a Job by Id
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     DELETE /api/Job/remove/{id}
        ///
        /// </remarks>
        /// <param name="id">Job id</param>
        /// <returns>The Job deletion status</returns>
        /// <response code="200">Returns the Job was successfully removed</response>
        /// <response code="404">The Job could not be found on Database(memory)</response>
        [ProducesResponseType(200)]
        [ProducesResponseType(404)]

        [HttpDelete("remove/{username}", Name = "RemoveJob")]
        public ActionResult RemoveByUsername(long id)
        {
            var item = _context.Jobs.Find(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.Jobs.Remove(item);
            _context.SaveChanges();

            return Ok();

        }

        #endregion

        #endregion

    }

}
