//
//  ViewController.swift
//  iOSFinalProject
//
//  Created by Justin on 2020/12/8.
//

import UIKit

class ExerciseViewController: UIViewController {
    var titleLabel: UILabel!
    var workoutButton: UIButton!
    var exerciseButton: UIButton!
    var workoutsView: UICollectionView!
    let padding: CGFloat = 8
    let workoutReuseIdentifier = "workoutCellReuseIdentifier"
    
    

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textLabel = UILabel()
        textLabel.text = "Hello."
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textLabel)
    }


}

