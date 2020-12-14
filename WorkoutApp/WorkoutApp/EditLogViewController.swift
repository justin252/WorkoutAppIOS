//
//  LogWorkoutViewController.swift
//  WorkoutApp
//
//  Created by Justin on 2020/12/13.
//

import UIKit
import SnapKit

// TODO: Send Workout with updated reps, sets, and weight fields to API

class ExerciseNameCell: UITableViewCell {
    static let identifier = "ExerciseNameCell"
    var ExerciseNameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        ExerciseNameLabel = UILabel()
        ExerciseNameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        contentView.addSubview(ExerciseNameLabel)
        setupConstraints()

    }
    func setupConstraints(){
        ExerciseNameLabel.snp.makeConstraints{ make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    func configure (exerciseName: String){
        ExerciseNameLabel.text = exerciseName
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SetsRepsWeightLabelsCell: UITableViewCell {
    static let identifier = "SRWLabelsCell"
    var setsLabel: UILabel!
    var repsLabel: UILabel!
    var weightLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
            
        setsLabel = UILabel()
        setsLabel.text = "Sets"
        contentView.addSubview(setsLabel)
        
        repsLabel = UILabel()
        repsLabel.text = "Reps"
        contentView.addSubview(repsLabel)
        
        weightLabel = UILabel()
        weightLabel.text = "Weight"
        contentView.addSubview(weightLabel)
        setupConstraints()
    }
    func setupConstraints(){
        setsLabel.snp.makeConstraints{ make in
            make.leading.equalTo(contentView.snp.leading).offset(50)
            make.height.equalTo(contentView)
        }
        repsLabel.snp.makeConstraints{ make in
            make.centerX.equalTo(contentView)
            make.height.equalTo(contentView)
        }
        weightLabel.snp.makeConstraints{ make in
            make.trailing.equalTo(contentView.snp.trailing).inset(45)
            make.height.equalTo(contentView)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class SetsRepsWeightFieldsCell: UITableViewCell {
    static let identifier = "SRWFieldsCell"
    var setsNumberField: UITextField!
    var repsNumberField: UITextField!
    var weightAmountField: UITextField!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setsNumberField = UITextField()
        setsNumberField.backgroundColor = .systemGray4
        setsNumberField.layer.cornerRadius = 8
        setsNumberField.textAlignment = .center
        contentView.addSubview(setsNumberField)
        
        repsNumberField = UITextField()
        repsNumberField.backgroundColor = .systemGray4
        repsNumberField.layer.cornerRadius = 8
        repsNumberField.textAlignment = .center
        contentView.addSubview(repsNumberField)
        
        weightAmountField = UITextField()
        weightAmountField.backgroundColor = .systemGray4
        weightAmountField.layer.cornerRadius = 8
        weightAmountField.textAlignment = .center
        contentView.addSubview(weightAmountField)
        setupConstraints()
    }
    func setupConstraints(){
        setsNumberField.snp.makeConstraints{ make in
            make.leading.equalTo(contentView).offset(35)
            make.width.equalTo(70)
            make.height.equalTo(contentView).offset(-5)
        }
        repsNumberField.snp.makeConstraints{ make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(70)
            make.height.equalTo(contentView).offset(-5)
        }
        
        weightAmountField.snp.makeConstraints{ make in
            make.trailing.equalTo(contentView).inset(35)
            make.width.equalTo(70)
            make.height.equalTo(contentView).offset(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class AddSetCell: UITableViewCell {
    static let identifier = "AddSetCell"
    var AddSetButton: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        AddSetButton = UIButton()
        AddSetButton.setTitle("Add Set", for: .normal)
        AddSetButton.backgroundColor = .systemBlue
        AddSetButton.addTarget(self, action: #selector(AddSet), for: .touchUpInside)
        contentView.addSubview(AddSetButton)
        setupConstraints()
    }
    func setupConstraints(){
        AddSetButton.snp.makeConstraints{ make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(contentView).inset(35)
        }
    }
//    Add a set
    @objc func AddSet(){
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class MenuCell : UITableViewCell {
}
class EditLogViewController: UIViewController {
    weak var delegate: LogWorkoutDelegate?
    var saveButton: UIButton!
    var deleteButton: UIButton!
    var dateLabel: UILabel!
    var menuButton: UIButton!
    var currentDate: Date
    let workoutItems: [Workout]
    var notesTextField: UITextField!
    var noWorkoutSelected: Bool = true
    
//    var additionalCells: Int = 0 //update every time a new cell is added
//    var numElementsPerExercise : [String : Int]
    var defaultExercise = Exercise(id: 1, name: "Squats", seen: false, sets: [])
    init(delegate: LogWorkoutDelegate?, dateToDisplay: Date, workoutsToDisplay: [Workout]){
        self.currentDate = dateToDisplay
        self.workoutItems = workoutsToDisplay
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Sort in alphabetical order
    var workoutNames : [String] = []

    var workoutToLog: Workout!
    let transparentView = UIView()
    let dropdownTableView = UITableView()
    var selectedButton = UIButton()
    let logTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
        
    }
    
    @objc func addTransparentView(frames: CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? view.frame
        view.addSubview(transparentView)
        
        dropdownTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        view.addSubview(dropdownTableView)
        dropdownTableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        dropdownTableView.reloadData()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {self.transparentView.alpha = 0.5
            self.dropdownTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.workoutNames.count * 50))
        }, completion: nil)
    }
    func setupViews(){
        // Display the date
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MM/dd/YYYY"
        let dateString = formatter.string(from: currentDate)
        let dateLabelTitle = "Edit Log for " + dateString
        
        
        
        
        //dateLabel
        dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 24, weight: .bold)
        dateLabel.text = dateLabelTitle
        dateLabel.textColor = .black
        view.addSubview(dateLabel)
        
        //dropdown menu
        menuButton = UIButton()
        menuButton.setTitle("Workout 1", for: .normal)
        menuButton.backgroundColor = .systemBlue
        menuButton.addTarget(self, action: #selector(addTransparentViewHelper), for: .touchUpInside)
        view.addSubview(menuButton)
        
        dropdownTableView.delegate = self
        dropdownTableView.dataSource = self
        dropdownTableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        
        //notes
        notesTextField = UITextField()
        notesTextField.text = "Notes"
        notesTextField.textAlignment = .center
        notesTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        notesTextField.delegate = self
        view.addSubview(notesTextField)
        
        //logger
        logTableView.delegate = self
        logTableView.dataSource = self
        view.addSubview(logTableView)
        logTableView.separatorColor = .clear
        logTableView.register(ExerciseNameCell.self, forCellReuseIdentifier: ExerciseNameCell.identifier)
        logTableView.register(SetsRepsWeightLabelsCell.self, forCellReuseIdentifier: SetsRepsWeightLabelsCell.identifier)
        logTableView.register(SetsRepsWeightFieldsCell.self, forCellReuseIdentifier: SetsRepsWeightFieldsCell.identifier)
        logTableView.register(AddSetCell.self, forCellReuseIdentifier: AddSetCell.identifier)

        //save button
        saveButton = UIButton()
        saveButton.setTitle("Save Session", for: .normal)
        saveButton.backgroundColor = .systemGreen
        saveButton.layer.cornerRadius = 8
        saveButton.addTarget(self, action: #selector(exitLogAndSave), for: .touchUpInside)
        view.addSubview(saveButton)
        
        //delete button
        deleteButton = UIButton()
        deleteButton.setTitle("Delete Session", for: .normal)
        deleteButton.backgroundColor = .systemRed
        deleteButton.layer.cornerRadius = 8
        deleteButton.addTarget(self, action: #selector(exitLogAndDelete), for: .touchUpInside)
        view.addSubview(deleteButton)
        
    }
    func setupConstraints(){
        dateLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(15)
        }
        menuButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.width.equalToSuperview().dividedBy(1.25)
        }
        notesTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.equalTo(menuButton.snp.bottom).offset(10)
        }
        logTableView.snp.makeConstraints{ make in
            make.top.equalTo(notesTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(150)
        }
        saveButton.snp.makeConstraints{ make in
            make.top.equalTo(logTableView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        deleteButton.snp.makeConstraints{ make in
            make.top.equalTo(saveButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
    }
    @objc func addTransparentViewHelper(){
        //sort in alphabetical order
        workoutNames = []
        for workout in workoutItems{
            workoutNames.append(workout.name)
        }
        selectedButton = menuButton
        addTransparentView(frames: menuButton.frame)
    }
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {self.transparentView.alpha = 0
            self.dropdownTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    @objc func exitLogAndSave(){
//        if let text = arenaNameField.text, text != "" {
//            delegate?.saveNewName(newName: text)
            dismiss(animated: true, completion: nil)
//        }
    }
    @objc func exitLogAndDelete(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func textFieldDidBeginEditing(textField: UITextField) {
        if textField == notesTextField {
            textField.text = ""
        }
    }
    

}
extension EditLogViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        notesTextField.resignFirstResponder()
        return true
    }
}

extension EditLogViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case dropdownTableView:
            return workoutItems.count
        case logTableView:
            if let workoutToLog = workoutToLog {
                let exercisesCount = workoutToLog.exercises.count
                return 4 * exercisesCount
            }
            else {
                return 1
            }
        default:
            return 0
        }
       
    }
    func exercisesCount(workoutToLog: Workout?) -> Int {
        if let workoutToLog = workoutToLog {
            let exercisesCount = workoutToLog.exercises.count
            return exercisesCount
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
            
            case dropdownTableView:
                let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
                cell.textLabel?.text = workoutNames[indexPath.row]
                return cell
                
            case logTableView:
//                let n = exercisesCount(workoutToLog: workoutToLog)
                if (!noWorkoutSelected){
                    let r = indexPath.row
                    let order = r % 4
                    // deal with nil value
                    
                    var currentExercise = defaultExercise
    //                var exercisesCount = 0
                    if let workoutToLog = workoutToLog {
    //                    exercisesCount = workoutToLog.exercises.count
                        currentExercise = workoutToLog.exercises[r/4]
                    }
                    switch order {
                    case 0:
                        let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseNameCell.identifier, for: indexPath) as! ExerciseNameCell
                        let name = currentExercise.name
                        cell.configure(exerciseName: name)
                        return cell
                    case 1:
                        let cell = tableView.dequeueReusableCell(withIdentifier: SetsRepsWeightLabelsCell.identifier, for: indexPath) as! SetsRepsWeightLabelsCell
                        return cell
                    case 2:
                        let cell = tableView.dequeueReusableCell(withIdentifier: SetsRepsWeightFieldsCell.identifier, for: indexPath) as! SetsRepsWeightFieldsCell
                        return cell
                    default:
                        let cell = UITableViewCell()
                        cell.selectionStyle = .none
                        return cell
                }
                }
        default:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            return cell
        }
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView{
        case dropdownTableView:
            return 50
        case logTableView:
            return 30
        default:
            return 50
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case dropdownTableView:
            menuButton.setTitle(workoutItems[indexPath.row].name, for: .normal)
            workoutToLog = workoutItems[indexPath.row]
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd"
            let dateString = formatter.string(from: currentDate)
            
            let string = workoutToLog.name + " - " + dateString
            dateLabel.text = string
            removeTransparentView()
            noWorkoutSelected = false
            notesTextField.text = "Notes"
            logTableView.reloadData()
            
        case logTableView:
            return
        default:
            return
        }
        
    }
}

