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

enum SplitsState {
    case loading
    case failure(Error)
    case value([MyCollection])
}

class HomeViewModel: BaseViewModel {
   @Published var errorMessage: String = ""
    @Published var splitsState = SplitsState.loading
   
   var userService = UserService.shared
   var splitsService = SplitListService.shared
   let eventSubject = PassthroughSubject<LogOutCompletion, Never>()
    
    override init() {
        super.init()
        self.getListOfSplits()
    }
    
   func logOut() {
       userService.logOut()
           .receive(on: DispatchQueue.main)
           .sink { [weak self] completion in
               guard let self = self else { return }
               switch completion {
               case .failure(let error):
                  self.eventSubject.send(.failure(error))
               case .finished:
                  break
               }
           } receiveValue: { [weak self] user in
               guard let self = self else { return }
               self.eventSubject.send(.logout)
           }
           .store(in: &bag)
   }
    
    func getListOfSplits() {
        guard let user = userService.user.value else { return }
        splitsState = .loading
        splitsService.getListOfSplits(token: user.token)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.splitsState = .failure(error)
                    print("Error: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] splits in
                guard let self = self else { return }
                self.splitsState = .value(splits)
                print("Splits fetched: \(splits)")
            }.store(in: &bag)
    }
}

