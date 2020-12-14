//
//  Workout.swift
//  WorkoutApp
//
//  Created by Ethan Stanley on 12/13/20.
//
import Foundation

class Workout {
    var id: Int
    var date: String
    var name: String
    var notes: String
    var exercises: [Exercise]
    var userId: Int
    
    init(id: Int, date: String, name: String, notes: String, exercises: [Exercise], userId: Int) {
        self.id = 1
        self.date = date
        self.name = name
        self.notes = notes
        self.exercises = exercises
        self.userId = userId
    }
    
}
/*
class WorkoutResponse {
    var data: [Workout]
}
*/
