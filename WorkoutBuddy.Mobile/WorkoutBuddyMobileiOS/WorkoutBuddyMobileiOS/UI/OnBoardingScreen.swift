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
            LinearGradient(gradient: Gradient(colors: [CustomColors.myDarkGray, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    Text("Workout")
                        .font(.system(size: 28))
                        .foregroundColor(CustomColors.myNude)
                        
                    + Text("Buddy")
                        .bold()
                        .font(.system(size: 28))
                        .foregroundColor(CustomColors.myNude)
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
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .background(CustomColors.myNude)
                                .padding(.horizontal, 24)
                            
                        }.padding(.bottom, 14)
                        
                        Button {
                            viewModel.userDefaultsService.setOnboarding(onboardingIsOver: true)
                            navigation.replaceNavigationStack([HomeScreen().asDestination()], animated: true)
                        } label: {
                            Text("Continue as Guest")
                                .bold()
                                .font(.system(size:14))
                                .padding(.all, 12)
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
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
