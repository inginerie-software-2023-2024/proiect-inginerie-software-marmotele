//
//  SeeProgressViewModel.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 30.11.2023.
//

import Foundation

enum SeeProgressState {
    case loading
    case failure(Error)
    case value(AddProgress)
}

class SeeProgressViewModel: BaseViewModel {
    var userService = UserService.shared
    var addProgressService = AddProgressService.shared
    
    @Published var workout: Workout
    @Published var splitId: String
    @Published var userId: String
    @Published var seeProgressState = SeeProgressState.loading
    @Published var errorMessage: String = ""
    
    init(workout: Workout, splitId: String, userId: String) {
        self.workout = workout
        self.splitId = splitId
        self.userId = userId
        super.init()
        self.getProgress(id: workout.workoutId)
    }
    
    func getProgress(id: String) {
        guard let user = userService.user.value else { return }
        seeProgressState = .loading
        addProgressService.getProgress(id: id, token: user.token)
             .receive(on: DispatchQueue.main)
             .sink { [weak self] completion in
                 guard let self = self else { return }
                 switch completion {
                 case .failure(let error):
                     self.errorMessage = error.localizedDescription
                     self.seeProgressState = .failure(error)
                     print("Error: \(error)")
                 case .finished:
                     break
                 }
             } receiveValue: { [weak self] progress in
                 guard let self = self else { return }
                 self.seeProgressState = .value(progress)
                 print("Splits fetched: \(progress)")
             }.store(in: &bag)
     }
}
