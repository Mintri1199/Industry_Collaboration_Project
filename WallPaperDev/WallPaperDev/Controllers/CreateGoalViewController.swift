//
//  ViewController.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/10/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class CreateGoalViewController: UIViewController {
    
    let createGoalView = CreateGoalView()
    let coreDataStack = CoreDataStack.shared
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        setupUIs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
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
        createGoalView.frame = self.view.frame
        self.view.addSubview(createGoalView)
    }
    
    private func setupNavBar() {
        navigationItem.title = "Create Goal"
        navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: "Create Goal")
    }
    
    private func setupButton() {
        createGoalView.createButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }
    
    // MARK: Why is this here? It currently does nothing
    private func retrieveGoals() {
        let goals = coreDataStack.fetchGoals()
        for goal in goals {
            print(goal.name ?? "")
        }
    }
}

// MARK: - Objc functions
extension CreateGoalViewController {
    @objc func addTapped() {
        guard let userGoalName = createGoalView.goalNameTextField.text,
            let userGoalSummary = createGoalView.goalDescriptionTextView.text else {
                return
        }
        
        coreDataStack.createGoal(userGoalName, userGoalSummary)
    }
}
