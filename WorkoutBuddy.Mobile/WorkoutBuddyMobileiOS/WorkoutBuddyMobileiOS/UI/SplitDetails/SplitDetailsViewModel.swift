//
//  SplitDetailsViewModel.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation

enum SplitDetailsState {
    case loading
    case failure(Error)
    case value(Split)
}

class SplitDetailsViewModel: BaseViewModel {
    
    var userService = UserService.shared
    var splitsService = SplitListService.shared
    
    @Published var splitId: String
    @Published var splitDetailsState = SplitDetailsState.loading
    @Published var errorMessage: String = ""
    
    init(splitId: String) {
        self.splitId = splitId
        super.init()
        self.getSplitDetails(id: splitId)
    }
     
    func getSplitDetails(id: String) {
        guard let user = userService.user.value else { return }
         splitDetailsState = .loading
         splitsService.getSplitDetails(id: id, token: user.token)
             .receive(on: DispatchQueue.main)
             .sink { [weak self] completion in
                 guard let self = self else { return }
                 switch completion {
                 case .failure(let error):
                     self.errorMessage = error.localizedDescription
                     self.splitDetailsState = .failure(error)
                     print("Error: \(error)")
                 case .finished:
                     break
                 }
             } receiveValue: { [weak self] splitDetails in
                 guard let self = self else { return }
                 self.splitDetailsState = .value(splitDetails)
                 print("Splits fetched: \(splitDetails)")
             }.store(in: &bag)
     }
}
