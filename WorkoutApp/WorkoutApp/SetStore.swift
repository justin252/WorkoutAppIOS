//
//  Set.swift
//  WorkoutApp
//
//  Created by Tucker Stanley on 12/14/20.
//

import Foundation

class SetStore: Codable{
    var id: Int
    var number: Int
    var reps: Int
    var weight: String


    init(id: Int, number: Int, reps: Int, weight: String) {
        self.id = id
        self.number = number
        self.reps = reps
        self.weight = weight
    }
}

//{"id": 1, "number": 1, "reps": 16, "weight": "160 lbs"},
