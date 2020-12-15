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
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            //print("Success")
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
static func getWorkouts(completion: @escaping ([Workout]) -> Void) {
    let endpoint = "\(host)/workouts/"
    AF.request(endpoint, method: .get).validate().responseData { response in
        switch response.result {
        case .success(let data):
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            if let workoutData = try? jsonDecoder.decode(WorkoutDataResponse.self, from: data) {
                // Instructions: Use completion to handle response
                let workouts = workoutData.data
                completion(workouts)
            }

        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
    
static func postWorkout(date: String, name: String, notes: String, exercises: String, completion: @escaping ([Workout]) -> Void) {
    let endpoint = "\(host)/workouts/"
    let parameters:[String: Any] = ["date": date, "name": name, "notes":notes, "exercises": exercises]
        AF.request(endpoint, method: .post, parameters: parameters, encoding:
        JSONEncoding.default).validate().responseData { response in
        switch response.result {
        case .success(let data):
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            if let workoutData = try? jsonDecoder.decode(WorkoutDataResponse.self, from: data) {
                // Instructions: Use completion to handle response
                let workouts = workoutData.data
                completion(workouts)
            }

        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
}
