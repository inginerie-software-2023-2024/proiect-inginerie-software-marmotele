//
//  User.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 28.11.2023.
//

import Foundation

struct LoginBody: Codable {
    var email: String
    var password: String
    var areCredentialsInvalid: Bool
    var isDisabled: Bool
}

struct User: Codable {
    var token: String
    var roles: [String]
    var username: String
}
