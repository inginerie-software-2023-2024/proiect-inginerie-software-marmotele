using Backend.BusinessLogic.Base;
using Backend.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace Backend.BusinessLogic.Implementation.MuscleGroups
{
    public class MuscleGroupsService : BaseService
    {
        public MuscleGroupsService(ServiceDependencies dependencies) : base(dependencies)
        {
        }

        public async Task<IEnumerable<MuscleGroup>> GetMuscleGroupsAsync()
        {
            return await UnitOfWork.MuscleGroups.Get().ToListAsync();
        }
    }
}
