//
//  StartScreen.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import SwiftUI

struct StartScreen: View {
    @ObservedObject var viewModel = StartViewModel()
    
    var body: some View {
        if viewModel.isLoggedIn() {
            HomeScreen()
        } else {
            if viewModel.getOnboardingStatus() {
                LoginScreen()
            } else {
                OnBoardingScreen()
            }
        }
    }
}
