//
//  AddProgress.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 21.10.2023.
//

import Foundation

struct AddProgress: Codable {
    let splitId: String
    let date: String
    let exercises: [Exercise]?
    let userId: String
    let workoutId: String
}

struct Exercise: Codable, Hashable {
    var setsNo: Int?
    let exerciseId: String
    let exerciseName: String
    var exerciseType: Int?
    var sets: [SetExercise]?
}

struct SetExercise: Codable, Hashable {
    var weight: Double?
    var reps: Int?
    var distance: Double?
    var duration: Int?
}

struct AddProgressBody: Codable {
    let SplitId: String
    let UserId: String
    let WorkoutId: String
    let Date: String?
    let Exercises: [ExerciseBody]?
}

struct ExerciseBody: Codable, Hashable {
    let ExerciseId: String
    let ExerciseName: String
    let SetsNo: Int?
    let ExerciseType: Int?
    let Sets: [SetExerciseBody]?
}

struct SetExerciseBody: Codable, Hashable {
    let Reps: Int?
    let Weight: Double?
    let Duration: Int?
    let Distance: Double?
}
