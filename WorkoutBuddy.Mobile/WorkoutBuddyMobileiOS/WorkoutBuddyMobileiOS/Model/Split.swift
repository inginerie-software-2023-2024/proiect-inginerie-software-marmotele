//
//  Split.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation

struct Split: Decodable, Hashable {
    let idsplit: String
    let rating: Int?
    let iduser: String
    let workouts: [Workout]
    let description: String
    let splitName: String
}

struct Workout: Hashable, Decodable {
    let workoutName: String
    let workoutId: String
}
