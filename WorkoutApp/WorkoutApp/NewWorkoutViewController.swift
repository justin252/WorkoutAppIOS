//
//  EditWorkoutViewController.swift
//  iOSFinalProject
//
//  Created by Ethan on 2020/12/12.
//
import UIKit

class NewWorkoutViewController: UIViewController {
    weak var delegate: NameDelegate?

    var pageTitle: UILabel!
    var dismissButton: UIButton!
    var workoutName: UITextView!
    var descrip: UITextView!
    let padding: CGFloat = 5
    var newExercisePicker: UICollectionView!
    var wName: String!
    var w: Workout!
    let exerciseReuseIdentifier = "newCellReuseIdentifier"
    
    /*let squats = Exercise(imageName: "", name: "Squats", muscleTarget: "Hamstrings", seen: false)
    let jumpropes = Exercise(imageName: "", name: "Jump Ropes", muscleTarget: "Calves", seen: false)
    let bench = Exercise(imageName: "", name: "Bench Press", muscleTarget: "Chest", seen: false)
    let deadlift = Exercise(imageName: "", name: "Deadlift", muscleTarget: "Back", seen: false)
    let dips = Exercise(imageName: "", name: "Dips", muscleTarget: "Triceps", seen: false)
    let situp = Exercise(imageName: "", name: "Sit-ups", muscleTarget: "Abs", seen: false)
    let overheadpress = Exercise(imageName: "", name: "Overhead press", muscleTarget: "Shoulders", seen: false)
    let curls = Exercise(imageName: "", name: "Dumbell curls", muscleTarget: "Biceps", seen: false)*/
    
    var exercises: [Exercise] = []
    var goodExs: [Exercise] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //Load in exercises from API
        getExercises()
        
        //exercises = [squats, jumpropes, bench, deadlift, dips, situp, overheadpress, curls]
        goodExs = []
        
        pageTitle = UILabel()
        pageTitle.translatesAutoresizingMaskIntoConstraints = false
        pageTitle.font = .systemFont(ofSize: 30, weight: .bold)
        pageTitle.text = "Make New Workout"
        pageTitle.textColor = .black
        view.addSubview(pageTitle)
        
        workoutName = UITextView()
        workoutName.translatesAutoresizingMaskIntoConstraints = false
        workoutName.text = "Workout" + String(Int.random(in: 0...10000))
        workoutName.textColor = .black
        workoutName.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        workoutName.isEditable = true
        workoutName.textAlignment = .center
        view.addSubview(workoutName)
        
        descrip = UITextView()
        descrip.translatesAutoresizingMaskIntoConstraints = false
        descrip.text = "Please change the name of your workout and then choose the exercises you would like to include in your custom workout."
        descrip.textColor = .red
        descrip.font = UIFont.systemFont(ofSize: 16)
        descrip.textAlignment = .center
        view.addSubview(descrip)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.scrollDirection = .vertical
        
        newExercisePicker = UICollectionView(frame: .zero, collectionViewLayout: layout)
        newExercisePicker.backgroundColor = .white
        newExercisePicker.translatesAutoresizingMaskIntoConstraints = false
        newExercisePicker.dataSource = self
        newExercisePicker.delegate = self
        newExercisePicker.register(NewWorkoutCollectionViewCell.self, forCellWithReuseIdentifier: exerciseReuseIdentifier)
        view.addSubview(newExercisePicker)
        
        dismissButton = UIButton()
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.setTitle("Save & Leave Workout Planner", for: .normal)
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
            pageTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            pageTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageTitle.heightAnchor.constraint(equalToConstant: 48)
            ])
        NSLayoutConstraint.activate([
            workoutName.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 5),
            workoutName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            workoutName.heightAnchor.constraint(equalToConstant: 50),
            workoutName.widthAnchor.constraint(equalTo: view.widthAnchor)
            
            ])
        NSLayoutConstraint.activate([
            descrip.topAnchor.constraint(equalTo: workoutName.bottomAnchor, constant: 5),
            descrip.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descrip.heightAnchor.constraint(equalToConstant: 70),
            descrip.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])
        
        NSLayoutConstraint.activate([
            newExercisePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            newExercisePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            newExercisePicker.topAnchor.constraint(equalTo: descrip.bottomAnchor, constant: 30),
            newExercisePicker.bottomAnchor.constraint(equalTo: dismissButton.topAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            //dismissButton.bottomAnchor.constraint(equalTo: newExercisePicker.bottomAnchor, constant: 10),
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 300),
            dismissButton.heightAnchor.constraint(equalToConstant: 70),
            dismissButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
            ])
        
    }
    
    @objc func dismissViewController() {
        //Find some way to save data
        
        for exercise in exercises{
            if(exercise.seen == true){
                goodExs.append(exercise)
            }
        }
        wName = workoutName.text
        //UPDATE
        w = Workout(id: 1, date: "test", name: wName, notes: "test", exercises: goodExs, userId: 1)
        delegate?.updateWorkout(newWorkout: w)
        dismiss(animated: true, completion: nil)
    }
    private func getExercises() {
        NetworkManager.getExercises() { exercises in
            self.exercises = exercises
            DispatchQueue.main.async {
                self.newExercisePicker.reloadData()
            }
        }
    }
}

extension NewWorkoutViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return exercises.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseReuseIdentifier, for: indexPath) as! NewWorkoutCollectionViewCell
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.systemTeal.cgColor
        cell.layer.cornerRadius = 4 // optional
        cell.configure(exercise: exercises[indexPath.item])
        return cell
    }
}

extension NewWorkoutViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - padding)/2
        return CGSize(width: size, height: 50)
    }
}
extension NewWorkoutViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        exercises[indexPath.row].seen = !exercises[indexPath.row].seen
        newExercisePicker.reloadData()
        //let index = indexPath.row
        //let vc = NewWorkoutViewController(name: workout.name)
        //(pic: song.songcover, title:song.songtitle, artist:song.songartist, album: song.songalbum, index: index)
        //vc.delegate = self
        //present(vc, animated: true, completion: nil)
    }
}
