//
//  OnBoardingScreen.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 28.11.2023.
//

import SwiftUI

struct OnBoardingScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel = OnBoardingViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [CustomColors.background, CustomColors.backgroundDark]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    Text("Workout")
                        .font(.system(size: 28))
                        .foregroundColor(CustomColors.button)
                        
                    + Text("Buddy")
                        .bold()
                        .font(.system(size: 28))
                        .foregroundColor(CustomColors.buttonDark)
                }.multilineTextAlignment(.leading)
                .padding(.bottom, 16)
                    .padding(.horizontal, 24)
                
                Text("Be healthy with WorkoutBuddy")
                    .bold()
                    .font(.system(size: 26))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 24)
                
                Text("Add you progress, check your workouts and be healthy from anywhere, anytime")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 24)
                    .padding(.horizontal, 24)
                
                ZStack {
                    Image("onboarding")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    VStack(spacing: 0) {
                        Spacer()
                        
                        Button {
                            viewModel.userDefaultsService.setOnboarding(onboardingIsOver: true)
                            navigation.push(LoginScreen().asDestination(), animated: true)
                        } label: {
                            Text("Access my WorkoutBuddy Account")
                                .bold()
                                .font(.system(size:14))
                                .padding(.all, 12)
                                .foregroundColor(CustomColors.backgroundDark)
                                .frame(maxWidth: .infinity)
                                .background(CustomColors.buttonDark)
                                .padding(.horizontal, 24)
                                .padding(.bottom, 24)
                        }.padding(.bottom, 16)
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea(.all)
            }
        }
    }
}
