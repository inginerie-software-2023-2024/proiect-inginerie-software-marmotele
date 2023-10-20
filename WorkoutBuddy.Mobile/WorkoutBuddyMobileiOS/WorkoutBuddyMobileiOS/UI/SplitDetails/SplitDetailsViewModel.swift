//
//  SplitDetailsViewModel.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation

class SplitDetailsViewModel: BaseViewModel {
    @Published var workout: Workout  //todo api call
    
    init(workout: Workout) {
        self.workout = workout
    }
}
