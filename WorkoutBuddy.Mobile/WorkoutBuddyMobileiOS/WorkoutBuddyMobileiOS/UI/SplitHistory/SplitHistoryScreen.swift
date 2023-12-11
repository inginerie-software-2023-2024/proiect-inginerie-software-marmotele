//
//  SplitHistoryScreen.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 10.12.2023.
//

import SwiftUI
import Charts

struct SplitHistoryScreen: View {
    @StateObject var viewModel: SplitHistoryViewModel
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        switch viewModel.seeHistoryState {
        case .failure(let error):
            Text("\(error.localizedDescription)")
        case .loading:
            ZStack {
                LinearGradient(gradient: Gradient(colors: [CustomColors.background, CustomColors.backgroundDark]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                ProgressView().foregroundColor(.white)
            }
        case .value(let splitHistory):
            ZStack {
                LinearGradient(gradient: Gradient(colors: [CustomColors.background, CustomColors.backgroundDark]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Button {
                            navigation.pop(animated: true)
                        } label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color.white)
                                .padding(.trailing, 12)
                        }
                        
                        Text(viewModel.workout.workoutName)
                            .font(Font.system(size: 24))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                    }.padding(.top, 16)
                        .padding(.bottom, 8)
                        
                    Rectangle()
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(CustomColors.button)
                        .padding(.bottom, 16)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            if let date = splitHistory.dates.last {
                                Text("Last update: \(date.rearrangeDate(date: date))")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                                    .padding(.vertical, 12)
                            }
                            
                            if let exercises = splitHistory.firstWorkout.exercises {
                                ForEach(exercises, id: \.self) { exercise in
                                    HStack(spacing: 0) {
                                        VStack(alignment: .leading, spacing: 0) {
                                            if exercise.isPr {
                                                HStack(spacing: 8) {
                                                    Image(systemName: "checkmark.circle.fill")
                                                        .resizable()
                                                        .frame(width: 20, height: 20)
                                                        .foregroundColor(CustomColors.backgroundDark)
                                                    
                                                    Text("\(exercise.exerciseName)")
                                                        .bold()
                                                        .font(.system(size: 20))
                                                        .foregroundColor(CustomColors.backgroundDark)
                                                    
                                                    Spacer()
                                                }.padding(.bottom, 16)
                                            } else {
                                                Text("\(exercise.exerciseName)")
                                                    .bold()
                                                    .font(.system(size: 20))
                                                    .foregroundColor(CustomColors.backgroundDark)
                                                    .padding(.bottom, 16)
                                            }
                                            
                                            ForEach(exercise.sets, id: \.self) { set in
                                                if exercise.exerciseType == 1 {
                                                    CardioView(distance: String(set.distance ?? 0), duration: String(set.duration ?? 0))
                                                } else if exercise.exerciseType == 2 {
                                                    WeightView(nbOfReps: String(set.reps ?? 0), weight: String(set.weight ?? 0))
                                                } else {
                                                    CalitenicsView(reps: String(set.reps ?? 0))
                                                }
                                            }
                                            
                                        }
                                        
                                        Spacer()
                                    }.padding(.all, 12)
                                        .frame(maxWidth: .infinity)
                                        .background(.white)
                                        .cornerRadius(10)
                                        .padding(.vertical, 12)
                                }
                            }
                        }
                        
                        Chart {
                            ForEach(splitHistory.coefList, id: \.self) { coef in
                                LineMark(
                                    x: .value("Index", coef),
                                    y: .value("Coef", coef)
                                )
                            }
                        }.padding(.all, 16)
                        .background(.white)
                            .cornerRadius(10)
                    }
                    
                }.padding(.horizontal, 20)
            }
        }
    }
}

struct CardioView: View {
    let distance: String
    let duration: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "arrow.right")
                .resizable()
                .frame(width: 10, height: 10)
            VStack(spacing: 12) {
                Group {
                    Text("Distance: ")
                        .foregroundColor(CustomColors.backgroundDark)
                    
                    + Text(distance)
                        .bold()
                        .foregroundColor(CustomColors.buttonDark)
                } .font(.system(size: 14))
                
                Group {
                    Text("Duration: ")
                        .foregroundColor(CustomColors.backgroundDark)
                    
                    + Text(duration)
                        .bold()
                        .foregroundColor(CustomColors.buttonDark)
                } .font(.system(size: 14))
            }
        }
    }
}

struct WeightView: View {
    let nbOfReps: String
    let weight: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "arrow.right")
                .resizable()
                .frame(width: 10, height: 10)
            VStack(spacing: 12) {
                Group {
                    Text("Number of repetitions: ")
                        .foregroundColor(CustomColors.backgroundDark)
                    
                    + Text(nbOfReps)
                        .bold()
                        .foregroundColor(CustomColors.buttonDark)
                } .font(.system(size: 14))
                
                Group {
                    Text("Weight: ")
                        .foregroundColor(CustomColors.backgroundDark)
                    
                    + Text(weight)
                        .bold()
                        .foregroundColor(CustomColors.buttonDark)
                } .font(.system(size: 14))
            }
        }
    }
}

struct CalitenicsView: View {
    let reps: String
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "arrow.right")
                .resizable()
                .frame(width: 10, height: 10)
            VStack(spacing: 0) {
                Group {
                    Text("Number of repetitions: ")
                        .foregroundColor(CustomColors.backgroundDark)
                    
                    + Text(reps)
                        .bold()
                        .foregroundColor(CustomColors.buttonDark)
                } .font(.system(size: 14))
            }
        }
    }
}
