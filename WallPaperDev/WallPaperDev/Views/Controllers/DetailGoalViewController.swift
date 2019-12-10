//
//  DetailViewController.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 10/8/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class DetailGoalViewController: CreateGoalViewController {
    
    let viewModel = GoalDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        configButton()
        createGoalView.goalNameTextField.resignFirstResponder()
        if let goal = viewModel.goal {
            configTextFields(goal: goal)
        }
    }
    
    override func setupNavBar() {
        navigationItem.title = "Goal Details"
        navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: "Goal Details")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped))
    }
    
    private func configTextFields(goal: Goal) {
        guard let unwrappedName = goal.name,
              let unwrappedDescription = goal.summary else { return }
        let arr = goal.milestones?.allObjects
        if let milestones = arr as? [Milestone] {
            if !milestones.isEmpty {
                createGoalView.milestoneNameTextField.text = milestones[0].name
                createGoalView.milestoneCurNumberField.text = String(milestones[0].currentNumber)
                createGoalView.milestoneTargetNumberField.text = String(milestones[0].totalNumber)
            }
        }
        
        createGoalView.goalNameTextField.text = unwrappedName
        createGoalView.goalDescriptionTextView.text = unwrappedDescription
        createGoalView.goalDescriptionTextView.textColor = .black
    }
    
    private func configButton() {
        createGoalView.createButton.setTitle("Update", for: .normal)
        createGoalView.createButton.removeTarget(nil, action: nil, for: .allEvents)
        createGoalView.createButton.addTarget(self, action: #selector(updateTapped), for: .touchUpInside)
    }
    
    @objc private func updateTapped() {
        guard let userGoalName = createGoalView.goalNameTextField.text,
              let userGoalSummary = createGoalView.goalDescriptionTextView.text else {
                return
        }
        
        if userGoalName.isEmpty || userGoalSummary == createGoalView.goalDescriptionTextView.placeHolder {
            presentError()
            return
        }
        
        if let name = createGoalView.milestoneNameTextField.text, let progress = createGoalView.milestoneCurNumberField.text, let target = createGoalView.milestoneTargetNumberField.text, let goal = viewModel.goal {
            coreDataStack.updateMilestone(goal, name, progress, target)
        }
        viewModel.updateGoal(userGoalName, userGoalSummary)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func deleteTapped() {
        viewModel.delete()
        navigationController?.popViewController(animated: true)
    }
}
