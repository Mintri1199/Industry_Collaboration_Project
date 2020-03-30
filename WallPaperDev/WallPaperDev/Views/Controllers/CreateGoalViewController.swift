//
//  CreateGoalViewController.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/10/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class CreateGoalViewController: UIViewController {

  let createGoalView = CreateGoalView()
  let coreDataStack = CoreDataStack.shared
  weak var coordinator: MainCoordinator?

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    createGoalView.goalNameTextField.becomeFirstResponder()
    coordinator?.navigationController.setNavigationBarHidden(false, animated: true)
    setupUIs()
  }

  func setupNavBar() {
    navigationItem.title = Localized.string("create_goal_title")
    coordinator?.navigationController.navigationBar.configGenericNavBar(text: Localized.string("create_goal_title"))
  }

  func validInputs() -> Bool {
    if createGoalView.goalNameTextField.text == nil {
      return false
    } else if createGoalView.goalDescriptionTextView.textColor == ApplicationDependency.manager.currentTheme.colors.placeholderGray ||
      createGoalView.goalDescriptionTextView.text == nil {
      return false
    } else {
      return true
    }
  }
}

// MARK: Setup UI functions

extension CreateGoalViewController {
  private func setupUIs() {
    setupCreateGoalView()
    setupNavBar()
    setupButton()
  }

  private func setupCreateGoalView() {
    createGoalView.frame = view.frame
    createGoalView.goalDescriptionTextView.delegate = self
    createGoalView.goalNameTextField.delegate = self
    view.addSubview(createGoalView)
  }

  private func setupButton() {
    createGoalView.createButton.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
  }

  func presentError() {
    let alertView = UIAlertController(title: Localized.string("invalid"),
                                      message: Localized.string("create_goal_error_message"),
                                      preferredStyle: .alert)
    let action = UIAlertAction(title: Localized.string("alert_ok"), style: .cancel, handler: nil)
    alertView.addAction(action)
    present(alertView, animated: true, completion: nil)
  }
}

// MARK: - Objc functions
extension CreateGoalViewController {
  @objc func createTapped() {
    if validInputs() {
      guard let userGoalName = createGoalView.goalNameTextField.text,
        let userGoalSummary = createGoalView.goalDescriptionTextView.text else {
        return
      }
      coreDataStack.createGoal(userGoalName, userGoalSummary)
      navigationController?.popViewController(animated: true)
    } else {
      presentError()
    }
  }
}

// MARK: - UITextViewDelegate
extension CreateGoalViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == ApplicationDependency.manager.currentTheme.colors.placeholderGray {
      textView.text = nil
      textView.textColor = ApplicationDependency.manager.currentTheme.colors.black
    }
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    guard let view = textView as? GoalDescriptionTextView else {
      return
    }
    navigationController?.navigationBar.isHidden = false
    if view.text.isEmpty {
      view.text = view.placeHolder
      view.textColor = ApplicationDependency.manager.currentTheme.colors.placeholderGray
    }
  }
}

// MARK: - UITextFieldDelegate
extension CreateGoalViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_: UITextField) -> Bool {
    createGoalView.goalDescriptionTextView.becomeFirstResponder()
    return true
  }
}
