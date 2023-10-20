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
        ZStack {
            CustomColors.background.ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Text("Your collection ")
                        .foregroundColor(.white)
                        .font(Font.system(size: 24))
                    
                    Spacer()
                    
                    Button {
                        viewModel.logOut()
                    } label: {
                        Text("Log out")
                            .font(Font.system(size: 16))
                            .foregroundColor(CustomColors.background)
                            .frame(height: 20)
                            .padding(.all, 12)
                            .background(CustomColors.button)
                            .cornerRadius(6)
                        
                    }
                }.padding(.top, 16)
                    .padding(.bottom, 12)
                    .padding(.horizontal, 20)
                
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(CustomColors.button)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(viewModel.myCollection, id: \.self) { collection in
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
                }.padding(.horizontal, 20)
                    .padding(.vertical, 16)
            }.onReceive(viewModel.eventSubject) { eventSubject in
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
                    .foregroundColor(.white)
                    .font(Font.system(size: 20))
                Spacer()
            }
                .padding(.all, 12)
                .background(Color.black.opacity(0.5))
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Text("Description:")
                        .foregroundColor(Color.white)
                        .bold()
                        .font(Font.system(size: 14))
                    
                    Spacer()
                    
                    Text(collection.description)
                        .foregroundColor(Color.white)
                        .font(Font.system(size: 14))
                }.padding(.bottom, 16)
                
                HStack(spacing: 0) {
                    Text("Number of workouts:")
                        .foregroundColor(Color.white)
                        .bold()
                        .font(Font.system(size: 14))
                    
                    Spacer()
                    
                    Text("\(collection.workoutsNb)")
                        .foregroundColor(Color.white)
                        .font(Font.system(size: 14))
                }.padding(.bottom, 16)
                
                HStack {
                    Spacer()
                    Button {
                        viewDetailsHandler()
                    } label: {
                        Text("View details")
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 16))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.black).opacity(0.5)
                            .cornerRadius(14)
                    }
                    Spacer()
                }
            }
            .padding(.all, 12)
            .border(Color.black.opacity(0.5), width: 2)
            .cornerRadius(4)
        }
        .frame(maxWidth: .infinity)
    }
}
