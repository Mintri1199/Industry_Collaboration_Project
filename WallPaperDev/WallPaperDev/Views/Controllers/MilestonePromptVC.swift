//
//  MilestonePromptVC.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 4/16/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

final class MilestonePromptVC: UIViewController {
  
  private var formView: MilestoneFormView = MilestoneFormView()
  private var keyboardHeight: CGFloat = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    setupUI()
    setupKeyboardNotifications()
  }
  
  private func setupKeyboardNotifications() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tap)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }
  
  
  private func displayKeyboard(_ value: Bool) {
    if value {
      if self.view.frame.origin.y == 0 {
        
        let keyboardFromCenterY = (self.view.center.y - keyboardHeight)
        let difference = (formView.frame.height / 2) - keyboardFromCenterY
        UIView.animate(withDuration: 0.25, animations: {
          self.view.frame.origin.y -= difference + 10
        })
      }
    } else {
      UIView.animate(withDuration: 0.25, animations: {
        self.view.frame.origin.y = 0
      })
    }
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

// MARK: UI setup methods
extension MilestonePromptVC {
  private func setupUI() {
    formView.sizeToFit()
    view.addSubview(formView)
    formView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      formView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      formView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
      formView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    view.layoutIfNeeded()
    formView.textField.delegate = self
    formView.textField.addTarget(self, action: #selector(buttonAnimation), for: .allEditingEvents)
  }
}

// MARK: objc methods
extension MilestonePromptVC {
  @objc private func buttonAnimation() {
    if let text = formView.textField.text {
      if text.isEmpty && !formView.saveButton.isHidden {
        formView.hideSaveButton()
      } else if !text.isEmpty && formView.saveButton.isHidden {
        formView.showSaveButton()
      }
    }
  }
  
  @objc func dismissKeyboard() {
    formView.textField.endEditing(true)
  }
  
  @objc func keyboardWillChange(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      keyboardHeight = keyboardSize.height
      displayKeyboard(true)
    }
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    if view.frame.origin.y != 0 {
      self.view.frame.origin.y = 0
    }
  }
}

extension MilestonePromptVC: UITextFieldDelegate {
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    displayKeyboard(false)
  }
}
