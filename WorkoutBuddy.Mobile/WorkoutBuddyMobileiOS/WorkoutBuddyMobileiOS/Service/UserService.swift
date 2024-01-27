//
//  UserService.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation
import Combine

class UserService: BaseViewModel {
    @Published var isLoggedIn: Bool
    private var userDefaultsService = UserDefaultsService.shared
    static let shared = UserService()
    var user = CurrentValueSubject<User?, Never>(nil)
   
    private var userAPI = UserAPI()
    
    private override init() {
        self.isLoggedIn = user.value != nil
    }
    
    func login(email: String, password: String) -> Future<User, Error> {
        Future { promise in
            self.userAPI.login(email: email, password: password)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(error))
                    case .finished:
                        break
                    }
                }, receiveValue: { user in
                    self.user.value = user
                    self.isLoggedIn = true
                    promise(.success(user))
                })
                .store(in: &self.bag)
        }
    }
    
    func logOut() -> Future<User?, Error> {
        Future { promise in
            self.user.value = nil
            self.isLoggedIn = false
            promise(.success(self.user.value))
        }
    }
}

