//
//  SeeProgressScreen.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 30.11.2023.
//

import SwiftUI

struct SeeProgressScreen: View {
    @StateObject var viewModel: SeeProgressViewModel
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        switch viewModel.seeProgressState {
        case .failure(let error):
            Text("\(error.localizedDescription)")
        case .loading:
            ZStack {
                LinearGradient(gradient: Gradient(colors: [CustomColors.myDarkGray, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                ProgressView().foregroundColor(.white)
            }
        case .value(let progressDetails):
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
                        
                        Text(progressDetails.date.description)
                            .font(Font.system(size: 24))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                    }.padding(.vertical, 16)
                        .padding(.horizontal, 20)
                    
                    Rectangle()
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(CustomColors.myNude)
                    
                    ScrollView(showsIndicators: false) {
                        if let exercises = progressDetails.exercises {
                            ForEach(exercises, id: \.self) { exercise in
                                WorkoutCardView(title: exercise.exerciseName) {
//                                    let vm = AddProgressViewModel(workout: viewModel.workout, splitId: viewModel.splitId)
//                                    navigation.push(AddProgressScreen(viewModel: vm).asDestination(), animated: true)
                                }
                            }
                        }
                    }.padding(.vertical, 20)
                        .padding(.horizontal, 20)
                }
            }
        }
    }
}

