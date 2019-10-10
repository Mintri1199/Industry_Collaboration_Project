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
        createGoalView.goalNameTextField.becomeFirstResponder()
        setupUIs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupNavBar() {
        navigationItem.title = "Create Goal"
        navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: "Create Goal")
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
        createGoalView.goalDescriptionTextView.delegate = self
        createGoalView.goalNameTextField.delegate = self 
        self.view.addSubview(createGoalView)
    }
    
    private func setupButton() {
        createGoalView.createButton.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
    }
}

// MARK: - Objc functions
extension CreateGoalViewController {
    @objc func createTapped() {
        guard let userGoalName = createGoalView.goalNameTextField.text,
              let userGoalSummary = createGoalView.goalDescriptionTextView.text else {
                return
        }
        
        if userGoalName.isEmpty && userGoalSummary == createGoalView.goalDescriptionTextView.placeHolder {
            // prompt an alert for the user
            let alertView = UIAlertController(title: "Invalid", message: "You can't create a goal without a name and description", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertView.addAction(action)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        coreDataStack.createGoal(userGoalName, userGoalSummary)
        navigationController?.popViewController(animated: true)
    }
}

extension CreateGoalViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let view = textView as? GoalDescriptionTextView else {
            return
        }
        
        if view.text.isEmpty {
            view.text = view.placeHolder
            view.textColor = .lightGray
        }
    }
}

extension CreateGoalViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        createGoalView.goalDescriptionTextView.becomeFirstResponder()
    }
}
