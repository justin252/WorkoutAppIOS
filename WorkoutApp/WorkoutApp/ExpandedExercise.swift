//
//  ExpandedExercise.swift
//  WorkoutApp
//
//  Created by Tucker Stanley on 12/13/20.
//

import Foundation

class ExpandedExercise {
    var imageName: String
    var name: String
    var muscleTarget: String
    var seen: Bool

    
    init(imageName: String, name: String, muscleTarget: String, seen: Bool) {
        self.name = name
        self.muscleTarget = muscleTarget
        self.imageName = imageName
        self.seen = seen
    }
    
    func setName(name: String){
        self.name = name
    }
    func setMuscleTarget(muscleTarget: String){
        self.muscleTarget = muscleTarget
    }
    func setImageName(imageName: String){
        self.imageName = imageName
    }
}


