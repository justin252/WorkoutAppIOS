//
//  NetworkManager.swift
//  WorkoutApp
//
//  Created by Justin on 2020/12/13.
//
import Foundation
import Alamofire

class NetworkManager {
    private static let host = "ae385workout-api.herokuapp.com"

    
    

static func getRestaurants(completion: @escaping ([Workout]) -> Void) {
    let endpoint = "\(host)/exercises/"
    AF.request(endpoint, method: .get).validate().responseData { response in
        switch response.result {
        case .success(let data):
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            if let workoutsData = try? jsonDecoder.decode(WorkoutsDataResponse.self, from: data) {
                // Instructions: Use completion to handle response
                let workouts = workoutsData.workouts
                completion(workouts)
            }

        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
}
