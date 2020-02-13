//
//  CreateGoalView.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/10/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class CreateGoalView: UIView {
  // MARK: - Custom UIViews

  lazy var goalNameLabel = BlueLabel(frame: .zero)
  lazy var goalDescriptionLabel = BlueLabel(frame: .zero)
  lazy var createButton = BigBlueButton(frame: .zero)
  lazy var goalNameTextField = GoalNameTextField(frame: .zero)
  lazy var goalDescriptionTextView = GoalDescriptionTextView(frame: .zero, textContainer: nil)

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    setupViews()
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup UI functions

extension CreateGoalView {
  private func setupViews() {
    addSubview(goalNameLabel)
    addSubview(goalNameTextField)
    addSubview(goalDescriptionLabel)
    addSubview(goalDescriptionTextView)
    addSubview(createButton)
    _setupGoalNameLabel()
    _goalNameTextFieldConstraints()
    _setupDescriptionLabel()
    _goalDescriptionTextViewConstraints()
    _setupBlueButton()
  }

  private func _setupGoalNameLabel() {
    goalNameLabel.text = "Goal Name"
    NSLayoutConstraint.activate([
      goalNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
      goalNameLabel.heightAnchor.constraint(equalToConstant: 50),
      goalNameLabel.leftAnchor.constraint(equalToSystemSpacingAfter: leftAnchor, multiplier: 2),
      goalNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 20)
        ])
  }

  private func _goalNameTextFieldConstraints() {
    NSLayoutConstraint.activate([
      goalNameTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
      goalNameTextField.heightAnchor.constraint(equalToConstant: 50),
      goalNameTextField.leftAnchor.constraint(equalTo: goalNameLabel.leftAnchor),
      goalNameTextField.topAnchor.constraint(equalToSystemSpacingBelow: goalNameLabel.topAnchor, multiplier: 6)
        ])
  }

  private func _setupDescriptionLabel() {
    goalDescriptionLabel.text = "Goal Description"
    NSLayoutConstraint.activate([
      goalDescriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
      goalDescriptionLabel.heightAnchor.constraint(equalToConstant: 50),
      goalDescriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: goalNameTextField.bottomAnchor,
                                                multiplier: 3),
      goalDescriptionLabel.leftAnchor.constraint(equalTo: goalNameTextField.leftAnchor)
        ])
  }

  private func _goalDescriptionTextViewConstraints() {
    NSLayoutConstraint.activate([
      goalDescriptionTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
      goalDescriptionTextView.heightAnchor.constraint(equalTo: goalNameTextField.heightAnchor, multiplier: 3),
      goalDescriptionTextView.topAnchor.constraint(equalToSystemSpacingBelow: goalDescriptionLabel.topAnchor, multiplier: 6),
      goalDescriptionTextView.leftAnchor.constraint(equalTo: goalDescriptionLabel.leftAnchor)
        ])
  }

  private func _setupBlueButton() {
    createButton.setTitle("Create", for: .normal)
    NSLayoutConstraint.activate([
      createButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
      createButton.heightAnchor.constraint(equalToConstant: 50),
      createButton.topAnchor.constraint(equalToSystemSpacingBelow: goalDescriptionTextView.bottomAnchor,
                                        multiplier: 15),
      createButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
  }
}
