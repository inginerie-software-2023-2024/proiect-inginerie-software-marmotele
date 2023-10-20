//
//  SplitDetailsViewModel.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation

class SplitDetailsViewModel: BaseViewModel {
    @Published var splitId: UUID
    var split: Split = Split(splitName: "Push",
                                        description: "very nice chicken and rice",
                                        workouts: [
                                        Workout(workoutName: "Glutes"),
                                        Workout(workoutName: "Glutes"),
                                        Workout(workoutName: "Glutes"),
                                        Workout(workoutName: "Glutes")
                                        ])
    
    init(splitId: UUID) {
        self.splitId = splitId
    }
}
