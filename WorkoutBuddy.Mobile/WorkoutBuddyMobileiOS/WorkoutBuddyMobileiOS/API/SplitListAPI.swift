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
            guard let url = URL(string: "https://731c-86-124-16-55.ngrok-free.app/UserSplit/ListOfSplits") else {
                return promise(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            }

            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

            urlRequest.httpMethod = "GET"

            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        var arrayToReturn = [MyCollection]()
                        let json = try JSON(data: data!)
                        let collections = json["response"]
                        for(_, item) in collections {
                            let collection = MyCollection(splitId: item["splitId"].stringValue,
                                                          name: item["name"].stringValue,
                                                          description: item["description"].stringValue,
                                                          workoutsNb: item["workoutsNo"].intValue)
                            arrayToReturn.append(collection)
                        }
                        promise(.success(arrayToReturn))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }
    }
}
