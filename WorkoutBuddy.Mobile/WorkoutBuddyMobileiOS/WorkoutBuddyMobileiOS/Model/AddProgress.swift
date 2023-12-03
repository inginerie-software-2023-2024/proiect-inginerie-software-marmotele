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
    let setsNo: Int?
    let exerciseId: String
    let exerciseName: String
    let exerciseType: Int?
    let sets: [SetExercise]?
}

struct SetExercise: Codable, Hashable {
    let weight: Double?
    let reps: Int?
    let distance: Double?
    let duration: Int?
}

struct AddProgressBody: Codable {
    let splitId: String
    let userId: String
    let workoutId: String
    let date: Date
    let exercises: [ExerciseBody]?
}

struct ExerciseBody: Codable, Hashable {
    let exerciseId: String
    let exerciseName: String
    let setsNo: Int?
    let exerciseType: Int?
    let sets: [SetExerciseBody]?
}

struct SetExerciseBody: Codable, Hashable {
    let reps: Int?
    let weight: Double?
    let duration: Int?
    let distance: Double?
}
