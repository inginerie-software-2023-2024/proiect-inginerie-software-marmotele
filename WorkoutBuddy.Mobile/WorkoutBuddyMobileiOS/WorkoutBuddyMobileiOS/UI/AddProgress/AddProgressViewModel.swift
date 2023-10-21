//
//  AddProgressViewModel.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation
import Combine
import FirebaseAuth

enum WorkoutType {
    case cardio
    case calistenics
    case weightLifting
}

class AddProgressViewModel: BaseViewModel {
    @Published var workoutId: UUID
    @Published var workoutName: String
    @Published var selectedDate = Date.now
    @Published var nbOfSets: String = ""
    @Published var nbOfReps: String = ""
    @Published var weight: String = ""
    @Published var distance: String = ""
    @Published var duration: String = ""
    @Published var user: User?
    var progress: AddProgress?
    var userService = UserService.shared
    
    let workoutType = CurrentValueSubject<WorkoutType, Never>(.calistenics)
    
    init(workoutId: UUID, workoutName: String) {
        self.workoutId = workoutId
        self.workoutName = workoutName
        super.init()
        userService.user
            .sink { _ in
                
            } receiveValue: { [weak self] user in
                guard let self = self else { return }
                self.user = user
                self.initializeProgress()
            } .store(in: &bag)
    }
    
    func initializeProgress() {
        if let user {
            self.progress = AddProgress(userId: UUID(uuidString: user.uid) ?? UUID(),
                                        workoutId: workoutId,
                                        date: selectedDate,
                                        Exercises: [
                                            Exercise(exerciseName: workoutName,
                                                     nbSets: Int(nbOfSets),
                                                     exerciseType: 1,
                                                     sets:
                                                        [SetExercise(reps: Int(nbOfReps),
                                                             weight: Double(weight),
                                                             duration: Int(duration),
                                                             distance: Double(distance)),
                                                         SetExercise(reps: Int(nbOfReps),
                                                              weight: Double(weight),
                                                              duration: Int(duration),
                                                              distance: Double(distance))]
                                                    ),
                                        Exercise(exerciseName: workoutName,
                                                 nbSets: Int(nbOfSets),
                                                 exerciseType: 2,
                                                 sets:
                                                    [SetExercise(reps: Int(nbOfReps),
                                                         weight: Double(weight),
                                                         duration: Int(duration),
                                                         distance: Double(distance)),
                                                     SetExercise(reps: Int(nbOfReps),
                                                          weight: Double(weight),
                                                          duration: Int(duration),
                                                         distance: Double(distance)),
                                                     SetExercise(reps: Int(nbOfReps),
                                                          weight: Double(weight),
                                                          duration: Int(duration),
                                                          distance: Double(distance))]
                                                ),
                                        Exercise(exerciseName: workoutName,
                                                 nbSets: Int(nbOfSets),
                                                 exerciseType: 3,
                                                 sets:
                                                    [SetExercise(reps: Int(nbOfReps),
                                                         weight: Double(weight),
                                                         duration: Int(duration),
                                                         distance: Double(distance))]
                                                )])
        }
    }
}
