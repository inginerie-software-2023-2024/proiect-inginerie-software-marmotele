//
//  AddProgressViewModel.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation
import Combine

enum WorkoutType {
    case cardio
    case calistenics
    case weightLifting
}

enum AddProgressCompletion {
    case addProgress
    case failure(Error)
}

class AddProgressViewModel: BaseViewModel {
    @Published var workout: Workout
    @Published var splitId: String
    @Published var selectedDate = Date()
    @Published var nbOfSets: String = ""
    @Published var nbOfReps: String = ""
    @Published var weight: String = ""
    @Published var distance: String = ""
    @Published var duration: String = ""
    @Published var user: User?
    @Published var errorMessage: String = ""
    @Published var userId: String
    var progress: AddProgress?
    
    let addProgressCompletion = PassthroughSubject<AddProgressCompletion, Never>()
    var userService = UserService.shared
    var addProgressService = AddProgressService.shared
    
    let workoutType = CurrentValueSubject<WorkoutType, Never>(.calistenics)
    
    init(workout: Workout, splitId: String, userId: String) {
        self.workout = workout
        self.splitId = splitId
        self.userId = userId
    }
    
    func addProgress() {
        guard let user = userService.user.value else { return }
        addProgressService.addProgress(splitId: splitId,
                                       date: selectedDate,
                                       exercises: [Exercise(setsNo: Int(nbOfSets),
                                                            exerciseId: splitId,
                                                            exerciseName: workout.workoutName,
                                                            exerciseType: 0,
                                                            sets: [SetExercise(reps: Int(nbOfReps),
                                                                               weight: Double(weight),
                                                                               duration: Int(duration),
                                                                               distance: Double(distance))])],
                                       userId: userId,
                                       workoutId: workout.workoutId,
                                       token: user.token)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    self.addProgressCompletion.send(.failure(error))
                case .finished:
                    break
                }
            } receiveValue: { [weak self] user in
                guard let self else { return }
                self.addProgressCompletion.send(.addProgress)
            }
            .store(in: &bag)
    }
    
    func initializeProgress() {
//        if let user = self.user {
//            self.progress = AddProgress(userId: user.token,
//                                        workoutId: workout.workoutId,
//                                        date: selectedDate,
//                                        Exercises: [
//                                            Exercise(exerciseName: workout.workoutName,
//                                                     nbSets: Int(nbOfSets),
//                                                     exerciseType: 1,
//                                                     sets:
//                                                        [SetExercise(reps: Int(nbOfReps),
//                                                             weight: Double(weight),
//                                                             duration: Int(duration),
//                                                             distance: Double(distance)),
//                                                         SetExercise(reps: Int(nbOfReps),
//                                                              weight: Double(weight),
//                                                              duration: Int(duration),
//                                                              distance: Double(distance))]
//                                                    ),
//                                            Exercise(exerciseName: workout.workoutName,
//                                                 nbSets: Int(nbOfSets),
//                                                 exerciseType: 2,
//                                                 sets:
//                                                    [SetExercise(reps: Int(nbOfReps),
//                                                         weight: Double(weight),
//                                                         duration: Int(duration),
//                                                         distance: Double(distance)),
//                                                     SetExercise(reps: Int(nbOfReps),
//                                                          weight: Double(weight),
//                                                          duration: Int(duration),
//                                                         distance: Double(distance)),
//                                                     SetExercise(reps: Int(nbOfReps),
//                                                          weight: Double(weight),
//                                                          duration: Int(duration),
//                                                          distance: Double(distance))]
//                                                ),
//                                            Exercise(exerciseName: workout.workoutName,
//                                                 nbSets: Int(nbOfSets),
//                                                 exerciseType: 3,
//                                                 sets:
//                                                    [SetExercise(reps: Int(nbOfReps),
//                                                         weight: Double(weight),
//                                                         duration: Int(duration),
//                                                         distance: Double(distance))]
//                                                )])
//        }
    }
}
