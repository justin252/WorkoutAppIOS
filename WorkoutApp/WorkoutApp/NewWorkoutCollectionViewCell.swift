//
//  NewWorkoutCollectionViewCell.swift
//  WorkoutApp
//
//  Created by Ethan Stanley on 12/12/20.
//

import UIKit

class NewWorkoutCollectionViewCell: UICollectionViewCell {
    var nameLabel: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.backgroundColor = .white
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        nameLabel.textAlignment = .center
        nameLabel.textColor = .black
        contentView.addSubview(nameLabel)
        
        setupConstraints()
    }
    func changeColor(seen: Bool){
        if(!seen){
            contentView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        else{
            contentView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
    }
    func setupConstraints(){
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    func configure (exercise: Exercise){
        nameLabel.text = exercise.name
        if(!exercise.seen){
            contentView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        else{
            contentView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
