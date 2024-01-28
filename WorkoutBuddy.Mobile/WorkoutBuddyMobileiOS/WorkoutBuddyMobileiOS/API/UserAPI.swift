//
//  UserAPI.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 28.11.2023.
//

import Foundation
import Combine
import SwiftyJSON

class UserAPI {
    func login(email: String, password: String) -> Future<User, Error> {
        Future { promise in
            let urlComponents = URLComponents(string: "https://05c8-2a02-2f0a-4103-2b00-b93e-dbfe-d890-b4a7.ngrok-free.app/UserAccount/login")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            
            urlRequest.httpMethod = "POST" // VERB
            
            let body = LoginBody(email: email, password: password, areCredentialsInvalid: false, isDisabled: false)
            
            do {
                urlRequest.httpBody = try JSONEncoder().encode(body)
            } catch {
                
            }
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let user = try JSONDecoder().decode(User.self, from: data!)
                        promise(.success(user))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }
    }
}

