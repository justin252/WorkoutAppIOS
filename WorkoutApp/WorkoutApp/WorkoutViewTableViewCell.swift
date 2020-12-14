//
//  WorkoutViewTableViewCell.swift
//  WorkoutApp
//
//  Created by Tucker Stanley on 12/13/20.
//

import UIKit

class WorkoutViewTableViewCell: UITableViewCell {

    var workoutName : UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        
        workoutName = UILabel()
        workoutName.translatesAutoresizingMaskIntoConstraints = false
        workoutName.font = .systemFont(ofSize: 25, weight: .regular)
        workoutName.textColor = .black
        contentView.addSubview(workoutName)
        

        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {

        //let padding: CGFloat = 8
        //let heartImageWidth: CGFloat = 20
        let labelHeight: CGFloat = 25


        
        NSLayoutConstraint.activate([
            workoutName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            workoutName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            workoutName.heightAnchor.constraint(equalToConstant: labelHeight)
        ])

        
    }

    func configure(for ex: Exercise) {
        workoutName.text = ex.name
    }

}
