//
//  AddProgressViewModel.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation
import Combine

enum AddProgressCompletion {
    case addProgress
    case failure(Error)
}

class AddProgressViewModel: BaseViewModel {
    @Published var workout: Workout
    @Published var splitId: String
    @Published var userId: String
    @Published var exercises: [Exercise]
    @Published var selectedDate = Date()
    @Published var errorMessage: String = ""
    
    @Published var progressNew: [Exercise]
    
    let addProgressCompletion = PassthroughSubject<AddProgressCompletion, Never>()
    var userService = UserService.shared
    var addProgressService = AddProgressService.shared
    
    init(workout: Workout, splitId: String, userId: String, exercises: [Exercise]) {
        self.workout = workout
        self.splitId = splitId
        self.userId = userId
        self.exercises = exercises
        self.progressNew = exercises
    }
    
    func addProgress() {
        guard let user = userService.user.value else { return }
        addProgressService.addProgress(splitId: splitId,
                                       date: selectedDate.description,
                                       exercises: progressNew,
                                       userId: userId,
                                       workoutId: workout.workoutId,
                                       token: user.token)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    self.addProgressCompletion.send(.failure(error))
                case .finished:
                    break
                }
            } receiveValue: { [weak self] user in
                guard let self else { return }
                self.addProgressCompletion.send(.addProgress)
            }
            .store(in: &bag)
    }
}
