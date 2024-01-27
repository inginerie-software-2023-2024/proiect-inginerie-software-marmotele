//
//  SplitHistoryService.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 10.12.2023.
//

import Foundation
import Combine

class SplitHistoryService: BaseViewModel {
    private var splitHistoryAPI = SplitHistoryAPI()
    static let shared = SplitHistoryService()
    
    private override init() { }
    
    func getSplitHistory(id: String, token: String) -> Future<History, Error> {
        self.splitHistoryAPI.getSplitHistory(id: id, token: token)
    }
}
