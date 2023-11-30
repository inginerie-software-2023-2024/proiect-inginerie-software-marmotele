//
//  AddProgress.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 21.10.2023.
//

import Foundation

struct AddProgress: Codable {
    let splitId: String
    let date: Date
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
    let reps: Int?
    let weight: Double?
    let duration: Int?
    let distance: Double?
}
