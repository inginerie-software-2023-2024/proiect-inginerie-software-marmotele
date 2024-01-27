//
//  AddProgressService.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 30.11.2023.
//

import Foundation
import Combine

class AddProgressService: BaseViewModel {
    private var addProgressAPI = AddProgressAPI()
    static let shared = AddProgressService()
    
    private override init() { }
    
    func getProgress(id: String, token: String) -> Future<AddProgress, Error> {
        self.addProgressAPI.getProgress(id: id, token: token)
    }
    
    func addProgress(splitId: String,
                     date: String,
                     exercises: [Exercise],
                     userId: String,
                     workoutId: String,
                     token: String) -> Future<AddProgressBody, Error> {
        self.addProgressAPI.addProgress(splitId: splitId,
                                        date: date,
                                        exercises: exercises,
                                        userId: userId,
                                        workoutId: workoutId,
                                        token: token)
    }
}
