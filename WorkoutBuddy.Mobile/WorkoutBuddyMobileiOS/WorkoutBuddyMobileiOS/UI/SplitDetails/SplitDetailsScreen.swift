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
        VStack(alignment: .leading, spacing: 0) {
            Button {
                navigation.pop(animated: true)
            } label: {
                Image(systemName: "arrowshape.backward")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.black)
                    .padding(.leading, 12)
            }
            
            Text(viewModel.workout.title)
                .font(Font.system(size: 24))
                .foregroundColor(Color.black)
                .padding(.bottom, 4)
                .padding(.top, 12)
                .padding(.horizontal, 12)
            
            Text(viewModel.workout.description)
                .font(Font.system(size: 16))
                .foregroundColor(Color.black)
                .padding(.horizontal, 12)
            
            Rectangle()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.gray)
            
            ScrollView(showsIndicators: false) {
                ForEach(0..<3) { _ in
                    WorkoutCardView(title: viewModel.workout.title) {
                        navigation.push(AddProgressScreen().asDestination(), animated: true)
                    }
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
                .foregroundColor(Color.black)
            
            Spacer()
            
            Button {
                addProgressHandler()
            } label: {
                Text("+Add progress")
                    .font(Font.system(size: 16))
                    .foregroundColor(.white)
                    .padding(.all, 8)
                    .background(Color.black)
            }
        }.padding(.all, 8)
            .border(Color.black, width: 1)
        .padding(.horizontal, 12)
    }
}
