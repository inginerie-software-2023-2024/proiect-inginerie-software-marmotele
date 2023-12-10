//
//  AddProgressScreen.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//


import SwiftUI

struct AddProgressScreen: View {
    @StateObject var viewModel: AddProgressViewModel
    @State private var showingAlert = false
    @State var setsNo: String = ""
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [CustomColors.background, CustomColors.backgroundDark]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
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
                    
                    Text("Add new progress")
                        .font(Font.system(size: 24))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                }.padding(.vertical, 16)
                    .padding(.horizontal, 20)
                
                DatePicker(selection: $viewModel.selectedDate, in: Date.now..., displayedComponents: .date) {
                    Label("Select a date", systemImage: "calendar")
                        .foregroundColor(.white)
                        .font(Font.system(size: 16))
                }.padding(.bottom, 20)
                
                ForEach(0..<viewModel.exercises.count, id: \.self) { index in
                    Text(viewModel.exercises[index].exerciseName)
                        .font(Font.system(size: 24))
                        .foregroundColor(CustomColors.button)
                        .padding(.bottom, 16)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Number of sets:")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                            
                            TextField("", text: $setsNo)
                                .onChange(of: setsNo) { newValue in
                                    if let indexSets = viewModel.progressNew.firstIndex(where: { $0.exerciseId == viewModel.exercises[index].exerciseId }) {
                                        viewModel.progressNew[indexSets].setsNo = Int(newValue)
                                    }
                                    let _ = print(setsNo)
                                }
                                .foregroundColor(.black)
                                .textFieldStyle(.plain)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                                .background(.white).cornerRadius(10)
                                .padding(.bottom, 12)
                            
                            Button {
                               if let indexSets = viewModel.progressNew.firstIndex(where: { $0.exerciseId == viewModel.exercises[index].exerciseId }) {
                                   switch viewModel.exercises[index].exerciseType {
                                   case 1:
                                       let modal = CardioForm(exercise: viewModel.exercises[index],
                                                         index: viewModel.progressNew[indexSets].setsNo,
                                                         progressNew: $viewModel.progressNew).asDestination()
                                       navigation.presentModal(modal,
                                                              animated: true,
                                                              completion: nil,
                                                              controllerConfig: nil)
                                   case 2:
                                      let modal = WeightLiftingForm(exercise: viewModel.exercises[index],
                                                               index: viewModel.progressNew[indexSets].setsNo,
                                                               progressNew: $viewModel.progressNew).asDestination()
                                       navigation.presentModal(modal,
                                                              animated: true,
                                                              completion: nil,
                                                              controllerConfig: nil)
                                   case 3:
                                      let modal = CalistenicsForm(exercise: viewModel.exercises[index],
                                                             index: viewModel.progressNew[indexSets].setsNo,
                                                             progressNew: $viewModel.progressNew).asDestination()
                                       navigation.presentModal(modal,
                                                              animated: true,
                                                              completion: nil,
                                                              controllerConfig: nil)
                                   default:
                                       break
                                   }
                               }
                            } label: {
                               Text("Add new progress")
                                    .frame(height: 32)
                                    .frame(maxWidth: .infinity)
                                    .background(CustomColors.buttonDark)
                                    .cornerRadius(4)
                                    .foregroundColor(CustomColors.backgroundDark)
                                    .padding(.bottom, 20)
                            }

                        }
                    }
                }
                
                Spacer()
                
                Button {
                    viewModel.addProgress()
                } label: {
                    Text("Save progress")
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(CustomColors.button)
                        .cornerRadius(4)
                        .foregroundColor(CustomColors.backgroundDark)
                        .padding(.bottom, 20)
                }.onReceive(viewModel.addProgressCompletion) { addProgressCompletion in
                    switch addProgressCompletion {
                    case .failure(let error):
                        viewModel.errorMessage = error.localizedDescription
                        self.showingAlert = true
                        print("Login failed: \(error)")
                    case .addProgress:
                        navigation.pop(animated: true)
                    }
                }
            }.padding(.horizontal, 20)
        }.alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Error"),
                message: Text("There was an error, please try again"),
                dismissButton: .default(Text("Retry")) {
                    self.showingAlert = false
                }
            )
        }
    }
}

struct CardioForm: View {
    var exercise: Exercise
    var index: Int?
    @Binding var progressNew: [Exercise]
    @State var distances: [String]
    @State var durations: [String]
    
