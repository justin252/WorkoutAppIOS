//
//  LogInfoViewController.swift
//  WorkoutApp
//
//  Created by Justin on 2020/12/13.
//

import Foundation
import UIKit

class SetsRepsWeightValuesCell: UITableViewCell {
    static let identifier = "SRWValuesCell"
    var setsNumberLabel: UILabel!
    var repsNumberLabel: UILabel!
    var weightAmountLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setsNumberLabel = UILabel()
        setsNumberLabel.backgroundColor = .systemTeal
        setsNumberLabel.layer.cornerRadius = 8
        setsNumberLabel.textAlignment = .center
        contentView.addSubview(setsNumberLabel)
        
        repsNumberLabel = UILabel()
        repsNumberLabel.backgroundColor = .systemTeal
        repsNumberLabel.layer.cornerRadius = 8
        repsNumberLabel.textAlignment = .center
        contentView.addSubview(repsNumberLabel)
        
        weightAmountLabel = UILabel()
        weightAmountLabel.backgroundColor = .systemTeal
        weightAmountLabel.layer.cornerRadius = 8
        weightAmountLabel.textAlignment = .center
        contentView.addSubview(weightAmountLabel)
        setupConstraints()
    }
    func setupConstraints(){
        setsNumberLabel.snp.makeConstraints{ make in
            make.leading.equalTo(contentView).offset(35)
            make.width.equalTo(70)
            make.height.equalTo(contentView).offset(-5)
        }
        repsNumberLabel.snp.makeConstraints{ make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(70)
            make.height.equalTo(contentView).offset(-5)
        }
        
        weightAmountLabel.snp.makeConstraints{ make in
            make.trailing.equalTo(contentView).inset(35)
            make.width.equalTo(70)
            make.height.equalTo(contentView).offset(-5)
        }
    }
    func configure (sets : Int, reps: Int, weight: String){
        setsNumberLabel.text = String(sets)
        repsNumberLabel.text = String(reps)
        weightAmountLabel.text = weight
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//InfoViewController
class InfoLogViewController: UIViewController {
    var dateLabel: UILabel!
    var dateToDisplay: String
    var workoutToDisplay: Workout
    var exitButton: UIButton!
    var notesTextView = UITextView()
    var notes: String?
    var worknum: [String] = []
    var sets: [Int] = []
    var reps: [Int] = []
    var weight: [String] = []
    
    // Assumes that date has already been processed as a string and grabs it from the API
    init(dateToDisplay: String, workoutToDisplay: Workout){
        self.dateToDisplay = dateToDisplay
        self.workoutToDisplay = workoutToDisplay
        self.notes = workoutToDisplay.notes
        super.init(nibName: nil, bundle: nil)
        getWorkouts(dateDisp: dateToDisplay)

        
        //self.sets = workoutToDisplay.exercises[0].sets[0].number
        //self.reps = workoutToDisplay.exercises[0].sets[0].reps
        //self.weight = workoutToDisplay.weight
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let infoTableView = UITableView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
    func setupViews(){
        // Display the date
        let dateLabelTitle = "View session on " + dateToDisplay
        
        //dateLabel
        dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 24, weight: .bold)
        dateLabel.text = dateLabelTitle
        dateLabel.textColor = .black
        view.addSubview(dateLabel)
        
        //notes - get from API
        notesTextView.textAlignment = .center
        view.addSubview(notesTextView)
        
        //info table view
        infoTableView.delegate = self
        infoTableView.dataSource = self
        view.addSubview(infoTableView)
        infoTableView.separatorColor = .clear
        infoTableView.register(ExerciseNameCell.self, forCellReuseIdentifier: ExerciseNameCell.identifier)
        infoTableView.register(SetsRepsWeightLabelsCell.self, forCellReuseIdentifier: SetsRepsWeightLabelsCell.identifier)
        infoTableView.register(SetsRepsWeightValuesCell.self, forCellReuseIdentifier: SetsRepsWeightValuesCell.identifier)
        
        //exit button
        exitButton = UIButton()
        exitButton.setTitle("Exit", for: .normal)
        exitButton.backgroundColor = .lightGray
        exitButton.layer.cornerRadius = 8
        exitButton.addTarget(self, action: #selector(exitInfoLog), for: .touchUpInside)
        view.addSubview(exitButton)
        
        infoTableView.register(SetsRepsWeightFieldsCell.self, forCellReuseIdentifier: SetsRepsWeightFieldsCell.identifier)
        infoTableView.register(AddSetCell.self, forCellReuseIdentifier: AddSetCell.identifier)
    }
    func setupConstraints(){
        dateLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(15)
        }
        notesTextView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
        }
        infoTableView.snp.makeConstraints{ make in
            make.top.equalTo(notesTextView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(150)
        }
        exitButton.snp.makeConstraints{ make in
            make.top.equalTo(infoTableView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    @objc func exitInfoLog() {
        dismiss(animated: true, completion: nil)
    }
    private func getWorkouts(dateDisp: String) {
        var workouts: [Workout] = []
        NetworkManager.getWorkouts() { workouts2 in
            workouts = workouts2
        }
        for workout in workouts{
            if(workout.date == dateDisp){
                worknum.append(workout.name)
                sets.append(workout.exercises[0].sets[0].number)
                reps.append(workout.exercises[0].sets[0].reps)
                weight.append(workout.exercises[0].sets[0].weight)
            }
        }
        
    }

}
extension InfoLogViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let exercisesCount = workoutToDisplay.exercises.count
            return 4 * exercisesCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let r = indexPath.row
        let order = r % 4
        // no nil value
        
        let currentExercise = workoutToDisplay.exercises[r/4]
        switch order {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseNameCell.identifier, for: indexPath) as! ExerciseNameCell
            let name = currentExercise.name
            cell.configure(exerciseName: name)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SetsRepsWeightLabelsCell.identifier, for: indexPath) as! SetsRepsWeightLabelsCell
            return cell
        // this is where data from the API comes in for the reps and sets. It will configure the cell based on the proper value from the sets, reps, and weight arrays.
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: SetsRepsWeightValuesCell.identifier, for: indexPath) as! SetsRepsWeightValuesCell
            //cell.configure(sets: sets[r/4], reps: [r/4], weight: weight[r/4])
            return cell
        default:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
}
