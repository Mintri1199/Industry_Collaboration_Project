//
//  DetailViewController.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 10/8/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class DetailGoalViewController: CreateGoalViewController {

  private let viewModel = GoalDetailViewModel()

  init(goal: Goal) {
    super.init(nibName: nil, bundle: nil)
    viewModel.goal = goal
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configButton()
    createGoalView.goalNameTextField.resignFirstResponder()
    if let goal = viewModel.goal {
      configTextFields(goal: goal)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configTextFields(goal: Goal) {
    guard let unwrappedName = goal.name,
      let unwrappedDescription = goal.summary else { return }
    createGoalView.goalNameTextField.text = unwrappedName
    createGoalView.goalDescriptionTextView.text = unwrappedDescription
    createGoalView.goalDescriptionTextView.textColor = ApplicationDependency.manager.currentTheme.colors.black
  }

  override func setupNavBar() {
    navigationItem.title = Localized.string("goal_details_title")
    navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: Localized.string("goal_details_title"))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped))
  }

  private func configButton() {
    createGoalView.createButton.setTitle(Localized.string("update_action"), for: .normal)
    createGoalView.createButton.removeTarget(nil, action: nil, for: .allEvents)
    createGoalView.createButton.addTarget(self, action: #selector(updateTapped), for: .touchUpInside)
  }
}

// MARK: - OBJC methods
extension DetailGoalViewController {
  @objc private func updateTapped() {
    if validInputs() {
      guard let userGoalName = createGoalView.goalNameTextField.text,
        let userGoalSummary = createGoalView.goalDescriptionTextView.text else {
        return
      }
      viewModel.updateGoal(userGoalName, userGoalSummary)
      navigationController?.popViewController(animated: true)
    } else {
      presentError()
    }
  }

  @objc private func deleteTapped() {
    viewModel.delete()
    navigationController?.popViewController(animated: true)
  }
}
