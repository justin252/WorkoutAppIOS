//
//  Exercise.swift
//  iOSFinalProject
//
//  Created by Justin on 2020/12/8.
//
import Foundation

struct Exercise: Codable{
    var id: Int
    var name: String
    var seen: Bool
    var sets: [String]
}
struct ExerciseDataResponse: Codable{
    var data: [Exercise]
}
