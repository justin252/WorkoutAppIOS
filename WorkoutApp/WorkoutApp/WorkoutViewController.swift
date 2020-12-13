//
//  ViewController.swift
//  iOSFinalProject
//
//  Created by Justin on 2020/12/8.
//
import UIKit
protocol NameDelegate:class {
    func updateWorkout(newWorkout: Workout)
}
class WorkoutViewController: UIViewController {
    var titleLabel: UILabel!
    var workoutsView: UICollectionView!
    var addButton: UIButton!
    let padding: CGFloat = 5
    let workoutReuseIdentifier = "exerciseCellReuseIdentifier"
    
    let squats = Exercise(imageName: "", name: "Squats", muscleTarget: "Hamstrings", seen: false)
    let jumpropes = Exercise(imageName: "", name: "Jump Ropes", muscleTarget: "Calves", seen: false)
    let bench = Exercise(imageName: "", name: "Bench Press", muscleTarget: "Chest", seen: false)
    let deadlift = Exercise(imageName: "", name: "Deadlift", muscleTarget: "Back", seen: false)
    let dips = Exercise(imageName: "", name: "Dips", muscleTarget: "Triceps", seen: false)
    let situp = Exercise(imageName: "", name: "Sit-ups", muscleTarget: "Abs", seen: false)
    let overheadpress = Exercise(imageName: "", name: "Overhead press", muscleTarget: "Shoulders", seen: false)
    let curls = Exercise(imageName: "", name: "Dumbell curls", muscleTarget: "Biceps", seen: false)
    
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
        
        addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Add Workout", for: .normal)
        addButton.backgroundColor = .systemTeal
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        addButton.layer.borderWidth = 3.0
        addButton.layer.borderColor = UIColor.systemPurple.cgColor
        addButton.setTitleColor(.black, for: .normal)
        addButton.layer.cornerRadius = 4
        addButton.addTarget(self, action: #selector(update), for: .touchUpInside)
        view.addSubview(addButton)

        
        
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
            workoutsView.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 150),
            addButton.topAnchor.constraint(equalTo: workoutsView.bottomAnchor, constant: 30),
            addButton.heightAnchor.constraint(equalToConstant: 50)
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
    @objc func update(){
        let vc = NewWorkoutViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
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

extension WorkoutViewController: NameDelegate{
    func updateWorkout(newWorkout:Workout) {
        print("HI")
        workouts.append(newWorkout);
        workoutsView.reloadData()
    }
  
}
