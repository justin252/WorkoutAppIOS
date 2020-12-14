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
    var ex : ExpandedExercise?
    var titleView: UILabel!
    var workoutImageView : UIImageView!
    
    var workoutName : UITextField!
    
    var muscleGroupLabel : UILabel!
    var muscleGroupTitle : UITextField!
    var button: UIButton!


    init(delegate: SaveNewExerciseDelegate?, ex: ExpandedExercise?, index: Int?) {
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
        
        muscleGroupTitle = UITextField()
        muscleGroupTitle.translatesAutoresizingMaskIntoConstraints = false
        muscleGroupTitle.font = .systemFont(ofSize: 20)
        muscleGroupTitle.text = "Muscle Target: \(ex!.muscleTarget)"
        muscleGroupTitle.textColor = .white
        muscleGroupTitle.backgroundColor = .black
        view.addSubview(muscleGroupTitle)
        
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Dismiss", for: .normal)
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
        // button constraints
        NSLayoutConstraint.activate([
            workoutName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            workoutName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //songTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            workoutName.heightAnchor.constraint(equalToConstant: 48)
            ])
        
        NSLayoutConstraint.activate([
            muscleGroupTitle.topAnchor.constraint(equalTo: workoutName.bottomAnchor, constant: 16),
            muscleGroupTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //artistTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            muscleGroupTitle.heightAnchor.constraint(equalToConstant: 48)
            ])
        
        NSLayoutConstraint.activate([
            workoutImageView.topAnchor.constraint(equalTo: muscleGroupTitle.bottomAnchor, constant: 20),
            workoutImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            workoutImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            workoutImageView.heightAnchor.constraint(equalToConstant: 400)
        ])

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: workoutImageView.bottomAnchor, constant: 16),
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
