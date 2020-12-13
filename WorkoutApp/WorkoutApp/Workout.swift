//
//  Workout.swift
//  WorkoutApp
//
//  Created by Ethan Stanley on 12/13/20.
//


struct WorkoutsDataResponse: Codable{
    var workouts: [Workout]
}
struct Workout: Codable{
    var id: Int
    var date: String
    var name: String
    var notes: String
    var exercises: [Exercise]
}
