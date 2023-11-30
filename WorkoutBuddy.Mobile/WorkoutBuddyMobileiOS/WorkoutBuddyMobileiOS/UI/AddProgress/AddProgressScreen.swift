//
//  AddProgressScreen.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//


import SwiftUI

struct AddProgressScreen: View {
    @StateObject var viewModel: AddProgressViewModel
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
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
                    
                    Text("Add new progress")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                    .padding(.vertical, 20)
                
                DatePicker(selection: $viewModel.selectedDate, in: Date.now..., displayedComponents: .date) {
                    Label("Select a date", systemImage: "calendar")
                        .foregroundColor(.white)
                        .font(Font.system(size: 16))
                }.padding(.bottom, 20)
                
                switch viewModel.workoutType.value {
                case .weightLifting:
                    WeightLiftingForm(nbOfExercises: 3,
                                      workoutName: viewModel.workout.workoutName,
                                      nbOfSets: $viewModel.nbOfSets,
                                      nbOfReps: $viewModel.nbOfReps,
                                      weight: $viewModel.weight)
                    
                case .calistenics:
                    CalistenicsForm(nbOfExercises: 3,
                                    workoutName: viewModel.workout.workoutName,
                                    nbOfSets: $viewModel.nbOfSets,
                                    nbOfReps: $viewModel.nbOfReps)
                    
                case .cardio:
                    CardioForm(nbOfExercises: 3,
                               workoutName: viewModel.workout.workoutName,
                               distance: $viewModel.distance,
                               duration: $viewModel.duration)
                }
                
                Spacer()
                
                Button {
                    viewModel.addProgress()
                } label: {
                    Text("Save progress")
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(CustomColors.myNude)
                        .cornerRadius(4)
                        .foregroundColor(.black)
                        .padding(.bottom, 20)
                }.onReceive(viewModel.addProgressCompletion) { addProgressCompletion in
                    switch addProgressCompletion {
                    case .failure(let error):
                        viewModel.errorMessage = error.localizedDescription
                        print("Login failed: \(error)")
                    case .addProgress:
                        navigation.pop(animated: true)
                    }
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
        Text(workoutName)
            .font(Font.system(size: 24))
            .foregroundColor(CustomColors.myNude)
            .padding(.bottom, 16)
        
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0..<nbOfExercises) { exercise in
                    Text("Exercise \(exercise+1):")
                        .underline()
                        .font(Font.system(size: 20))
                        .foregroundColor(.white)
                        .padding(.bottom, 16)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Distance:")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                        
                        TextField("", text: $distance)
                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(.white).cornerRadius(10)
                    }.padding(.bottom, 12)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Duration:")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                        
                        TextField("", text: $duration)
                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(.white).cornerRadius(10)
                    }.padding(.bottom, 20)
                }
            }
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
        Text(workoutName)
            .font(Font.system(size: 24))
            .foregroundColor(CustomColors.myNude)
            .padding(.bottom, 16)
        
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0..<nbOfExercises) { exercise in
                    Text("Exercise \(exercise+1):")
                        .underline()
                        .font(Font.system(size: 20))
                        .foregroundColor(.white)
                        .padding(.bottom, 16)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Number of sets:")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                        
                        TextField("", text: $nbOfSets)
                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(.white).cornerRadius(10)
                    }.padding(.bottom, 12)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Number of reps:")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                        
                        TextField("", text: $nbOfReps)
                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(.white).cornerRadius(10)
                    }.padding(.bottom, 12)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Weight:")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                        
                        TextField("", text: $weight)
                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(.white).cornerRadius(10)
                    }.padding(.bottom, 20)
                }
            }
        }
    }
}

struct CalistenicsForm: View {
    var nbOfExercises: Int
    var workoutName: String
    @Binding var nbOfSets: String
    @Binding var nbOfReps: String
    
    var body: some View {
        Text(workoutName)
            .font(Font.system(size: 24))
            .foregroundColor(CustomColors.myNude)
            .padding(.bottom, 16)
        
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0..<nbOfExercises) { exercise in
                    Text("Exercise \(exercise+1):")
                        .underline()
                        .font(Font.system(size: 20))
                        .foregroundColor(.white)
                        .padding(.bottom, 16)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Number of sets:")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                        
                        TextField("", text: $nbOfSets)
                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(.white).cornerRadius(10)
                    }.padding(.bottom, 12)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Number of reps:")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                        
                        TextField("", text: $nbOfReps)
                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(.white).cornerRadius(10)
                    }.padding(.bottom, 20)
                }
            }
        }
    }
}

