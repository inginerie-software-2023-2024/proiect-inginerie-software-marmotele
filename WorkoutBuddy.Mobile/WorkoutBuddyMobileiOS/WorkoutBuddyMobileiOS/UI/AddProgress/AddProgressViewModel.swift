//
//  AddProgressViewModel.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation
import Combine

enum WorkoutType {
    case cardio
    case calistenics
    case weightLifting
}

class AddProgressViewModel: BaseViewModel {
    //idworkout idProgress
    @Published var selectedDate = Date.now
    @Published var nbOfSets: String = ""
    @Published var nbOfReps: String = ""
    @Published var weight: String = ""
    @Published var distance: String = ""
    @Published var duration: String = ""
    
    let workoutType = CurrentValueSubject<WorkoutType, Never>(.cardio)
    
}
