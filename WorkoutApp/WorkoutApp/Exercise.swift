//
//  Exercise.swift
//  iOSFinalProject
//
//  Created by Justin on 2020/12/8.
//
import Foundation

class Exercise: Codable{
    var id: Int
    var name: String
    var seen: Bool
    var sets: [SetStore]
    
    init(id: Int, name: String, seen: Bool, sets: [SetStore]) {
        self.id = id
        self.name = name
        self.seen = seen
        self.sets = sets
    }
}
struct ExerciseDataResponse: Codable{
    var data: [Exercise]
}
