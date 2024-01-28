//
//  LoginViewModel.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation
import Combine

enum LoginCompletion {
    case login
    case failure(Error)
}

class LoginViewModel: BaseViewModel {
    @Published var email = ""
    @Published var password = ""
    
    let loginCompletion = PassthroughSubject<LoginCompletion, Never>()
    var userService = UserService.shared
    
    func login() {
        userService.login(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    self.loginCompletion.send(.failure(error))
                case .finished:
                    break
                }
            } receiveValue: { [weak self] user in
                guard let self else { return }
                self.loginCompletion.send(.login)
            }
            .store(in: &bag)
    }
}
