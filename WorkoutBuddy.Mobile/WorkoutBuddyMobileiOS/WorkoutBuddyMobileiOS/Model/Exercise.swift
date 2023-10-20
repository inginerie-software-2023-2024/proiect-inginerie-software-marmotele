//
//  Exercise.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 21.10.2023.
//

import Foundation

struct Exercise {
    var exerciseId = UUID()
    let exerciseName: String
    let nbSets: Int?
    let exerciseType: Int?
    let sets: [SetExercise]
}
