//
//  ViewController.swift
//  iOSFinalProject
//
//  Created by Justin on 2020/12/8.
//
import UIKit

protocol SaveNewExerciseDelegate: class {
    func saveNewEx(newName: String?, newMuscleTarget: String?, index: Int?)
}
class ExerciseViewController: UIViewController {
    var tableView: UITableView!
    //var titleLabel: UILabel!
    //var workoutButton: UIButton!
    //var exerciseButton: UIButton!
    //var workoutsView: UICollectionView!
    //let padding: CGFloat = 8
    
    let workoutReuseIdentifier = "workoutCellReuseIdentifier"
    let cellHeight: CGFloat = 50
    
    
    let squats = Exercise(imageName: "squats", name: "Squats", muscleTarget: "Hamstrings", seen: false)
    let jumpropes = Exercise(imageName: "jumprope", name: "Jump Ropes", muscleTarget: "Calves", seen: false)
    let bench = Exercise(imageName: "benchpress", name: "Bench Press", muscleTarget: "Chest", seen: false)
    let deadlift = Exercise(imageName: "deadlift", name: "Deadlift", muscleTarget: "Back", seen: false)
    let dips = Exercise(imageName: "dips", name: "Dips", muscleTarget: "Triceps", seen: false)
    let situp = Exercise(imageName: "situps", name: "Sit-ups", muscleTarget: "Abs", seen: false)
    let overheadpress = Exercise(imageName: "overheadpress", name: "Overhead press", muscleTarget: "Shoulders", seen: false)
    let curls = Exercise(imageName: "curls", name: "Dumbell curls", muscleTarget: "Biceps", seen: false)
    
    var exercises: [Exercise]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        exercises = [squats, jumpropes, bench, deadlift, dips, situp, overheadpress, curls]
        title = "Exercises"
        view.backgroundColor = .black

        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ExerciseTableViewCell.self, forCellReuseIdentifier: workoutReuseIdentifier)
        view.addSubview(tableView)

        setupConstraints()
    }

    func setupConstraints() {
//        Setup the constraints for our views
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ExerciseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: workoutReuseIdentifier, for: indexPath) as! ExerciseTableViewCell
        let ex = exercises[indexPath.row]
        cell.backgroundColor = .white
        cell.configure(for: ex)
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       let footerView = UIView()
       footerView.frame = CGRect(x: 0, y: 0, width: 400, height:
       100)
       let button = UIButton()
       button.frame = CGRect(x: 20, y: 10, width: 300, height: 50)
       button.setTitle("CustomButton", for: .normal)
       //button.backgroundColor = colorLiteral(red: 0.721568644, green:
       //0.8862745166, blue: 0.5921568871, alpha: 1)
       footerView.addSubview(button)
       return footerView
    }*/

    
}

extension ExerciseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ex = exercises[indexPath.row]
        let index = indexPath.row
        let vc = EditExerciseViewController(delegate: self, ex: ex, index: index)
        present(vc, animated: true, completion: nil)

    }
}


extension ExerciseViewController: SaveNewExerciseDelegate {
    func saveNewEx(newName: String?, newMuscleTarget: String?, index: Int?) {
        let ex = exercises[index ?? 0]
        ex.setName(name: newName ?? "Empty")
        ex.setMuscleTarget(muscleTarget: newMuscleTarget ?? "Empty")
        tableView.reloadData()
    }
}