    init(exercise: Exercise, index: Int?, progressNew: Binding<[Exercise]>) {
          self.exercise = exercise
          self.index = index
          self._progressNew = progressNew
          self.distances = Array(repeating: "", count: index ?? 0)
          self.durations = Array(repeating: "", count: index ?? 0)
      }
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            if let index = index {
                ForEach(0..<index, id: \.self) { setIndex in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Set \(setIndex + 1):")
                            .underline()
                            .font(Font.system(size: 20))
                            .foregroundColor(.white)
                            .padding(.bottom, 16)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Distance:")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                            
                            TextField("", text: $distances[setIndex])
                              .onChange(of: distances[setIndex]) { newValue in
                                  if setIndex < distances.count {
                                      distances[setIndex] = newValue
                                      if let index = progressNew.firstIndex(where: { $0.exerciseId == exercise.exerciseId }) {
                                          progressNew[index].sets?[setIndex].reps = Int(newValue)
                                      }
                                  }
                              }
                                .foregroundColor(CustomColors.backgroundDark)
                                .textFieldStyle(.plain)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                                .background(.white).cornerRadius(10)
                        }.padding(.bottom, 12)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Duration:")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                            
                            TextField("", text: $durations[setIndex])
                              .onChange(of: durations[setIndex]) { newValue in
                                  if setIndex < durations.count {
                                      durations[setIndex] = newValue
                                      if let index = progressNew.firstIndex(where: { $0.exerciseId == exercise.exerciseId }) {
                                          progressNew[index].sets?[setIndex].reps = Int(newValue)
                                      }
                                  }
                              }
                                .foregroundColor(CustomColors.backgroundDark)
                                .textFieldStyle(.plain)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                                .background(.white).cornerRadius(10)
                        }.padding(.bottom, 20)
                    }
                }
            }
        }.padding(.all, 20)
            .background(CustomColors.backgroundDark)
            .cornerRadius(20)
            .padding(.horizontal, 20)
    }
}

struct WeightLiftingForm: View {
    var exercise: Exercise
    var index: Int?
    @Binding var progressNew: [Exercise]
    @State var nbOfReps: [String]
    @State var weight: [String]
    
    init(exercise: Exercise, index: Int?, progressNew: Binding<[Exercise]>) {
           self.exercise = exercise
           self.index = index
           self._progressNew = progressNew
           self.nbOfReps = Array(repeating: "", count: index ?? 0)
           self.weight = Array(repeating: "", count: index ?? 0)
       }
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            if let index = index {
                ForEach(0..<index, id: \.self) { setIndex in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Set \(setIndex + 1):")
                            .underline()
                            .font(Font.system(size: 20))
                            .foregroundColor(.white)
                            .padding(.bottom, 16)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Number of reps:")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                            
                            TextField("", text: $nbOfReps[setIndex])
                              .onChange(of: nbOfReps[setIndex]) { newValue in
                                  if setIndex < nbOfReps.count {
                                      nbOfReps[setIndex] = newValue
                                      if let index = progressNew.firstIndex(where: { $0.exerciseId == exercise.exerciseId }) {
                                          progressNew[index].sets?[setIndex].reps = Int(newValue)
                                      }
                                  }
                              }
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
                            
                            TextField("", text: $weight[setIndex])
                              .onChange(of: weight[setIndex]) { newValue in
                                  if setIndex < weight.count {
                                      weight[setIndex] = newValue
                                      if let index = progressNew.firstIndex(where: { $0.exerciseId == exercise.exerciseId }) {
                                          progressNew[index].sets?[setIndex].reps = Int(newValue)
                                      }
                                  }
                              }
                                .foregroundColor(.black)
                                .textFieldStyle(.plain)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                                .background(.white).cornerRadius(10)
                        }.padding(.bottom, 20)
                    }
                }
            }
        }.padding(.all, 20)
        .background(CustomColors.backgroundDark)
            .cornerRadius(20)
            .padding(.horizontal, 20)
    }
}


struct CalistenicsForm: View {
    var exercise: Exercise
    var index: Int?
    @Binding var progressNew: [Exercise]
    @State var nbOfReps: [String]
    @State var reps: String = ""
    
    init(exercise: Exercise, index: Int?, progressNew: Binding<[Exercise]>) {
          self.exercise = exercise
          self.index = index
          self._progressNew = progressNew
          self.nbOfReps = Array(repeating: "", count: index ?? 0)
      }
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            if let index = index {
                ForEach(0..<index, id: \.self) { setIndex in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Set \(setIndex + 1):")
                            .underline()
                            .font(Font.system(size: 20))
                            .foregroundColor(.white)
                            .padding(.bottom, 16)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Number of reps:")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                            
                            TextField("", text: $nbOfReps[setIndex])
                                .onChange(of: nbOfReps[setIndex]) { newValue in
                                    if setIndex < nbOfReps.count {
                                        nbOfReps[setIndex] = newValue
                                        if let index = progressNew.firstIndex(where: { $0.exerciseId == exercise.exerciseId }) {
                                            progressNew[index].sets?[setIndex].reps = Int(newValue)
                                            print(progressNew)
                                        }
                                    }
                                }
                                .foregroundColor(.black)
                                .textFieldStyle(.plain)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                                .background(.white).cornerRadius(10)
                        }.padding(.bottom, 12)
                    }
                }
            }
        }.padding(.all, 20)
            .background(CustomColors.backgroundDark)
            .cornerRadius(20)
            .padding(.horizontal, 20)
    }
}


