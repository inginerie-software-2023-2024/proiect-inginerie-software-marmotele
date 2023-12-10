//
//  SplitHistoryScreen.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 10.12.2023.
//

import SwiftUI

struct SplitHistoryScreen: View {
    @StateObject var viewModel: SplitHistoryViewModel
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        switch viewModel.seeHistoryState {
        case .failure(let error):
            Text("\(error.localizedDescription)")
        case .loading:
            ProgressView()
        case .value(let splitHistory):
            Text(splitHistory.firstWorkout.workoutId)
        }
    }
}
