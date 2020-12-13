//
//  EditExerciseViewController.swift
//  iOSFinalProject
//
//  Created by Tucker Stanley on 12/12/20.
//
import UIKit

class EditExerciseViewController: UIViewController {

    weak var delegate: SaveNewExerciseDelegate?
    
    var index: Int?
    var ex : Exercise?
    var titleView: UILabel!
    var workoutImageView : UIImageView!
    
    var workoutName : UITextField!
    
    var muscleGroupLabel : UILabel!
    var muscleGroupTitle : UITextField!
    var button: UIButton!


    init(delegate: SaveNewExerciseDelegate?, ex: Exercise?, index: Int?) {
        super.init(nibName: nil, bundle: nil)
        self.ex = ex
        self.delegate = delegate
        self.index = index
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        titleView = UILabel()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.font = .systemFont(ofSize: 25, weight: .bold)
        titleView.text = "Edit Exercise"
        titleView.textColor = .white
        view.addSubview(titleView)
        
        workoutImageView = UIImageView(image: UIImage(named: ex?.imageName ?? "" ))
        workoutImageView.translatesAutoresizingMaskIntoConstraints = false
        workoutImageView.contentMode = .scaleAspectFit
        //workoutImageView.isHidden = true
        view.addSubview(workoutImageView)

        workoutName = UITextField()
        workoutName.translatesAutoresizingMaskIntoConstraints = false
        workoutName.font = .systemFont(ofSize: 40, weight: .bold)
        workoutName.text = ex?.name
        workoutName.textColor = .white
        workoutName.backgroundColor = .black
        view.addSubview(workoutName)
        
        muscleGroupLabel = UILabel()
        muscleGroupLabel.translatesAutoresizingMaskIntoConstraints = false
        muscleGroupLabel.font = .systemFont(ofSize: 20)
        muscleGroupLabel.text = "Muscle Target: "
        muscleGroupLabel.textColor = .white
        muscleGroupLabel.backgroundColor = .black
        view.addSubview(muscleGroupLabel)
        
        muscleGroupTitle = UITextField()
        muscleGroupTitle.translatesAutoresizingMaskIntoConstraints = false
        muscleGroupTitle.font = .systemFont(ofSize: 20)
        muscleGroupTitle.text = ex?.muscleTarget
        muscleGroupTitle.textColor = .white
        muscleGroupTitle.backgroundColor = .black
        view.addSubview(muscleGroupTitle)
        
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Dismiss and save text", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(dismissViewControllerAndSaveText), for: .touchUpInside)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        view.addSubview(button)


        setupConstraints()
        // Do any additional setup after loading the view.
    }
    func setupConstraints() {
        // textField constraints
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            workoutImageView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20),
            workoutImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            workoutImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            workoutImageView.heightAnchor.constraint(equalToConstant: 400),
            workoutImageView.widthAnchor.constraint(equalToConstant: 400),


            ])

        // button constraints
        NSLayoutConstraint.activate([
            workoutName.topAnchor.constraint(equalTo: workoutImageView.bottomAnchor, constant: 16),
            workoutName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //songTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            workoutName.heightAnchor.constraint(equalToConstant: 48)
            ])
        
        NSLayoutConstraint.activate([
            muscleGroupLabel.topAnchor.constraint(equalTo: workoutName.bottomAnchor, constant: 16),
            muscleGroupLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 110),
            //artistLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            muscleGroupLabel.heightAnchor.constraint(equalToConstant: 48)
            ])
        
        
        NSLayoutConstraint.activate([
            muscleGroupTitle.topAnchor.constraint(equalTo: workoutName.bottomAnchor, constant: 16),
            muscleGroupTitle.leadingAnchor.constraint(equalTo: muscleGroupLabel.trailingAnchor, constant: 10),
            //artistTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            muscleGroupTitle.heightAnchor.constraint(equalToConstant: 48)
            ])
        
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: muscleGroupTitle.bottomAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 48),
            button.widthAnchor.constraint(equalToConstant: 200)
            ])
    }

    @objc func dismissViewControllerAndSaveText() {
        // If let statements can also chain boolean checks after them, like a normal if statement.
        delegate?.saveNewEx(newName: workoutName.text, newMuscleTarget: muscleGroupTitle.text, index: index)
            
            dismiss(animated: true, completion: nil)
        // To dismiss something modally, we use the dismiss(animated:completion) command.
    }

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
