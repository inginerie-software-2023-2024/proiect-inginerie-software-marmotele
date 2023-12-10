//
//  SplitHistory.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 10.12.2023.
//

import Foundation

struct History: Codable, Hashable {
    let workoutId: String
    let dates: [String]
    let coefList: [Double]
    let firstWorkout: WorkoutHistoryModel
}

struct WorkoutHistoryModel: Codable, Hashable {
    let workoutId: String
    let date: String
    let exercises: [ExerciseHistoryModel]?
}

struct ExerciseHistoryModel: Codable, Hashable {
    let exerciseId: String
    let exerciseName: String
    let exerciseType: Int
    let sets: [SetExercise]
    let isPr: Bool
}
