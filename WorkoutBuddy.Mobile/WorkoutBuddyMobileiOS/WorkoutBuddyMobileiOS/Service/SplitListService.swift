//
//  SplitListService.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 28.11.2023.
//

import Foundation
import Combine

class SplitListService: BaseViewModel {
    private var splitsAPI = SplitListAPI()
    static let shared = SplitListService()
    
    private override init() { }
    
    func getListOfSplits(token: String) -> Future<[MyCollection], Error> {
//        Future { promise in
            self.splitsAPI.getListOfSplits(token: token)
//        }
    }
}


