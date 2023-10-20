//
//  HomeViewModel.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//


import Foundation
import Combine

enum LogOutCompletion {
    case logout
    case failure(Error)
}

class HomeViewModel: BaseViewModel {
    @Published var errorMessage: String = ""
    @Published var workouts: [Workout] = [Workout(title: "PPL", description: "Push pull legs, best split"),
                                          Workout(title: "PPL", description: "Push pull legs, best split"),
                                          Workout(title: "PPL", description: "Push pull legs, best split"),
                                          Workout(title: "PPL", description: "Push pull legs, best split")
    ]
    
    var userService = UserService.shared
    let eventSubject = PassthroughSubject<LogOutCompletion, Never>()
     
    func logOut() {
        userService.logOut()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    self.eventSubject.send(.failure(error))
                case .finished:
                    break
                }
            } receiveValue: { [weak self] user in
                guard let self else { return }
                self.eventSubject.send(.logout)
            }
            .store(in: &bag)
    }
}
