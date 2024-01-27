//
//  StartViewModel.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation

class StartViewModel: BaseViewModel {
    var userDefaultsService = UserDefaultsService.shared
    var userService = UserService.shared
    
    func isLoggedIn() -> Bool {
        return userService.isLoggedIn
    }
    
    func getOnboardingStatus() -> Bool {
        return userDefaultsService.getOnboardingStatus()
    }

}
