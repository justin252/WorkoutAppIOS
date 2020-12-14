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
    
    
    let squats = ExpandedExercise(imageName: "squats", name: "Squats", muscleTarget: "Hamstrings", seen: false)
    let jumpropes = ExpandedExercise(imageName: "jumprope", name: "Jump Ropes", muscleTarget: "Calves", seen: false)
    let bench = ExpandedExercise(imageName: "benchpress", name: "Bench Press", muscleTarget: "Chest", seen: false)
    let deadlift = ExpandedExercise(imageName: "deadlift", name: "Deadlift", muscleTarget: "Back", seen: false)
    let dips = ExpandedExercise(imageName: "dips", name: "Dips", muscleTarget: "Triceps", seen: false)
    let situp = ExpandedExercise(imageName: "situps", name: "Sit-ups", muscleTarget: "Abs", seen: false)
    let overheadpress = ExpandedExercise(imageName: "overheadpress", name: "Overhead press", muscleTarget: "Shoulders", seen: false)
    let curls = ExpandedExercise(imageName: "curls", name: "Curls", muscleTarget: "Biceps", seen: false)
    let hangclean = ExpandedExercise(imageName: "hangclean", name: "Hangclean", muscleTarget: "Upper Body", seen: false)
    let pushups = ExpandedExercise(imageName: "pushups", name: "Pushups", muscleTarget: "Chest/Biceps", seen: false)
    let calfraises = ExpandedExercise(imageName: "calfraises", name: "Calf Raises", muscleTarget: "Calves", seen: false)
    let running = ExpandedExercise(imageName: "running", name: "Running", muscleTarget: "Calves and Glutes", seen: false)
    let biking = ExpandedExercise(imageName: "biking", name: "Dumbell curls", muscleTarget: "Calves and Thighs", seen: false)
    let swimming = ExpandedExercise(imageName: "swimming", name: "Dumbell curls", muscleTarget: "Full Body", seen: false)
    let lunges = ExpandedExercise(imageName: "lunges", name: "Dumbell curls", muscleTarget: "Biceps", seen: false)
    let burpees = ExpandedExercise(imageName: "burpees", name: "Dumbell curls", muscleTarget: "Biceps", seen: false)
    let planks = ExpandedExercise(imageName: "planks", name: "Dumbell curls", muscleTarget: "Biceps", seen: false)
    let yoga = ExpandedExercise(imageName: "yoga", name: "Dumbell curls", muscleTarget: "Biceps", seen: false)
    let jumpingjacks = ExpandedExercise(imageName: "jumpingjacks", name: "Dumbell curls", muscleTarget: "Biceps", seen: false)
    let buttups = ExpandedExercise(imageName: "buttups", name: "Dumbell curls", muscleTarget: "Biceps", seen: false)
    let skullcrushers = ExpandedExercise(imageName: "skullcrushers", name: "Dumbell curls", muscleTarget: "Biceps", seen: false)
    let pullups = ExpandedExercise(imageName: "pullups", name: "Dumbell curls", muscleTarget: "Biceps", seen: false)
    let curlups = ExpandedExercise(imageName: "curlups", name: "Dumbell curls", muscleTarget: "Biceps", seen: false)
    let abroller = ExpandedExercise(imageName: "abroller", name: "Dumbell curls", muscleTarget: "Biceps", seen: false)
    let crunches = ExpandedExercise(imageName: "crunches", name: "Dumbell curls", muscleTarget: "Biceps", seen: false)
    let russiantwists = ExpandedExercise(imageName: "russiantwists", name: "Dumbell curls", muscleTarget: "Biceps", seen: false)


    var exercises: [ExpandedExercise]!

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
