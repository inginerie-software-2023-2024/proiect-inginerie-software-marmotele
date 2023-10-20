//
//  UserService.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation
import FirebaseAuth
import Firebase
import Combine

class UserService: ObservableObject {
    lazy var isLoggedIn: Bool = user.value != nil
    private var userDefaultsService = UserDefaultsService.shared
    static let shared = UserService()
    var user = CurrentValueSubject<User?, Never>(Auth.auth().currentUser)
    
    private init() { }

    func login(email: String, password: String) -> Future<User, Error> {
        Future { promise in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    promise(.failure(error))
                } else if let user = result?.user {
                    self.user.value = user
                    promise(.success(user))
                }
            }
        }
    }
    
    func logOut() -> Future<User?, Error> {
        Future { promise in
            do {
                try Auth.auth().signOut()
                self.user.value = nil
                promise(.success(self.user.value))
            } catch let error {
                promise(.failure(error))
            }
        }
    }
}
