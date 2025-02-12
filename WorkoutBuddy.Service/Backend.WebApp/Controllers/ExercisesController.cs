﻿using Backend.BusinessLogic.Exercises;
using Backend.Common.DTOs;
using Backend.WebApp.Code.Base;
using Backend.WebApp.Code.ExtensionMethods;
using Backend.WebApp.Code.Utils;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;


namespace Backend.WebApp.Controllers
{
    [Route("[controller]")]
    [ApiController]
    //[Authorize]
    public class ExercisesController : BaseController
    {
        private readonly ExerciseService exerciseService;
        //private readonly ILogger _logger;
        public ExercisesController(ControllerDependencies dependencies, ExerciseService service) : base(dependencies)
        {
            this.exerciseService = service;
        }

        [HttpGet("get")]
        public async Task<IActionResult> GetExercises([FromQuery] List<int>? MuscleGroup, [FromQuery] string? Search = "")
        {
            var exercises = await exerciseService.GetExercises(MuscleGroup, Search);

            return Ok(exercises);
        }

        [HttpGet("view")]
        public IActionResult ViewExercise(Guid id)
        {
            var exercise = exerciseService.GetExercise(id);
            return Ok(exercise);
        }

        [HttpGet("getExerciseForInsert")]
        public async Task<IActionResult> GetExerciseForInsert([FromQuery] Guid id)
        {
            var exercise = await exerciseService.GetInsertExerciseModel(id);
            return Ok(exercise);
        }

        [HttpPost("insertExercise")]
        public IActionResult InsertExercise([FromQuery] ListItemModel<string, int> selectedType, [FromQuery] List<ListItemModel<string, int>> selectedMuscleGroups, [FromForm] InsertExerciseModel model)
        {
            try
            {
                model.SelectedType = selectedType;
                model.SelectedMuscleGroups = selectedMuscleGroups;
                if (model.ExerciseId == Guid.Empty)
                {
                    exerciseService.AddExercise(model);
                }
                else
                {
                    exerciseService.EditExercise(model);
                }
                return Ok();
            } catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }

        [HttpPost("delete")]
        public IActionResult DeleteExercise([FromBody] Guid exerciseId)
        {
            exerciseService.DeleteExercise(exerciseId);
            return Ok();
        }

        [HttpGet("getExercisesByMuscleGroups")]
        public async Task<IActionResult> GetExercisesByMuscleGroups([FromQuery] List<string> selectedMusclesString)
        {
            var exercises = await exerciseService.GetFilteredExercises(selectedMusclesString);
            return Ok(exercises);
        }

        [HttpPost("approve")]
        public IActionResult ApproveExercise([FromBody] string id)
        {
            exerciseService.ApproveExercise(Guid.Parse(id));
            return Ok();
        }

        [HttpPost("reject")]
        public IActionResult Reject([FromBody] string id)
        {
            exerciseService.DeleteExercise(Guid.Parse(id));
            return Ok();
        }

    }
}