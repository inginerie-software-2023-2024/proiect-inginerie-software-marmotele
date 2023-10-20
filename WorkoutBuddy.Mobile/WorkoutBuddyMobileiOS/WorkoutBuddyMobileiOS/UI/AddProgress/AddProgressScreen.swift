//
//  AddProgressScreen.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//


import SwiftUI

struct AddProgressScreen: View {
    @StateObject var viewModel: AddProgressViewModel
    
    var body: some View {
        ZStack {
            CustomColors.background.ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                DatePicker(selection: $viewModel.selectedDate, in: Date.now..., displayedComponents: .date) {
                    Label("Select a date", systemImage: "calendar")
                        .foregroundColor(.white)
                        .font(Font.system(size: 16))
                }
                
                switch viewModel.workoutType.value {
                case .weightLifting:
                    WeightLiftingForm(nbOfExercises: 3,
                                      workoutName: viewModel.workoutName,
                                      nbOfSets: $viewModel.nbOfSets,
                                      nbOfReps: $viewModel.nbOfReps,
                                      weight: $viewModel.weight)
                
                case .calistenics:
                    CalistenicsForm(nbOfExercises: 3,
                                    workoutName: viewModel.workoutName,
                                    nbOfSets: $viewModel.nbOfSets,
                                    nbOfReps: $viewModel.nbOfReps)
                
                case .cardio:
                    CardioForm(nbOfExercises: 3,
                               workoutName: viewModel.workoutName,
                               distance: $viewModel.distance,
                               duration: $viewModel.duration)
                }
            }.padding(.horizontal, 20)
        }
    }
}

struct CardioForm: View {
    var nbOfExercises: Int
    var workoutName: String
    @Binding var distance: String
    @Binding var duration: String
    
    var body: some View {
        ForEach(0..<nbOfExercises) { exercise in
            Text("Exercise \(exercise+1): \(workoutName)")
                .font(Font.system(size: 14))
                .foregroundColor(.black)
            
            TextField("Distance:", text: $distance)
                .textFieldStyle(.plain)
            
            TextField("Duration:", text: $duration)
                .textFieldStyle(.plain)
        }
    }
}

struct WeightLiftingForm: View {
    var nbOfExercises: Int
    var workoutName: String
    @Binding var nbOfSets: String
    @Binding var nbOfReps: String
    @Binding var weight: String
    
    var body: some View {
        ForEach(0..<nbOfExercises) { exercise in
            Text("Exercise \(exercise+1): \(workoutName)")
                .font(Font.system(size: 14))
                .foregroundColor(.black)
            
            TextField("Number of sets:", text: $nbOfSets)
                .textFieldStyle(.plain)
            
            TextField("Number of reps:", text: $nbOfReps)
                .textFieldStyle(.plain)
            
            TextField("Weight:", text: $weight)
                .textFieldStyle(.plain)
        }
    }
}

struct CalistenicsForm: View {
    var nbOfExercises: Int
    var workoutName: String
    @Binding var nbOfSets: String
    @Binding var nbOfReps: String
    
    var body: some View {
        ForEach(0..<nbOfExercises) { exercise in
            Text("Exercise \(exercise+1): \(workoutName)")
                .font(Font.system(size: 14))
                .foregroundColor(.black)
            
            TextField("Number of sets:", text: $nbOfSets)
                .textFieldStyle(.plain)
            
            TextField("Number of reps:", text: $nbOfReps)
                .textFieldStyle(.plain)
        }
    }
}

