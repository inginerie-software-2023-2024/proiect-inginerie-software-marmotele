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
    @State private var showModal = false
    
    var body: some View {
        switch viewModel.splitDetailsState {
        case .failure(_):
            ModalChooseOptionView(title: "Oops",
                                              description: "An error has occured. Please try again later!",
                                              topButtonText: "Retry") {
                navigation.dismissModal(animated: true, completion: nil)
                navigation.pop(animated: true)
            }
        case .loading:
            ZStack {
                LinearGradient(gradient: Gradient(colors: [CustomColors.background, CustomColors.backgroundDark]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                LoaderView()
            }
        case .value(let splitDetails):
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
                        
                        Text(splitDetails.splitName)
                            .font(Font.system(size: 24))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                    }.padding(.vertical, 16)
                    
                    Text(splitDetails.description)
                        .font(Font.system(size: 16))
                        .foregroundColor(CustomColors.buttonDark)
                        .padding(.bottom, 12)
                    
                    Rectangle()
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(CustomColors.button)
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(splitDetails.workouts, id: \.self) { workout in
                            WorkoutCardView(title: workout.workoutName) {
                                self.showModal.toggle()
                                let vm = SeeProgressViewModel(workout: workout,
                                                              splitId: viewModel.splitId,
                                                              userId: splitDetails.iduser)
                                navigation.presentModal(SeeProgressScreen(showModal: $showModal,
                                                                          viewModel: vm).asDestination(),
                                                        animated: true,
                                                        completion: nil,
                                                        controllerConfig: nil)
                            }
                        }
                    }.padding(.vertical, 20)
                }.padding(.horizontal, 20)
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
                .foregroundColor(.white)
            
            Spacer()
            
            Button {
                addProgressHandler()
            } label: {
                Image(systemName: "chevron.down")
                    .resizable()
                    .frame(width: 12, height: 8)
                    .foregroundColor(CustomColors.button)
            }
        }.padding(.all, 16)
            .border(CustomColors.buttonDark, width: 1)
    }
}
