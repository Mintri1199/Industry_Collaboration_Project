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

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    setupUI()
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
    formView.setupMaskLayer()
    formView.textField.delegate = self
    formView.textField.addTarget(self, action: #selector(buttonAnimation), for: .allEditingEvents)
  }
}

// MARK: objc methods
extension MilestonePromptVC {
  @objc private func buttonAnimation() {

    if let text = formView.textField.text {
      print("textField text: \(text)")
      print(text.isEmpty)
      print(formView.saveButton.isHidden)
      if text.isEmpty && !formView.saveButton.isHidden {
        formView.hideSaveButton()
        print("button is hidden: \(formView.saveButton.isHidden)")
      } else if !text.isEmpty && formView.saveButton.isHidden {
        formView.showSaveButton()
        print("button is hidden: \(formView.saveButton.isHidden)")
      }
    }
  }
}

extension MilestonePromptVC: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // KEYboard
  }
}
