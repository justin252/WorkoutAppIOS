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
    var inEditingMode: Bool = true
    
    
    let squats = Exercise(id: 1, name: "Squats", seen: false, sets: [])
    let jumpropes = Exercise(id: 1, name: "Jump Ropes", seen: false, sets: [])
    let bench = Exercise(id: 1, name: "Bench", seen: false, sets: [])
    let deadlift = Exercise(id: 1, name: "Deadlift", seen: false, sets: [])
    let dips = Exercise(id: 1, name: "Dips", seen: false, sets: [])
    let situp = Exercise(id: 1, name: "Situps", seen: false, sets: [])
    let overheadpress = Exercise(id: 1, name: "Overhead Press", seen: false, sets: [])
    let curls = Exercise(id: 1, name: "Curls", seen: false, sets: [])

    var workouts: [Workout] = []
    //dictionary storing data
    var completeWorkoutLog : [Date : Workout]! = [:]
        
    var exercises: [Exercise] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let workout1 = Workout(id: 1, date: "", name: "Workout 1", notes: "", exercises: [bench, overheadpress, dips], userId: 1)
        let workout2 = Workout(id: 1, date: "", name: "Workout 2", notes: "", exercises: [deadlift, curls], userId: 1)
        let workout3 = Workout(id: 1, date: "", name: "Workout 3", notes: "",exercises: [squats, situp], userId: 1)
        let workout4 = Workout(id: 1, date: "", name: "Workout 4", notes: "", exercises: [jumpropes], userId: 1)
        
        exercises = [squats, jumpropes, bench, deadlift, dips, situp, overheadpress, curls]
        workouts = [workout1, workout2, workout3, workout4]

        
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        //setup calendar
        calendar.dataSource = self
        calendar.delegate = self
        calendar.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: view.frame.size.height-300)
        calendar.scrollDirection = .horizontal
        calendar.pagingEnabled = true
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(calendar)
        
        //setup add workout button
        editButton = UIButton()
        editButton.setTitle("Log Session", for: .normal)
        editButton.setTitleColor(.black, for: .normal)
        editButton.titleLabel?.font =  .boldSystemFont(ofSize: 16)
        editButton.addTarget(self, action: #selector(displayEditingCalendar), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(toggleButtonText), for: .touchUpInside)
        view.addSubview(editButton)
    }
    func setupConstraints(){
        editButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(calendar.snp.bottom).offset(20)
            make.height.equalTo(30)
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let currentDate = formatter.string(from: date)
        print("\(currentDate)")
    
        if (inEditingMode) {
            presentEditLog(date: date)
        }
        else {
            let workout1 = Workout(id: 1, date: "", name: "Workout 1", notes: "", exercises: [bench, overheadpress, dips], userId: 1)
            presentInfoLog(date: date, workouts: workouts, workout: completeWorkoutLog[date] ?? workout1)
        }
    }
    @objc func toggleButtonText(){
        if editButton.titleLabel?.text == "Log Session" {
            editButton.setTitle("View Session", for: .normal)
        }
        else {
            editButton.setTitle("Log Session", for: .normal)
        }
    }
    @objc func displayEditingCalendar(){
        inEditingMode = true
        // Change color of UIButton and display of calendar
    }
    func presentEditLog(date: Date) {
        let vc = EditLogViewController(delegate:self, dateToDisplay: date, workoutsToDisplay: workouts)
        present(vc, animated: true, completion: nil)
    }
    func presentInfoLog(date: Date, workouts: [Workout], workout: Workout) {
        let vc = InfoLogViewController(delegate:self, dateToDisplay: date, workoutToDisplay: workout)
        present(vc, animated: true, completion: nil)
    }
    func displayErrorMessage(){
        
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
