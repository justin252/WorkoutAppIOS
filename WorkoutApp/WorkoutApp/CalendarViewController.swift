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
    
    var workoutsCompleted : [Date : Workout] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        calendar.dataSource = self
        calendar.delegate = self
        calendar.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: view.frame.size.height-300)
        calendar.scrollDirection = .horizontal
        calendar.pagingEnabled = true
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")

        view.addSubview(calendar)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let currentDate = formatter.string(from: date)
        print("\(currentDate)")
    
        let vc = LogWorkoutViewController(delegate: self, dateToDisplay: date)
        present(vc, animated: true, completion: nil)
        
        //        vc.hidesBottomBarWhenPushed = true
        //        self.navigationController?.pushViewController(vc, animated: true)
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
