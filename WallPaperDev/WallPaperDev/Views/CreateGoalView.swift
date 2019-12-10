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
    
    lazy var keyboardHeight: CGFloat = 0
    
    // MARK: - Custom UIViews
    lazy var goalNameLabel = BlueLabel(frame: .zero)
    lazy var goalDescriptionLabel = BlueLabel(frame: .zero)
    lazy var milestoneNameLabel = BlueLabel(frame: .zero)
    lazy var milestoneCurNumberLabel = BlueLabel(frame: .zero)
    lazy var milestoneTargetNumberLabel = BlueLabel(frame: .zero)
    lazy var createButton = BigBlueButton(frame: .zero)
    lazy var goalNameTextField = GoalNameTextField(frame: .zero)
    lazy var milestoneNameTextField = GoalNameTextField(frame: .zero)
    lazy var milestoneCurNumberField = MilestoneNumberField(frame: .zero)
    lazy var milestoneTargetNumberField = MilestoneNumberField(frame: .zero)
    lazy var goalDescriptionTextView = GoalDescriptionTextView(frame: .zero, textContainer: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor =  .foregroundWhite
        setupViews()
        setupKeyboardNotifications()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreateGoalView {
    
    private func setupKeyboardNotifications() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // MARK: - Setup UI functions
    
    private func setupViews() {
        addSubview(goalNameLabel)
        addSubview(goalNameTextField)
        addSubview(goalDescriptionLabel)
        addSubview(goalDescriptionTextView)
        addSubview(milestoneNameLabel)
        addSubview(milestoneNameTextField)
        addSubview(milestoneCurNumberLabel)
        addSubview(milestoneCurNumberField)
        addSubview(milestoneTargetNumberLabel)
        addSubview(milestoneTargetNumberField)
        addSubview(createButton)
        setupGoalNameLabel()
        goalNameTextFieldConstraints()
        setupDescriptionLabel()
        goalDescriptionTextViewConstraints()
        setupMilestoneNameLabel()
        milestoneNameTextFieldConstraints()
        setupMilestoneCurNumberLabel()
        curNumberTextFieldConstraints()
        setupMilestoneTargetNumberLabel()
        targetNumberTextFieldConstraints()
        setupBlueButton()
    }
    
    private func setupGoalNameLabel() {
        goalNameLabel.text = "*Goal Name"
        NSLayoutConstraint.activate([
            goalNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            goalNameLabel.heightAnchor.constraint(equalToConstant: 30),
            goalNameLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            goalNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 20)
            ])
    }
    
    private func goalNameTextFieldConstraints() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped)),
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
        goalDescriptionLabel.text = "*Goal Description"
        NSLayoutConstraint.activate([
            goalDescriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            goalDescriptionLabel.heightAnchor.constraint(equalToConstant: 30),
            goalDescriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: goalNameTextField.bottomAnchor,
                                                      multiplier: 2),
            goalDescriptionLabel.leftAnchor.constraint(equalTo: goalNameTextField.leftAnchor)
            ])
    }
    
    private func goalDescriptionTextViewConstraints() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Previous", style: .plain, target: self, action: #selector(prevButtonTapped)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        ]
        goalDescriptionTextView.inputAccessoryView = toolbar
        NSLayoutConstraint.activate([
            goalDescriptionTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            goalDescriptionTextView.heightAnchor.constraint(equalTo: goalNameTextField.heightAnchor, multiplier: 2),
            goalDescriptionTextView.topAnchor.constraint(equalToSystemSpacingBelow: goalDescriptionLabel.topAnchor, multiplier: 6),
            goalDescriptionTextView.leftAnchor.constraint(equalTo: goalDescriptionLabel.leftAnchor)
            ])
    }
    
    private func setupMilestoneNameLabel() {
        milestoneNameLabel.text = "Milestone Name"
        NSLayoutConstraint.activate([
            milestoneNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            milestoneNameLabel.heightAnchor.constraint(equalToConstant: 30),
            milestoneNameLabel.leftAnchor.constraint(equalTo: goalDescriptionLabel.leftAnchor),
            milestoneNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: goalDescriptionTextView.bottomAnchor, multiplier: 2)
        ])
    }
    
    private func milestoneNameTextFieldConstraints() {
        milestoneNameTextField.placeholder = "3 training days"
        NSLayoutConstraint.activate([
            milestoneNameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            milestoneNameTextField.heightAnchor.constraint(equalToConstant: 50),
            milestoneNameTextField.leftAnchor.constraint(equalTo: milestoneNameLabel.leftAnchor),
            milestoneNameTextField.topAnchor.constraint(equalToSystemSpacingBelow: milestoneNameLabel.topAnchor, multiplier: 6)
        ])
    }
    
    private func setupMilestoneCurNumberLabel() {
        milestoneCurNumberLabel.text = "Milestone Progress"
        NSLayoutConstraint.activate([
            milestoneCurNumberLabel.topAnchor.constraint(equalToSystemSpacingBelow: milestoneNameTextField.bottomAnchor, multiplier: 2),
            milestoneCurNumberLabel.leftAnchor.constraint(equalTo: milestoneNameLabel.leftAnchor),
            milestoneCurNumberLabel.heightAnchor.constraint(equalToConstant: 30),
            milestoneCurNumberLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6)
        ])
    }
    
    private func curNumberTextFieldConstraints() {
        milestoneCurNumberField.placeholder = "0"
        NSLayoutConstraint.activate([
            milestoneCurNumberField.heightAnchor.constraint(equalToConstant: 30),
            milestoneCurNumberField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            milestoneCurNumberField.topAnchor.constraint(equalTo: milestoneCurNumberLabel.topAnchor),
            milestoneCurNumberField.leftAnchor.constraint(equalTo: milestoneCurNumberLabel.rightAnchor)
        ])
    }
    
    private func setupMilestoneTargetNumberLabel() {
        milestoneTargetNumberLabel.text = "Milestone Target"
        NSLayoutConstraint.activate([
            milestoneTargetNumberLabel.topAnchor.constraint(equalToSystemSpacingBelow: milestoneCurNumberField.bottomAnchor, multiplier: 2),
            milestoneTargetNumberLabel.leftAnchor.constraint(equalTo: milestoneNameLabel.leftAnchor),
            milestoneTargetNumberLabel.heightAnchor.constraint(equalToConstant: 30),
            milestoneTargetNumberLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6)
        ])
    }
    
    private func targetNumberTextFieldConstraints() {
        NSLayoutConstraint.activate([
            milestoneTargetNumberField.heightAnchor.constraint(equalToConstant: 30),
            milestoneTargetNumberField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            milestoneTargetNumberField.topAnchor.constraint(equalTo: milestoneTargetNumberLabel.topAnchor),
            milestoneTargetNumberField.leftAnchor.constraint(equalTo: milestoneTargetNumberLabel.rightAnchor)
        ])
    }
    
    private func setupBlueButton() {
        createButton.setTitle("Create", for: .normal)
        NSLayoutConstraint.activate([
            createButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            createButton.heightAnchor.constraint(equalToConstant: 50),
            createButton.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 100),
            createButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    // MARK: Keyboard Functionality
    
    func shiftKeyboard(textField: UITextField) {

        if textField == milestoneNameTextField {
            if self.frame.origin.y == 0 {
                UIView.animate(withDuration: 0.25, animations: {
                    self.frame.origin.y -= self.keyboardHeight / 4
                })
            }
        } else {
           UIView.animate(withDuration: 0.25, animations: {
                self.frame.origin.y = 0
            })
        }
    }
    
    @objc func dismissKeyboard() {
           self.endEditing(true)
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.frame.origin.y != 0 {
            self.frame.origin.y = 0
        }
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
