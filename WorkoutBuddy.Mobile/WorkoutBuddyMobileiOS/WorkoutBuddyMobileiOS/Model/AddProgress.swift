//
//  AddProgress.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 21.10.2023.
//

import Foundation

struct AddProgress {
    var splitId = UUID()
    let userId: String
    let workoutId: String
    let date: Date
    let Exercises: [Exercise]?
}
