//
//  Workout.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation

struct MyCollection: Hashable, Decodable {
    let splitId: String
    let workoutsNo: Int
    let name: String
    let description: String
}
