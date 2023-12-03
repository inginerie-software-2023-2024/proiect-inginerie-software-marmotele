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
    @Published var exercise: Exercise
    var progress: AddProgress?
    
    let addProgressCompletion = PassthroughSubject<AddProgressCompletion, Never>()
    var userService = UserService.shared
    var addProgressService = AddProgressService.shared
    
    let workoutType = CurrentValueSubject<WorkoutType, Never>(.calistenics)
    
    init(workout: Workout, splitId: String, userId: String, exercise: Exercise) {
        self.workout = workout
        self.splitId = splitId
        self.userId = userId
        self.exercise = exercise
    }
    
    func addProgress() {
        guard let user = userService.user.value else { return }
        addProgressService.addProgress(splitId: splitId,
                                       date: selectedDate.description,
                                       exercises: [Exercise(setsNo: Int(nbOfSets),
                                                            exerciseId: exercise.exerciseId,
                                                            exerciseName: exercise.exerciseName,
                                                            exerciseType: exercise.exerciseType,
                                                            sets: [SetExercise(weight: Double(weight), 
                                                                               reps: Int(nbOfReps),
                                                                               distance: Double(distance), 
                                                                               duration: Int(duration))])],
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
}
