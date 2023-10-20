//
//  AddProgressScreen.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//


import SwiftUI

struct AddProgressScreen: View {
    @StateObject var viewModel = AddProgressViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            DatePicker(selection: $viewModel.selectedDate, in: Date.now..., displayedComponents: .date) {
                Label("Select a date", systemImage: "calendar")
                    .foregroundColor(.white)
                    .font(Font.system(size: 16))
            }
            
          //  switch viewModel.workoutType.value {
           // case .weightLifting:
                VStack(alignment: .leading, spacing: 0) {
                    Text("Exercise 1:")
                        .font(Font.system(size: 14))
                        .foregroundColor(.black)
                    
                    Text("Skullcrushers")
                        .font(Font.system(size: 14))
                        .foregroundColor(.black)
                    
                    TextField("Number of sets:", text: $viewModel.nbOfSets)
                        .textFieldStyle(.plain)
                    
                    Text("Set 1:")
                        .font(Font.system(size: 14))
                        .foregroundColor(.black)
                    
                    TextField("Number of reps:", text: $viewModel.nbOfReps)
                        .textFieldStyle(.plain)
                    
                    TextField("Weight:", text: $viewModel.weight)
                        .textFieldStyle(.plain)
                    
                    Text("Set 2:")
                        .font(Font.system(size: 14))
                        .foregroundColor(.black)
                    
                    TextField("Number of reps:", text: $viewModel.nbOfReps)
                        .textFieldStyle(.plain)
                    
                    TextField("Weight:", text: $viewModel.weight)
                        .textFieldStyle(.plain)
                }.padding(.all, 8)
                    .border(Color.black, width: 1)
                    .padding(.horizontal, 12)
                
           // case .calistenics:
                VStack(alignment: .leading, spacing: 0) {
                    Text("Exercise 1:")
                        .font(Font.system(size: 14))
                        .foregroundColor(.black)
                    
                    Text("Skullcrushers")
                        .font(Font.system(size: 14))
                        .foregroundColor(.black)
                    
                    TextField("Number of sets:", text: $viewModel.nbOfSets)
                        .textFieldStyle(.plain)
                    
                    Text("Set 1:")
                        .font(Font.system(size: 14))
                        .foregroundColor(.black)
                    
                    TextField("Number of reps:", text: $viewModel.nbOfReps)
                        .textFieldStyle(.plain)
                }.padding(.all, 8)
                    .border(Color.black, width: 1)
                    .padding(.horizontal, 12)
                
           // case .cardio:
                VStack(alignment: .leading, spacing: 0) {
                    Text("Exercise 1:")
                        .font(Font.system(size: 14))
                        .foregroundColor(.black)
                    
                    Text("Skullcrushers")
                        .font(Font.system(size: 14))
                        .foregroundColor(.black)
                    
                    TextField("Number of sets:", text: $viewModel.nbOfSets)
                        .textFieldStyle(.plain)
                    
                    Text("Set 1:")
                        .font(Font.system(size: 14))
                        .foregroundColor(.black)
                    
                    TextField("Distance:", text: $viewModel.distance)
                        .textFieldStyle(.plain)
                    
                    TextField("Duration:", text: $viewModel.duration)
                        .textFieldStyle(.plain)
                }.padding(.all, 8)
                    .border(Color.black, width: 1)
                    .padding(.horizontal, 12)
           // }
        }
    }
}
