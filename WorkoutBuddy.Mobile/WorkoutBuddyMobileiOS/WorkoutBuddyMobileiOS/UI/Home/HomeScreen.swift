//
//  HomeScreen.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject private var navigation: Navigation
    var body: some View {
        switch viewModel.splitsState {
        case .failure(_):
            ModalChooseOptionView(title: "Oops",
                                              description: "An error has occured. Please try again later!",
                                              topButtonText: "Retry") {
                navigation.dismissModal(animated: true, completion: nil)
                navigation.replaceNavigationStack([LoginScreen().asDestination()], animated: true)
            }
        case .loading:
            ZStack {
                LinearGradient(gradient: Gradient(colors: [CustomColors.background, CustomColors.backgroundDark]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                LoaderView()
            }
        case .value(let splits):
            ZStack {
                LinearGradient(gradient: Gradient(colors: [CustomColors.background, CustomColors.backgroundDark]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text("Your collection ")
                            .foregroundColor(.white)
                            .font(Font.system(size: 24))
                        
                        Spacer()
                        
                        Button {
                            viewModel.logOut()
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundColor(CustomColors.buttonDark)
                        }
                    }.padding(.top, 16)
                        .padding(.bottom, 12)
                    
                    Rectangle()
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(CustomColors.button)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(splits, id: \.self) { collection in
                                SplitCardView(collection: collection,
                                              viewDetailsHandler: {
                                    let vm = SplitDetailsViewModel(splitId: collection.splitId)
                                    navigation.push(SplitDetailsScreen(viewModel: vm).asDestination(), animated: true)
                                })
                                .onTapGesture {
                                    let vm = SplitDetailsViewModel(splitId: collection.splitId)
                                    navigation.push(SplitDetailsScreen(viewModel: vm).asDestination(), animated: true)
                                }
                            }
                        }
                    }.padding(.vertical, 16)
                }.padding(.horizontal, 20)
                .onReceive(viewModel.eventSubject) { eventSubject in
                    switch eventSubject {
                    case .logout:
                        let modal = ModalChooseOptionView(title: "Are you sure?",
                                                          description: "You will be logged out from your account and in order to access the content of your app, you'll have to log in again.",
                                                          topButtonText: "Log out",
                                                          bottomButtonText: "Stay") {
                            navigation.dismissModal(animated: true, completion: nil)
                            navigation.replaceNavigationStack([LoginScreen().asDestination()], animated: true)
                        } onBottomButtonTapped: {
                            navigation.dismissModal(animated: true, completion: nil)
                        }
                        
                        navigation.presentModal(modal.asDestination(),
                                                animated: true,
                                                completion: nil,
                                                controllerConfig: nil)
                    case .failure(_):
                        let modal = ModalChooseOptionView(title: "Oops",
                                                          description: "An error has occured. Please try again later!",
                                                          topButtonText: "Retry") {
                            navigation.dismissModal(animated: true, completion: nil)
                            navigation.replaceNavigationStack([LoginScreen().asDestination()], animated: true)
                        }
                        navigation.presentModal(modal.asDestination(),
                                                animated: true,
                                                completion: nil,
                                                controllerConfig: nil)
                    }
                }
            }
        }
    }
}

struct SplitCardView: View {
    var collection: MyCollection
    var viewDetailsHandler: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(collection.name)
                    .bold()
                    .foregroundColor(CustomColors.backgroundDark)
                    .font(Font.system(size: 20))
                Spacer()
            }
            .padding(.all, 12)
            .background(CustomColors.buttonDark)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Text("Description:")
                        .foregroundColor(.white)
                        .bold()
                        .font(Font.system(size: 14))
                    
                    Spacer()
                    
                    Text(collection.description)
                        .foregroundColor(CustomColors.button)
                        .font(Font.system(size: 14))
                }.padding(.bottom, 16)
                
                HStack(spacing: 0) {
                    Text("Number of workouts:")
                        .foregroundColor(Color.white)
                        .bold()
                        .font(Font.system(size: 14))
                    
                    Spacer()
                    
                    Text("\(collection.workoutsNo)")
                        .foregroundColor(CustomColors.button)
                        .font(Font.system(size: 14))
                }.padding(.bottom, 16)
                
                HStack {
                    Spacer()
                    Button {
                        viewDetailsHandler()
                    } label: {
                        Text("See details")
                            .underline()
                            .foregroundColor(CustomColors.buttonDark)
                            .font(Font.system(size: 16))
                    }
                }
            }
            .padding(.all, 12)
            .border(CustomColors.buttonDark, width: 2)
            .cornerRadius(4)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ModalChooseOptionView: View {
    let title: String
    let description: String
    let topButtonText: String
    var bottomButtonText: String?
    let onTopButtonTapped: () -> ()
    var onBottomButtonTapped: (() -> ())?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(spacing: 0) {
                
                Text(title)
                    .bold()
                    .font(.system(size: 24))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 12)
                
                Text(description)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 24)
                
                VStack(spacing: 12) {
                    Button {
                        onTopButtonTapped()
                    } label: {
                        Text(topButtonText)
                            .bold()
                            .font(.system(size: 14))
                            .padding(.all, 12)
                            .foregroundColor(CustomColors.background)
                            .frame(maxWidth: .infinity)
                            .background(CustomColors.button)
                        
                    }
                    
                    if let onBottomButtonTapped = onBottomButtonTapped,
                        let bottomButtonText = bottomButtonText {
                        Button {
                            onBottomButtonTapped()
                        } label: {
                            Text(bottomButtonText)
                                .bold()
                                .font(.system(size: 14))
                                .padding(.all, 12)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .background(CustomColors.buttonDark)
                            
                        }
                    }
                }
            }.padding(.horizontal, 24)
                .padding(.vertical, 36)
                .background(Color.white.cornerRadius(8))
                .padding(.horizontal, 24)
        }.ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
