//
//  CalendarViewController.swift
//  iOSFinalProject
//
//  Created by Justin on 2020/12/9.
//
import UIKit
import FSCalendar
 
protocol LogWorkoutDelegate: class{
    func logWorkout(date: Date, newWorkout: Workout)
}
class CalendarViewController: UIViewController {
    var calendar = FSCalendar()
    var editButton: UIButton!
    var inEditingMode: Bool = false
    var editingSwitch: UISwitch!
    var toggleLabel: UILabel!
    
//   Hard-coded data - replace with data from API
//    let squats = Exercise(imageName: "", name: "Squats", muscleTarget: "Hamstrings", seen: false)
//    let jumpropes = Exercise(imageName: "", name: "Jump Ropes", muscleTarget: "Calves", seen: false)
//    let bench = Exercise(imageName: "", name: "Bench Press", muscleTarget: "Chest", seen: false)
//    let deadlift = Exercise(imageName: "", name: "Deadlift", muscleTarget: "Back", seen: false)
//    let dips = Exercise(imageName: "", name: "Dips", muscleTarget: "Triceps", seen: false)
//    let situp = Exercise(imageName: "", name: "Sit-ups", muscleTarget: "Abs", seen: false)
//    let overheadpress = Exercise(imageName: "", name: "Overhead press", muscleTarget: "Shoulders", seen: false)
//    let curls = Exercise(imageName: "", name: "Dumbell curls", muscleTarget: "Biceps", seen: false)
//
// dateToDisplay: date, workoutToDisplay: workout1, notes: "example notes", sets: [5, 6, 7], reps: [10, 20, 30], weight: ["100", "200", "300"]
// End of hard-coded data
    

    
    var exercises: [Exercise] = []
    var workouts: [Workout] = []
    

    //dictionary storing data
    var completeWorkoutLog : [Date : Workout]! = [:]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getWorkouts()
//        let workout1 = Workout(id: 1, date: "", name: "Workout 1", notes: "", exercises: [bench, overheadpress, dips])
//        let workout2 = Workout(id: 1, date: "", name: "Workout 2", notes: "", exercises: [deadlift, curls])
//        let workout3 = Workout(id: 1, date: "", name: "Workout 3", notes: "",exercises: [squats, situp])
//        let workout4 = Workout(id: 1, date: "", name: "Workout 4", notes: "", exercises: [jumpropes])
        
        //exercises = [squats, jumpropes, bench, deadlift, dips, situp, overheadpress, curls]
       // workouts = [workout1, workout2, workout3, workout4]

        
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        //setup calendar
        calendar.dataSource = self
        calendar.delegate = self
        calendar.frame = CGRect(x: 0, y: 125, width: view.frame.size.width, height: view.frame.size.height-300)
        calendar.scrollDirection = .horizontal
        calendar.pagingEnabled = true
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(calendar)
        
        editingSwitch = UISwitch()
        editingSwitch.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        editingSwitch.isOn = false
        editingSwitch.addTarget(self, action: #selector(handleToggled), for: .valueChanged)
        view.addSubview(editingSwitch)
        
        toggleLabel = UILabel()
        toggleLabel.text = "Toggle editing mode"
        toggleLabel.font = .boldSystemFont(ofSize: 16)
        view.addSubview(toggleLabel)
        //setup add workout button
        editButton = UIButton()
//        editButton.setTitle("Tap to view a session", for: .normal)
//        editButton.setTitleColor(.black, for: .normal)
//        editButton.layer.masksToBounds = true
//        editButton.layer.cornerRadius = editButton.frame.width / 2
//
        
//        editButton.titleLabel?.font =  .boldSystemFont(ofSize: 16)
        
//        editButton.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
//        editButton.layer.borderColor = UIColor.orange.cgColor
//        editButton.layer.cornerRadius = 0.5*editButton.bounds.size.width
//        editButton.clipsToBounds = true
        editButton.addTarget(self, action: #selector(toggleButtonText), for: .touchUpInside)
        view.addSubview(editButton)
    }
    func setupConstraints(){
        editingSwitch.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().inset(25)
            make.top.equalTo(calendar.snp.bottom).offset(5)
        }
        editButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(calendar.snp.bottom).offset(20)
//            make.height.equalTo(30)
//            make.width.equalTo(300)
        }
        toggleLabel.snp.makeConstraints{ make in
            make.trailing.equalTo(editingSwitch.snp.leading).offset(-10)
            make.centerY.equalTo(editingSwitch.snp.centerY)
        }
    }
    
    
//  Call from API.
// date => convert to dateString which is a String => access fields for workout => create workout object and pass it into the presentInfoLog function.
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        let dateString = formatter.string(from: date)
    
        if (inEditingMode) {
            presentEditLog(date: date)
        }
        // workout1 is a dummy variable. replace get that workout from the API
        else {
            let workout1 = workouts[0]
            print(workout1)
            //let workout1 = Workout(id: 1, date: "", name: "Workout 1", notes: "", exercises: [bench, overheadpress, dips])
            presentInfoLog(date: dateString, workoutToDisplay: workout1)
        }
    }
    @objc func handleToggled(){
        inEditingMode = !inEditingMode
    }
    @objc func toggleButtonText(){
        inEditingMode = !inEditingMode
        
        if editButton.titleLabel?.text == "Log Session" {
            editButton.setTitle("View Session", for: .normal)
            // we can change the color of the edit button here
        }
        else {
            editButton.setTitle("Log Session", for: .normal)
        }
    }
    // complete list of workouts comes from the API.
    // dateToDisplay is of type Date, from the calendar.
    func presentEditLog(date: Date) {
        let vc = EditLogViewController(delegate:self, dateToDisplay: date, workoutsToDisplay: workouts)
        present(vc, animated: true, completion: nil)
    }
    
    // dateToDisplay here is the converted string
    // workoutToDisplay here is a singular workout constructed from the API - workouts[0] is a dummy variable
    func presentInfoLog(date: String, workoutToDisplay: Workout) {
        let vc = InfoLogViewController(dateToDisplay: date, workoutToDisplay: workouts[0])
        present(vc, animated: true, completion: nil)
    }
    func displayErrorMessage(){
        
    }
    private func getWorkouts() {
        NetworkManager.getWorkouts() { workouts in
            self.workouts = workouts
        }
    }
    
}

extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        
        return cell
    }
}
extension CalendarViewController: LogWorkoutDelegate{
    func logWorkout(date: Date, newWorkout: Workout){
        
    }
}



