//
//  Workout.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation

struct MyCollection: Hashable {
    var splitId = UUID()
    let name: String
    let description: String
    let workoutsNb: Int
}
