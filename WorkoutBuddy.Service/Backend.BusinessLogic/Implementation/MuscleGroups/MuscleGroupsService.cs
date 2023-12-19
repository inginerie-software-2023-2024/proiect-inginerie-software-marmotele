﻿using Backend.BusinessLogic.Base;
using Backend.Entities;
using Backend.Entities.Enums;

namespace Backend.BusinessLogic.Implementation.MuscleGroupsService
{
    public class MuscleGroupsService : BaseService
    {
        public MuscleGroupsService(ServiceDependencies dependencies) : base(dependencies)
        {
        }

        public async Task<IEnumerable<MuscleGroup>> GetMuscleGroupsAsync()
        {
            var muscleGroups = Enum.GetValues<MuscleGroups>().Select((m, i) => new MuscleGroup { Idgroup = i, Name = m.ToString() }).ToList();
            return muscleGroups;
        }
    }
}
