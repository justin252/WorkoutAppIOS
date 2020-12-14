//
//  LogInfoViewController.swift
//  WorkoutApp
//
//  Created by Justin on 2020/12/13.
//

import Foundation
import UIKit


class InfoLogViewController: UIViewController {
    weak var delegate: LogWorkoutDelegate?
    var saveButton: UIButton!
    var dateLabel: UILabel!
    var dateToDisplay: Date
    
    init(delegate: LogWorkoutDelegate?, dateToDisplay: Date){
        self.dateToDisplay = dateToDisplay
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
    func setupViews(){
        // Display the date
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MM-dd-YYYY"
        let s = formatter.string(from: dateToDisplay)
        
//        dateLabel.text = s ? ""
    }
    func setupConstraints(){
        
    }
    @objc func popViewControllerAndLogWorkout() {
        // get the reps and sets data from the text fields
        
        navigationController?.popViewController(animated: true)
    }

}

