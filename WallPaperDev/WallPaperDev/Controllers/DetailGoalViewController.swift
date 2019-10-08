//
//  DetailViewController.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 10/8/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class DetailGoalViewController: CreateGoalViewController
{
    var goal: Goal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        configButton()
        if let goal = goal {
            configTextFields(goal: goal)
        }
    }
    
    override func setupNavBar() {
        navigationItem.title = "Goal Details"
        navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: "Goal Details")
    }
    
    func configTextFields(goal: Goal) {
        guard let unwrappedName = goal.name,
            let unwrappedDescription = goal.summary else { return }
        createGoalView.goalNameTextField.text = unwrappedName
        createGoalView.goalDescriptionTextView.text = unwrappedDescription
    }
    
    func configButton() {
        createGoalView.createButton.setTitle("Update", for: .normal)
        createGoalView.createButton.addTarget(self, action: #selector(updateTapped), for: .touchUpInside)
    }
    
    @objc func updateTapped() {
        print("tapped")
    }
}
