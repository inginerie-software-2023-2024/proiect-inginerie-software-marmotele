//
//  SplitHistoryAPI.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 10.12.2023.
//

import Foundation
import Combine
import SwiftyJSON

class SplitHistoryAPI {
    func getSplitHistory(id: String, token: String) -> Future<History, Error> {
        Future { promise in
            var urlComponents = URLComponents(string: "https://2a49-82-208-174-16.ngrok-free.app/UserSplit/WorkoutHistory")
            
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
                        let progress = try JSONDecoder().decode(History.self, from: data!)
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
