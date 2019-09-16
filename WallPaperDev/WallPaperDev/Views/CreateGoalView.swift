//
//  CreateGoalView.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/10/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class CreateGoalView: UIView {
    
    let goalNameLabel = BlueLabel(frame: .zero)
    let goalDescriptionLabel = BlueLabel(frame: .zero)
    let createButton = BigBlueButton(frame: .zero)
    
    let goalNameTextField: GoalNameTextField = {
        let textField = GoalNameTextField(frame: .zero)
        textField.font = UIFont(name: "HelveticaNeue", size: 25)
        textField.placeholder = "Climbing Mount Everest"
        //        textField.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        //        textField.layer.shadowRadius = 3
        //        textField.layer.shadowOpacity = 1
        //        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        return textField
    }()
    
    let goalDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textView.layer.borderWidth = 1
        textView.font = UIFont(name: "HelveticaNeue", size: 25)
        
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        _configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _configView() {
        addSubview(goalNameLabel)
        addSubview(goalNameTextField)
        addSubview(goalDescriptionLabel)
        addSubview(goalDescriptionTextView)
        addSubview(createButton)
        _setupGoalNameLabel()
        goalNameTextFieldConstraints()
        _setupDescriptionLabel()
        goalDescriptionTextViewConstraints()
        _setupBlueButton()
    }
}

// MARK: setup UI functions
extension CreateGoalView {
    
    private func _setupGoalNameLabel() {
        goalNameLabel.text = "Goal Name"
        NSLayoutConstraint.activate([
            goalNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            goalNameLabel.heightAnchor.constraint(equalToConstant: 50),
            goalNameLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            goalNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 20)
            ])
    }
    
    func goalNameTextFieldConstraints() {
        goalNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goalNameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            goalNameTextField.heightAnchor.constraint(equalToConstant: 50),
            goalNameTextField.leftAnchor.constraint(equalTo: goalNameLabel.leftAnchor),
            goalNameTextField.topAnchor.constraint(equalToSystemSpacingBelow: goalNameLabel.topAnchor, multiplier: 6)
            ])
    }
    
    private func _setupDescriptionLabel() {
        goalDescriptionLabel.text = "Goal Description"
        NSLayoutConstraint.activate([
            goalDescriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            goalDescriptionLabel.heightAnchor.constraint(equalToConstant: 50),
            goalDescriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: goalNameTextField.bottomAnchor,
                                                      multiplier: 3),
            goalDescriptionLabel.leftAnchor.constraint(equalTo: goalNameTextField.leftAnchor)
            ])
    }
    
    func goalDescriptionTextViewConstraints() {
        goalDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goalDescriptionTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            goalDescriptionTextView.heightAnchor.constraint(equalTo: goalNameTextField.heightAnchor, multiplier: 3),
            goalDescriptionTextView.topAnchor.constraint(equalToSystemSpacingBelow: goalDescriptionLabel.topAnchor, multiplier: 6),
            goalDescriptionTextView.leftAnchor.constraint(equalTo: goalDescriptionLabel.leftAnchor)
            ])
    }
    
    private func _setupBlueButton() {
        createButton.setTitle("Create", for: .normal)
        NSLayoutConstraint.activate([
            createButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            createButton.heightAnchor.constraint(equalToConstant: 50),
            createButton.topAnchor.constraint(equalToSystemSpacingBelow: goalDescriptionTextView.bottomAnchor,
                                              multiplier: 15),
            createButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
    }
}
