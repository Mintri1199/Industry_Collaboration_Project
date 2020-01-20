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
    weak var coordinator: MainCoordinator?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalView.goalNameTextField.becomeFirstResponder()
        setupUIs()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        coordinator?.navigationController.navigationBar.isHidden = false
    }
    
    func setupNavBar() {
      navigationItem.title = Localized.string("create_goal_title")
      coordinator?.navigationController.navigationBar.configGenericNavBar(text: Localized.string("create_goal_title"))
    }
}

// MARK: Setup UI functions
extension CreateGoalViewController {
    
    private func setupUIs() {
        setupCreateGoalView()
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
        
        if userGoalName.isEmpty || userGoalSummary == createGoalView.goalDescriptionTextView.placeHolder {
            presentError()
            return
        }
        coreDataStack.createGoal(userGoalName, userGoalSummary)
        navigationController?.popViewController(animated: true)
    }
    
    func presentError() {
      let alertView = UIAlertController(title: Localized.string("invalid"),
                                        message: Localized.string("create_goal_error_message"),
                                        preferredStyle: .alert)
      let action = UIAlertAction(title: Localized.string("ok_action"),
                                 style: .cancel,
                                 handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
}

extension CreateGoalViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.placeholderGray {
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
            view.textColor = .placeholderGray
        }
    }
}

extension CreateGoalViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        createGoalView.goalDescriptionTextView.becomeFirstResponder()
        return true
    }
}
