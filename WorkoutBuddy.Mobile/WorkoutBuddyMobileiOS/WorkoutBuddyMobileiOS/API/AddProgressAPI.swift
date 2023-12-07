//
//  AddProgressAPI.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 30.11.2023.
//

import Foundation
import Combine
import SwiftyJSON

class AddProgressAPI {
    func getProgress(id: String, token: String) -> Future<AddProgress, Error> {
        Future { promise in
            var urlComponents = URLComponents(string: "https://0602-82-208-174-16.ngrok-free.app/UserSplit/AddProgress")
            
            urlComponents?.queryItems = [
                URLQueryItem(name: "id", value: "\(id)")
            ]
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            urlRequest.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let progress = try JSONDecoder().decode(AddProgress.self, from: data!)
                        promise(.success(progress))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func addProgress(splitId: String,
                     date: String,
                     exercises: [Exercise],
                     userId: String,
                     workoutId: String,
                     token: String) -> Future<AddProgress, Error> {
        Future { promise in
            let url = URL(string: "https://0602-82-208-174-16.ngrok-free.app/UserSplit/AddProgress")

            let ex = exercises.map { exercise in
                ExerciseBody(ExerciseId: exercise.exerciseId,
                             ExerciseName: exercise.exerciseName,
                             SetsNo: exercise.setsNo,
                             ExerciseType: exercise.exerciseType,
                             Sets: exercise.sets?.map { set in
                                SetExerciseBody(Reps: set.reps, Weight: set.weight, Duration: set.duration, Distance: set.distance)
                             })
            }
            let body = AddProgressBody(SplitId: splitId,
                                       UserId: userId,
                                       WorkoutId: workoutId,
                                       Date: date,
                                       Exercises: ex)

            do {
                let bodyData = try JSONEncoder().encode(body)

                var urlRequest = URLRequest(url: url!)
                urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

                urlRequest.httpMethod = "POST"
                urlRequest.httpBody = bodyData

                let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        do {
                            let progress = try JSONDecoder().decode(AddProgress.self, from: data!)
                            promise(.success(progress))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
                dataTask.resume()
            } catch {
                // Handle error
            }
        }
    }

    
//    func addProgress(splitId: String,
//                     date: String,
//                     exercises: [Exercise],
//                     userId: String,
//                     workoutId: String,
//                     token: String) -> Future<AddProgress, Error> {
//        Future { promise in
//            let urlComponents = URLComponents(string: "https://bd13-86-124-16-55.ngrok-free.app/UserSplit/AddProgress")
//            
//            var urlRequest = URLRequest(url: (urlComponents?.url)!)
//            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
//            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//            
//            urlRequest.httpMethod = "POST"
//            
//            let sets = [SetExerciseBody(reps: 3, weight: 3, duration: 3, distance: 3)]
//            let ex = [ExerciseBody(exerciseId: "28b5ddd1-8f32-43fe-accc-1898475e3abc",
//                                  exerciseName: "Dip", setsNo: 3, exerciseType: 3, sets: sets)]
//            let body = AddProgressBody(splitId: splitId, 
//                                       userId: userId,
//                                       workoutId: workoutId,
//                                       date: date.convertStringToDate(fromString: date) ?? Date(),
//                                       exercises: ex)
//            
//            do {
//                urlRequest.httpBody = try JSONEncoder().encode(body)
//            } catch {
//                
//            }
//            
//            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//                if let error = error {
//                    promise(.failure(error))
//                } else {
//                    do {
//                        let progress = try JSONDecoder().decode(AddProgress.self, from: data!)
//                        promise(.success(progress))
//                    } catch {
//                        promise(.failure(error))
//                    }
//                }
//            }
//            dataTask.resume()
//        }
//    }
}
