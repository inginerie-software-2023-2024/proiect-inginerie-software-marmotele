//
//  SplitListAPI.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 28.11.2023.
//

import Foundation
import Combine
import SwiftyJSON

class SplitListAPI {
    func getListOfSplits(token: String) -> Future<[MyCollection], Error> {
        Future { promise in
            let urlComponents = URLComponents(string: "https://05c8-2a02-2f0a-4103-2b00-b93e-dbfe-d890-b4a7.ngrok-free.app/UserSplit/ListOfSplits")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            urlRequest.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let posts = try JSONDecoder().decode([MyCollection].self, from: data!)
                        promise(.success(posts))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func getSplitDetails(id: String, token: String) -> Future<Split, Error> {
        Future { promise in
            var urlComponents = URLComponents(string: "https://05c8-2a02-2f0a-4103-2b00-b93e-dbfe-d890-b4a7.ngrok-free.app/UserSplit/GetSplit")
            
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
                        let post = try JSONDecoder().decode(Split.self, from: data!)
                        promise(.success(post))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }
    }
}

