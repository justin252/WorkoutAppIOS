//
//  ViewController.swift
//  iOSFinalProject
//
//  Created by Justin on 2020/12/8.
//

import UIKit

class WorkoutViewController: UIViewController {
    var titleLabel: UILabel!
    var workoutsView: UICollectionView!
    let padding: CGFloat = 5
    let workoutReuseIdentifier = "exerciseCellReuseIdentifier"
    
    let squats = Exercise(imageName: "", name: "Squats", muscleTarget: "Hamstrings")
    let jumpropes = Exercise(imageName: "", name: "Jump Ropes", muscleTarget: "Calves")
    let bench = Exercise(imageName: "", name: "Bench Press", muscleTarget: "Chest")
    let deadlift = Exercise(imageName: "", name: "Deadlift", muscleTarget: "Back")
    let dips = Exercise(imageName: "", name: "Dips", muscleTarget: "Triceps")
    let situp = Exercise(imageName: "", name: "Sit-ups", muscleTarget: "Abs")
    let overheadpress = Exercise(imageName: "", name: "Overhead press", muscleTarget: "Shoulders")
    let curls = Exercise(imageName: "", name: "Dumbell curls", muscleTarget: "Biceps")
    
    var exercises: [Exercise] = []
    var workouts: [Workout] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        title = "Workout App"
        
        let workout1 = Workout(name: "Workout 1", exercises: [bench, overheadpress, dips])
        let workout2 = Workout(name: "Workout 2", exercises: [deadlift, curls])
        let workout3 = Workout(name: "Workout 3", exercises: [squats, situp])
        let workout4 = Workout(name: "Workout 4", exercises: [jumpropes])
        
        exercises = [squats, jumpropes, bench, deadlift, dips, situp, overheadpress, curls]
        workouts = [workout1, workout2, workout3, workout4]
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Welcome to the workout app! \nWould you like to view workouts or exercises?"
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.scrollDirection = .vertical
        
        workoutsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        workoutsView.backgroundColor = .white
        workoutsView.translatesAutoresizingMaskIntoConstraints = false
        workoutsView.dataSource = self
        workoutsView.delegate = self
        workoutsView.register(WorkoutCollectionViewCell.self, forCellWithReuseIdentifier: workoutReuseIdentifier)
        view.addSubview(workoutsView)
        
        setupConstraints()

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            workoutsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            workoutsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            workoutsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            workoutsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
//        NSLayoutConstraint.activate([
//            workoutButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
//            workoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            workoutButton.heightAnchor.constraint(equalToConstant: 24)
//        ])
//
//        NSLayoutConstraint.activate([
//            exerciseButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
//            exerciseButton.leadingAnchor.constraint(equalTo: workoutButton.trailingAnchor, constant: 10),
//            exerciseButton.heightAnchor.constraint(equalToConstant: 24)
//        ])
    }
}

extension WorkoutViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return workouts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: workoutReuseIdentifier, for: indexPath) as! WorkoutCollectionViewCell
        cell.layer.borderWidth = 5.0
        cell.layer.borderColor = UIColor.systemTeal.cgColor
        cell.layer.cornerRadius = 8 // optional
        cell.backgroundColor = .systemPurple
        cell.configure(workout: workouts[indexPath.item])
        return cell
    }
}
   
extension WorkoutViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - padding)/2
        return CGSize(width: size, height: size)
    }
}
extension WorkoutViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let workout = workouts[indexPath.row]

        //let index = indexPath.row
        let vc = EditWorkoutViewController(name: workout.name)
        //(pic: song.songcover, title:song.songtitle, artist:song.songartist, album: song.songalbum, index: index)
        //vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}



