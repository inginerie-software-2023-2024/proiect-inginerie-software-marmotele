//
//  Split.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation

struct Split {
    var userId = UUID()
    let splitName: String
    let description: String
    let splitId = UUID()
    let workouts: [Workout]
}
