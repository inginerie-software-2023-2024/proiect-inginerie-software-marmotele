//
//  SeeProgressScreen.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 30.11.2023.
//

import SwiftUI

struct SeeProgressScreen: View {
    @Binding var showModal: Bool
    @StateObject var viewModel: SeeProgressViewModel
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        switch viewModel.seeProgressState {
        case .failure(let error):
            Text("\(error.localizedDescription)")
        case .loading:
            ProgressView()
        case .value(let progressDetails):
            GeometryReader { proxy in
                VStack(alignment: .leading, spacing: 0) {
                    Text("Workout details:")
                        .font(Font.system(size: 24))
                        .foregroundColor(CustomColors.backgroundDark)
                        .padding(.top, 20)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 8)
                    
                    ScrollView(showsIndicators: false) {
                        if let exercises = progressDetails.exercises {
                            ForEach(exercises, id: \.self) { exercise in
                                Button {
                                    navigation.dismissModal(animated: true) {
                                    }
                                    let vm = AddProgressViewModel(workout: viewModel.workout,
                                                                  splitId: viewModel.splitId,
                                                                  userId: viewModel.userId,
                                                                  exercise: exercise)
                                    navigation.push(AddProgressScreen(viewModel: vm).asDestination(), animated: true)
                                } label: {
                                    AddProgressView(name: exercise.exerciseName,
                                                    nbSets: exercise.setsNo,
                                                    sets: exercise.sets) {
                                        let vm = AddProgressViewModel(workout: viewModel.workout,
                                                                      splitId: viewModel.splitId,
                                                                      userId: viewModel.userId,
                                                                      exercise: exercise)
                                        navigation.dismissModal(animated: true) {
                                        }
                                        navigation.push(AddProgressScreen(viewModel: vm).asDestination(), animated: true)
                                    }
                                }
                            }
                        } else {
                            Text("At the moment you haven't any progress for this workout.")
                                .font(Font.system(size: 20))
                                .foregroundColor(CustomColors.buttonDark)
                        }
                    }.padding(.vertical, 20)
                        .padding(.horizontal, 20)
                }.frame(width: proxy.size.width, height: proxy.size.height * 2 / 3)
                    .background(Color.white)
                    .cornerRadius(20)
                    .offset(y: proxy.size.height * 1 / 3)
            }.background(Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                withAnimation {
                    self.showModal = false
                }
            })
        }
    }
}

struct AddProgressView: View {
    let name: String
    let nbSets: Int?
    let sets: [SetExercise]?
    
    let handler: ()->()
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 8, height: 8)
                    .foregroundColor(CustomColors.buttonDark)
                    .padding(.trailing, 4)
                
                Text(name)
                    .font(.system(size: 20))
                    .foregroundColor(CustomColors.buttonDark)
                
                Spacer()
                
                Button {
                    handler()
                } label: {
                    Text("+")
                        .font(.system(size: 24))
                        .foregroundColor(CustomColors.buttonDark)
                }
            }
            
            if let sets = sets {
                ForEach(sets, id:\.self) { set in
                    if let distance = set.distance, let duration = set.duration {
                        HStack(spacing: 0) {
                            Text("Distance: \(distance)")
                                .font(.system(size: 14))
                                .foregroundColor(CustomColors.buttonDark)
                            
                            Spacer()
                            
                            Text("Duration: \(duration)")
                                .font(.system(size: 14))
                                .foregroundColor(CustomColors.buttonDark)
                        }
                    } else if let weight = set.weight, let nbSets = nbSets, let reps = set.reps {
                        VStack(spacing: 8) {
                            HStack(spacing: 0) {
                                Text("Nb of sets: \(nbSets)")
                                    .font(.system(size: 14))
                                    .foregroundColor(CustomColors.buttonDark)
                                
                                Spacer()
                                
                                Text("Nb of reps: \(reps)")
                                    .font(.system(size: 14))
                                    .foregroundColor(CustomColors.buttonDark)
                            }
                            
                            Text("Weight: \(weight)")
                                .font(.system(size: 14))
                                .foregroundColor(CustomColors.buttonDark)
                        }
                    } else if let nbSets = nbSets, let reps = set.reps {
                        HStack(spacing: 0) {
                            Text("Nb of sets: \(nbSets)")
                                .font(.system(size: 14))
                                .foregroundColor(CustomColors.buttonDark)
                            
                            Spacer()
                            
                            Text("Nb of reps: \(reps)")
                                .font(.system(size: 14))
                                .foregroundColor(CustomColors.buttonDark)
                        }
                    }
                }
            }
        }
    }
}
