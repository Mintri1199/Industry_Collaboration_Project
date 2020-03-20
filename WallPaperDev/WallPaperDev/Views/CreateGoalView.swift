//
//  CreateGoalView.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/8/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
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
    self.backgroundColor = ApplicationDependency.manager.currentTheme.colors.foregroundWhite
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
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
    setupGoalNameLabel()
    setTextField()
    setupDescriptionLabel()
    setupTextView()
    setupBlueButton()
  }
  
  private func setupGoalNameLabel() {
    goalNameLabel.text = Localized.string("goal_name_title")
    NSLayoutConstraint.activate([
      goalNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
      goalNameLabel.heightAnchor.constraint(equalToConstant: 50),
      goalNameLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
      goalNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 20)
            ])
  }
  
  private func setTextField() {
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    toolbar.barStyle = .default
    toolbar.items = [
      UIBarButtonItem(title: Localized.string("next_action"), style: .plain, target: self, action: #selector(nextButtonTapped)),
      UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    ]
    goalNameTextField.inputAccessoryView = toolbar
    NSLayoutConstraint.activate([
      goalNameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
      goalNameTextField.heightAnchor.constraint(equalToConstant: 50),
      goalNameTextField.leftAnchor.constraint(equalTo: goalNameLabel.leftAnchor),
      goalNameTextField.topAnchor.constraint(equalToSystemSpacingBelow: goalNameLabel.topAnchor, multiplier: 6)
            ])
  }
  
  private func setupDescriptionLabel() {
    goalDescriptionLabel.text = Localized.string("goal_description_title")
    NSLayoutConstraint.activate([
      goalDescriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
      goalDescriptionLabel.heightAnchor.constraint(equalToConstant: 50),
      goalDescriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: goalNameTextField.bottomAnchor,
                                                multiplier: 3),
      goalDescriptionLabel.leftAnchor.constraint(equalTo: goalNameTextField.leftAnchor)
            ])
  }
  
  private func setupTextView() {
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    toolbar.barStyle = .default
    toolbar.items = [
      UIBarButtonItem(title: Localized.string("previous_action"), style: .plain, target: self, action: #selector(prevButtonTapped)),
      UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
      UIBarButtonItem(title: Localized.string("done_action"), style: .done, target: self, action: #selector(doneTapped))
    ]
    goalDescriptionTextView.inputAccessoryView = toolbar
    NSLayoutConstraint.activate([
      goalDescriptionTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
      goalDescriptionTextView.heightAnchor.constraint(equalTo: goalNameTextField.heightAnchor, multiplier: 3),
      goalDescriptionTextView.topAnchor.constraint(equalToSystemSpacingBelow: goalDescriptionLabel.topAnchor, multiplier: 6),
      goalDescriptionTextView.leftAnchor.constraint(equalTo: goalDescriptionLabel.leftAnchor)
            ])
  }
  
  private func setupBlueButton() {
    createButton.setTitle(Localized.string("create_action"), for: .normal)
    NSLayoutConstraint.activate([
      createButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
      createButton.heightAnchor.constraint(equalToConstant: 50),
      createButton.topAnchor.constraint(equalToSystemSpacingBelow: goalDescriptionTextView.bottomAnchor,
                                        multiplier: 15),
      createButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
  }
  
  @objc private func nextButtonTapped() {
    goalDescriptionTextView.becomeFirstResponder()
  }
  
  @objc private func prevButtonTapped() {
    goalNameTextField.becomeFirstResponder()
  }
  
  @objc private func doneTapped() {
    goalDescriptionTextView.resignFirstResponder()
  }
}
