//
//  ExerciseTableViewCell.swift
//  iOSFinalProject
//
//  Created by Tucker Stanley on 12/12/20.
//
import UIKit

class ExerciseTableViewCell: UITableViewCell {
    var workoutImage : UIImageView!
    var workoutName : UILabel!
    var muscleGroup : UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        
        workoutImage = UIImageView(image: UIImage(named: ""))
        workoutImage.translatesAutoresizingMaskIntoConstraints = false
        workoutImage.contentMode = .scaleAspectFit
        //coverImageView.isHidden = true
        contentView.addSubview(workoutImage)
        
        workoutName = UILabel()
        workoutName.translatesAutoresizingMaskIntoConstraints = false
        workoutName.font = .systemFont(ofSize: 16, weight: .bold)
        workoutName.textColor = .black
        contentView.addSubview(workoutName)
        

        muscleGroup = UILabel()
        muscleGroup.translatesAutoresizingMaskIntoConstraints = false
        muscleGroup.font = .systemFont(ofSize: 12)
        muscleGroup.textColor = .black
        contentView.addSubview(muscleGroup)

        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {

        let padding: CGFloat = 8
        //let heartImageWidth: CGFloat = 20
        let labelHeight: CGFloat = 25

        NSLayoutConstraint.activate([
            workoutImage.heightAnchor.constraint(equalToConstant: 75),
            workoutImage.widthAnchor.constraint(equalToConstant: 75),
            workoutImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            workoutImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            workoutName.leadingAnchor.constraint(equalTo: workoutImage.trailingAnchor, constant: padding),
            workoutName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            workoutName.heightAnchor.constraint(equalToConstant: labelHeight)
        ])

        NSLayoutConstraint.activate([
            muscleGroup.leadingAnchor.constraint(equalTo: workoutImage.trailingAnchor, constant: padding),
            muscleGroup.topAnchor.constraint(equalTo: workoutName.bottomAnchor),
            muscleGroup.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
    }

    func configure(for ex: ExpandedExercise) {
        workoutName.text = ex.name
        muscleGroup.text = "Muscle Group: \(ex.muscleTarget)"
        workoutImage.image = UIImage(named: ex.imageName)
    }

}
