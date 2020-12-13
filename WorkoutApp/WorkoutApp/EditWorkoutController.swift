//
//  EditWorkoutViewController.swift
//  iOSFinalProject
//
//  Created by Justin on 2020/12/8.
//
import UIKit

class EditWorkoutViewController: UIViewController {

    var titleWorkout: String!
    var workoutTitle: UILabel!
    var dismissButton: UIButton!
    
    init(name: String){
        titleWorkout = name
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        workoutTitle = UILabel()
        workoutTitle.translatesAutoresizingMaskIntoConstraints = false
        workoutTitle.font = .systemFont(ofSize: 14, weight: .bold)
        workoutTitle.text = "Workout plan for " + titleWorkout
        workoutTitle.textColor = .black
        view.addSubview(workoutTitle)
        
        dismissButton = UIButton()
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.setTitle("Save & Leave Workout Plan", for: .normal)
        dismissButton.backgroundColor = .systemPurple
        dismissButton.layer.borderColor = UIColor.systemTeal.cgColor
        dismissButton.layer.cornerRadius = 8
        dismissButton.layer.borderWidth = 5
        dismissButton.setTitleColor(.black, for: .normal)
        dismissButton.titleLabel?.font =  .boldSystemFont(ofSize: 16)
        dismissButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        view.addSubview(dismissButton)
        
        setUpConstraints()

    }
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            workoutTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            workoutTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            workoutTitle.heightAnchor.constraint(equalToConstant: 48)
            ])
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: workoutTitle.bottomAnchor, constant: 30),
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 300),
            dismissButton.heightAnchor.constraint(equalToConstant: 48)
            ])
        
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
