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
        case .failure(let error):
            Text("\(error.localizedDescription)")
        case .loading:
            ZStack {
                LinearGradient(gradient: Gradient(colors: [CustomColors.background, CustomColors.backgroundDark]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                ProgressView().foregroundColor(.white)
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
                        navigation.replaceNavigationStack([LoginScreen().asDestination()], animated: true)
                    case .failure(let error):
                        viewModel.errorMessage = error.localizedDescription
                        print("Logout failed: \(error)")
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
}

