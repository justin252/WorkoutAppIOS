//
//  Exercise.swift
//  iOSFinalProject
//
//  Created by Justin on 2020/12/8.
//

import Foundation

class Exercise {
    var imageName: String
    var name: String
    var muscleTarget: String
    
    init(imageName: String, name: String, muscleTarget: String) {
        self.name = name
        self.muscleTarget = muscleTarget
        self.imageName = imageName
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

