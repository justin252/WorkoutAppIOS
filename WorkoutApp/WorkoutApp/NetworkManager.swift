//
//  NetworkManager.swift
//  WorkoutApp
//
//  Created by Justin on 2020/12/13.
//
import Foundation
import Alamofire

class NetworkManager {
    private static let host = "https://ae385api.herokuapp.com"

static func getExercises(completion: @escaping ([Exercise]) -> Void) {
    let endpoint = "\(host)/exercises/"
    AF.request(endpoint, method: .get).validate().responseData { response in
        switch response.result {
        case .success(let data):
            print("Success")
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            if let exerciseData = try? jsonDecoder.decode(ExerciseDataResponse.self, from: data) {
                // Instructions: Use completion to handle response
                let exercises = exerciseData.data
                completion(exercises)
            }

        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
}
