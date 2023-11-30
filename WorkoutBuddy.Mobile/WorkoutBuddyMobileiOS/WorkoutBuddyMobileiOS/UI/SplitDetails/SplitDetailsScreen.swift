//
//  SplitDetailsScreen.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import SwiftUI

struct SplitDetailsScreen: View {
    @StateObject var viewModel: SplitDetailsViewModel
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        switch viewModel.splitDetailsState {
        case .failure(let error):
            Text("\(error.localizedDescription)")
        case .loading:
            ZStack {
                LinearGradient(gradient: Gradient(colors: [CustomColors.myDarkGray, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                ProgressView().foregroundColor(.white)
            }
        case .value(let splitDetails):
            ZStack {
                LinearGradient(gradient: Gradient(colors: [CustomColors.myDarkGray, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Button {
                            navigation.pop(animated: true)
                        } label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .frame(width: 14, height: 12)
                                .foregroundColor(Color.white)
                                .padding(.trailing, 12)
                        }
                        
                        Text(splitDetails.splitName)
                            .font(Font.system(size: 24))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                    }.padding(.vertical, 16)
                        .padding(.horizontal, 20)
                    
                    Text(splitDetails.description)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 12)
                    
                    Rectangle()
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(CustomColors.myNude)
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(splitDetails.workouts, id: \.self) { workout in
                            WorkoutCardView(title: workout.workoutName) {
//                                let vm = SeeProgressViewModel(workout: workout, splitId: viewModel.splitId)
//                                navigation.push(SeeProgressScreen(viewModel: vm).asDestination(), animated: true)
                                let vm = AddProgressViewModel(workout: workout,
                                                              splitId: viewModel.splitId,
                                                              userId: splitDetails.iduser)
                                navigation.push(AddProgressScreen(viewModel: vm).asDestination(), animated: true)
                            }
                        }
                    }.padding(.vertical, 20)
                        .padding(.horizontal, 20)
                }
            }
        }
    }
}

struct WorkoutCardView: View {
    var title: String
    var addProgressHandler: () -> ()
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .font(Font.system(size: 20))
                .foregroundColor(Color.white)
            
            Spacer()
            
            Button {
                addProgressHandler()
            } label: {
                Text("+ Add progress")
                    .font(Font.system(size: 16))
                    .foregroundColor(CustomColors.myDarkGray)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(CustomColors.myNude)
                    .cornerRadius(6)
            }
        }.padding(.all, 16)
            .border(CustomColors.myNude, width: 1)
    }
}
