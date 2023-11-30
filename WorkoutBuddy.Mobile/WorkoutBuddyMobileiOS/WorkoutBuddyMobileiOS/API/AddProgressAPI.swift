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
            var urlComponents = URLComponents(string: "https:/127e-86-124-16-55.ngrok-free.app/UserSplit/AddProgress")
            
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
                     date: Date,
                     exercises: [Exercise],
                     userId: String,
                     workoutId: String,
                     token: String) -> Future<AddProgress, Error> {
        Future { promise in
            var urlComponents = URLComponents(string: "https:/127e-86-124-16-55.ngrok-free.app/UserSplit/AddProgress")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            urlRequest.httpMethod = "POST"
            
            let body = AddProgress(splitId: splitId, date: date, exercises: exercises, userId: userId, workoutId: workoutId)
            
            do {
                urlRequest.httpBody = try JSONEncoder().encode(body)
            } catch {
                
            }
            
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
}
