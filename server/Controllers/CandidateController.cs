using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;
using ats.Models;

namespace ats.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class CandidateController : ControllerBase
    {
        private readonly CandidateContext _context;

        public CandidateController ( CandidateContext context )
        {
            _context = context;
        }

        #region CRUD Controllers

        #region Retrieve - List All

        /// <summary>
        /// List All Candidates saved
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     GET /api/Candidate/list
        ///
        ///
        /// </remarks>
        /// <returns>List of Candidates</returns>
        /// <response code="200">List of Candidates in Database(memory)</response>
        [ProducesResponseType(200)]
        [HttpGet("list", Name = "ListCandidate")]
        public ActionResult<List<Candidate>> GetAll()
        {
            return _context.Candidates.ToList();
        }

        #endregion

        #region Retrieve - Get by {username}

        /// <summary>
        /// Get a Candidate by username
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     GET /api/Candidate/get/{username}
        ///
        /// </remarks>
        /// <param name="username">Candidate username </param>
        /// <returns>The Candidate requested</returns>
        /// <response code="200">Returns the Candidate requested using the its {username}</response>
        /// <response code="404">If the Candidate could not be find on Database(memory)</response>
        [ProducesResponseType(200)]
        [ProducesResponseType(404)]
        [HttpGet("get/{username}", Name = "GetCandidate")]
        [ProducesResponseType(200)]
        public ActionResult<Candidate> GetByUsername(string username)
        {
            var candidate = _context.Candidates.Find(username);
            if (candidate == null)
            {
                return NotFound();
            }

            return candidate;
        }

        #endregion

        #region Create or Update - save or update a Candidate

        /// <summary>
        /// Create or Update a Candidate.
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     POST /api/Candidate/save
        ///             {
        ///               "username": "string",
        ///               "email": "string",
        ///               "name": "string",
        ///               "verified": true
        ///             }
        ///
        /// </remarks>
        /// <param name="candidate"> see Candidate's model</param>
        /// <returns>Returns the save proccess status</returns>
        /// <response code="200">Returns the save proccess worked properly</response>
        [ProducesResponseType(200)]
        [HttpPost("save", Name = "SaveCandidate")]
        public ActionResult Save(Candidate candidate)
        {
            Candidate lookup=_context.Candidates.Find(candidate.username);

            if ( lookup != null)
            {
              _context.Candidates.Remove(lookup);
            }
            _context.Candidates.Add(candidate);
            _context.SaveChanges();

            return Ok();
        }

        #endregion

        #region Delete - Delete Candidate by {username}

        /// <summary>
        /// Remove a Candidate by Id
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     DELETE /api/Candidate/remove/{username}
        ///
        /// </remarks>
        /// <param name="username">Candidate's username</param>
        /// <returns>The Candidate deletion status</returns>
        /// <response code="200">Returns the Candidate was successfully removed</response>
        /// <response code="404">The Candidate could not be found on Database(memory)</response>
        [ProducesResponseType(200)]
        [ProducesResponseType(404)]

        [HttpDelete("remove/{username}", Name = "RemoveCandidate")]
        public ActionResult RemoveByUsername(string username)
        {
            var candidate = _context.Candidates.Find(username);

            if (candidate == null)
            {
                return NotFound();
            }

            _context.Candidates.Remove(candidate);
            _context.SaveChanges();

            return Ok();

        }

        #endregion

        #endregion

    }

}
