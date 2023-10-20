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
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text("Your collection: ")
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 24))
                
                Spacer()
                
                Button {
                    viewModel.logOut()
                } label: {
                    Text("Log out")
                        .font(Font.system(size: 24))
                        .foregroundColor(.white)
                        .padding(.all, 8)
                        .background(Color.black)
                        
                }
            }.padding(.all, 12)
            
            Rectangle()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.gray)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(viewModel.workouts, id: \.self) { workout in
                        SplitCardView(title: workout.title,
                                      description: workout.description,
                                      numberWorkouts: 3,
                                      viewDetailsHandler: {
                            let vm = SplitDetailsViewModel(workout: workout)
                            navigation.push(SplitDetailsScreen(viewModel: vm).asDestination(), animated: true)
                        })
                        .padding(.all, 12)
                        .onTapGesture {
                            let vm = SplitDetailsViewModel(workout: workout)
                            navigation.push(SplitDetailsScreen(viewModel: vm).asDestination(), animated: true)
                        }
                    }
                }
            }
        }
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

struct SplitCardView: View {
    var title: String
    var description: String
    var numberWorkouts: Int
    var viewDetailsHandler: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .foregroundColor(Color.black)
                .font(Font.system(size: 20))
            
            HStack(spacing: 0) {
                Text("Description:")
                    .foregroundColor(Color.black)
                    .bold()
                    .font(Font.system(size: 14))
                
                Spacer()
                
                Text(description)
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 14))
            }
            
            HStack(spacing: 0) {
                Text("Number of workouts:")
                    .foregroundColor(Color.black)
                    .bold()
                    .font(Font.system(size: 14))
                
                Spacer()
                
                Text("\(numberWorkouts)")
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 14))
            }
            
            Button {
                viewDetailsHandler()
            } label: {
                Text("View details")
                    .foregroundColor(Color.white)
                    .font(Font.system(size: 14))
                    .padding(.all, 8)
                    .background(Color.black)
            }
        }
        .padding(.all, 8)
        .border(Color.black, width: 1)
    }
}
