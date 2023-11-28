//
//  UserDefaultsService.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation

enum UserDefaultsKeys {
    static let hasOnboardingCompleted = "onboardingIsOver"
}

class UserDefaultsService {
    static let shared = UserDefaultsService()
    
    private let defaults: UserDefaults
    
    private init() {
        defaults = UserDefaults.standard
    }
    
    func setOnboarding(onboardingIsOver: Bool) {
        defaults.set(onboardingIsOver, forKey: UserDefaultsKeys.hasOnboardingCompleted)
    }
    
    func getOnboardingStatus() -> Bool {
        defaults.bool(forKey: UserDefaultsKeys.hasOnboardingCompleted)
    }
}

