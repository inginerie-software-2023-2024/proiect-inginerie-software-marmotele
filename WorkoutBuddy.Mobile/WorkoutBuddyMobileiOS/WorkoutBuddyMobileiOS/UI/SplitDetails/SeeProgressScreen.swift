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
                        VStack(spacing: 0) {
                            if let exercises = progressDetails.exercises {
                                ForEach(exercises, id: \.self) { exercise in
                                    AddProgressView(name: exercise.exerciseName,
                                                    nbSets: exercise.setsNo)
                                }
                            } else {
                                Text("At the moment you haven't any progress for this workout.")
                                    .font(Font.system(size: 20))
                                    .foregroundColor(CustomColors.buttonDark)
                            }
                            
                            Spacer()
                            
                            Button {
                                navigation.dismissModal(animated: true, completion: nil)
                                let vm = SplitHistoryViewModel(workout: viewModel.workout)
                                navigation.push(SplitHistoryScreen(viewModel: vm).asDestination(), animated: true)
                            } label: {
                                Text("See workout history >")
                                    .font(Font.system(size: 16))
                                    .foregroundColor(.white)
                                    .padding(.all, 12)
                                    .background(CustomColors.buttonDark)
                                    .padding(.vertical, 12)
                            }
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
            }
        }
    }
}
