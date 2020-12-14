//
//  Workout.swift
//  WorkoutApp
//
//  Created by Ethan Stanley on 12/13/20.
//
import Foundation
/*

struct WorkoutsDataResponse: Codable{
    var workouts: [Workout]
}*/

//        let workout1 = Workout(id: 1, date: "12/13/20", name: "Workout 1", notes: "Great workout.", exercises: [bench, overheadpress, dips])

class Workout {
    var id: Int
    var date: String
    var name: String
    var notes: String
    var exercises: [Exercise]
    
    init(id: Int, date: String, name: String, notes: String, exercises: [Exercise]) {
        self.id = 1
        self.date = date
        self.name = name
        self.notes = notes
        self.exercises = exercises
    }
    
}
