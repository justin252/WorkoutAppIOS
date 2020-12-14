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
    var exercises: [Exercise]!
    var tableView: UITableView!
    let ReuseIdentifier = "ReuseIdentifier"
    let cellHeight: CGFloat = 50
    
    init(name: String, exercises: [Exercise]){
        titleWorkout = name
        self.exercises = exercises
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
        workoutTitle.font = .systemFont(ofSize: 30, weight: .bold)
        workoutTitle.text = titleWorkout
        workoutTitle.textColor = .black
        view.addSubview(workoutTitle)
        
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WorkoutViewTableViewCell.self, forCellReuseIdentifier: ReuseIdentifier)
        view.addSubview(tableView)
        
        
        dismissButton = UIButton()
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.setTitle("Save", for: .normal)
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
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: workoutTitle.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        NSLayoutConstraint.activate([
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 150),
            dismissButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 30),
            dismissButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}

extension EditWorkoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier, for: indexPath) as! WorkoutViewTableViewCell
        let ex = exercises[indexPath.row]
        cell.backgroundColor = .white
        cell.layer.borderColor = UIColor.systemTeal.cgColor
        cell.layer.borderWidth = 5
        cell.layer.cornerRadius = 15
        cell.configure(for: ex)
        return cell
    }
}

extension EditWorkoutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let ex = exercises[indexPath.row]
//        let index = indexPath.row
//        //let vc = EditExerciseViewController(delegate: self, ex: ex, index: index)
//        present(vc, animated: true, completion: nil)
//
//    }
}


//extension ExerciseViewController: SaveNewExerciseDelegate {
//    func saveNewEx(newName: String?, newMuscleTarget: String?, index: Int?) {
//        let ex = exercises[index ?? 0]
//        ex.setName(name: newName ?? "Empty")
//        ex.setMuscleTarget(muscleTarget: newMuscleTarget ?? "Empty")
//        tableView.reloadData()
//    }
//}
