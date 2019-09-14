//
//  CreateGoalView.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/10/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class CreateGoalView: UIView {
  
  let goalNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Goal Name"
    label.textAlignment = .left
    label.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    label.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
    return label
  }()
  
  let goalNameTextField: UITextField = {
    let textField = UITextField()
    textField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    textField.layer.borderWidth = 1
    textField.font = UIFont(name: "HelveticaNeue", size: 25)
    
    //        textField.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    //        textField.layer.shadowRadius = 3
    //        textField.layer.shadowOpacity = 1
    //        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
    return textField
  }()
  
  let goalDescriptionLabel: UILabel = {
    
    let label = UILabel()
    label.text = "Description"
    label.textAlignment = .left
    label.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    label.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
    return label
  }()
  
  let goalDescriptionTextView: UITextView = {
    let textView = UITextView()
    textView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    textView.layer.borderWidth = 1
    textView.font = UIFont(name: "HelveticaNeue", size: 25)
    return textView
  }()
  
  let createButton: UIButton = {
    let button = UIButton()
    button.setTitle("Create", for: .normal)
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
    button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .highlighted)
    button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    button.layer.cornerRadius = 25
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    configView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configView() {
    
    addSubview(goalNameLabel)
    addSubview(goalNameTextField)
    addSubview(goalDescriptionLabel)
    addSubview(goalDescriptionTextView)
    addSubview(createButton)
    goalNameConstraints()
    goalNameTextFieldConstraints()
    goalDescriptionConstraints()
    goalDescriptionTextViewConstraints()
    buttonConstraints()
  }
}

extension CreateGoalView {
  
  func goalNameConstraints() {
    
    goalNameLabel.translatesAutoresizingMaskIntoConstraints = false
    goalNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
    goalNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    goalNameLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2).isActive = true
    goalNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 20).isActive = true
  }
  
  func goalNameTextFieldConstraints() {
    
    goalNameTextField.translatesAutoresizingMaskIntoConstraints = false
    goalNameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
    goalNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    goalNameTextField.leftAnchor.constraint(equalTo: goalNameLabel.leftAnchor).isActive = true
    goalNameTextField.topAnchor.constraint(equalToSystemSpacingBelow: goalNameLabel.topAnchor, multiplier: 6).isActive = true
  }
  
  func goalDescriptionConstraints() {
    
    goalDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    goalDescriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
    goalDescriptionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    goalDescriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: goalNameTextField.bottomAnchor, multiplier: 3).isActive = true
    goalDescriptionLabel.leftAnchor.constraint(equalTo: goalNameTextField.leftAnchor).isActive = true
  }
  
  func goalDescriptionTextViewConstraints() {
    
    goalDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
    goalDescriptionTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
    goalDescriptionTextView.heightAnchor.constraint(equalTo: goalNameTextField.heightAnchor, multiplier: 3).isActive = true
    goalDescriptionTextView.topAnchor.constraint(equalToSystemSpacingBelow: goalDescriptionLabel.topAnchor, multiplier: 6).isActive = true
    goalDescriptionTextView.leftAnchor.constraint(equalTo: goalDescriptionLabel.leftAnchor).isActive = true
  }
  
  func buttonConstraints() {
    
    createButton.translatesAutoresizingMaskIntoConstraints = false
    createButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
    createButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    createButton.topAnchor.constraint(equalToSystemSpacingBelow: goalDescriptionTextView.bottomAnchor, multiplier: 15).isActive = true
    createButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
  }
}
