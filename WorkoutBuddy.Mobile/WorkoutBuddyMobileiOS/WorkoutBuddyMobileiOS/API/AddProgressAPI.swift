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
            var urlComponents = URLComponents(string: "https://139e-86-124-16-55.ngrok-free.app/UserSplit/AddProgress")
            
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
            var urlComponents = URLComponents(string: "https://139e-86-124-16-55.ngrok-free.app/UserSplit/AddProgress")

            // Create the body object
            let sets = [SetExerciseBody(Reps: 3, Weight: 3, Duration: 3, Distance: 3)]
            let ex = [ExerciseBody(ExerciseId: "28b5ddd1-8f32-43fe-accc-1898475e3abc",
                                   ExerciseName: "Dip", SetsNo: 3, ExerciseType: 3, Sets: sets)]
            let body = AddProgressBody(SplitId: splitId,
                                       UserId: userId,
                                       WorkoutId: workoutId,
                                       Date: date,
                                       Exercises: ex)
            
            do {
                // Serialize the body object into a JSON string
                let bodyData = try JSONEncoder().encode(body)
                let bodyString = String(data: bodyData, encoding: .utf8)
                
                // Add the JSON string as a single query parameter
                urlComponents?.queryItems = [URLQueryItem(name: "body", value: bodyString)]
            } catch {
                // Handle error
            }
            
            guard let url = urlComponents?.url else {
                // Handle error
                return
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            urlRequest.httpMethod = "POST"
            
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
