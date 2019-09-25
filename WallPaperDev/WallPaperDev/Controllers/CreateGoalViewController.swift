//
//  ViewController.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/10/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class CreateGoalViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let coreDataStack = CoreDataStack.shared
    lazy var createGoalView = CreateGoalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        _setupCreateGoalView()
        _setupNavBar()
        _setupButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       navigationController?.navigationBar.isHidden = false
    }
}

// MARK: Setup UI functions
extension CreateGoalViewController {
    private func _setupCreateGoalView() {
        createGoalView.frame = self.view.frame
        self.view.addSubview(createGoalView)
    }
    
    private func _setupNavBar() {
        navigationItem.title = "Create Goal"
    }
    
    private func _setupTextField() {
    }
    
    private func _setupButton() {
        createGoalView.createButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }
    
    private func saveUserGoal(from userGoal: Goal) {
        print("\(userGoal)")
    }
    
    @objc func addTapped() {
        guard let userGoalName = createGoalView.goalNameTextField.text else {return}
        guard let userGoalSummary = createGoalView.goalDescriptionLabel.text else{return}
        
        let userGoal = Goal(context: coreDataStack.context)
        userGoal.name = userGoalName
        userGoal.summary = userGoalSummary
        
        saveUserGoal(from: userGoal)
    }
}

// MARK: - Changing the status when using a navigation controller
extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
