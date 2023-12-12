//
//  SplitHistoryViewModel.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 10.12.2023.
//

import Foundation

enum SeeHistoryState {
    case loading
    case failure(Error)
    case value(History)
}

class SplitHistoryViewModel: BaseViewModel {
    var userService = UserService.shared
    var splitHistoryService = SplitHistoryService.shared
    
    @Published var workout: Workout
    @Published var seeHistoryState = SeeHistoryState.loading
    @Published var errorMessage: String = ""
    
    init(workout: Workout) {
        self.workout = workout
        super.init()
        self.getSplitHistory(id: workout.workoutId)
    }
    
    func getSplitHistory(id: String) {
        guard let user = userService.user.value else { return }
        seeHistoryState = .loading
        splitHistoryService.getSplitHistory(id: id, token: user.token)
             .receive(on: DispatchQueue.main)
             .sink { [weak self] completion in
                 guard let self = self else { return }
                 switch completion {
                 case .failure(let error):
                     self.errorMessage = error.localizedDescription
                     self.seeHistoryState = .failure(error)
                     print("Error: \(error)")
                 case .finished:
                     break
                 }
             } receiveValue: { [weak self] history in
                 guard let self = self else { return }
                 self.seeHistoryState = .value(history)
                 print("Splits fetched: \(history)")
             }.store(in: &bag)
     }
}
