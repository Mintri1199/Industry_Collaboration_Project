//
//  MilestoneFormView.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 4/16/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

class MilestoneFormView: UIView {
  
  private let maskLayer = CAShapeLayer()
  
  private let label: PaddingLabel = {
    var label = PaddingLabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .natural
    label.text = Localized.string("create_milestone_title")
    label.textColor = ApplicationDependency.manager.currentTheme.colors.black
    label.font = ApplicationDependency.manager.currentTheme.fontSchema.heavy20
    return label
  }()
  
  let textField = PaddingTextField()
  
  let saveButton = BigBlueButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    // FLAG: color
    backgroundColor = .white
    setupLabel()
    setupTextField()
    setupSaveButton()
    layer.cornerRadius = 15
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLabel() {
    addSubview(label)
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor),
      label.leadingAnchor.constraint(equalTo: leadingAnchor),
      label.trailingAnchor.constraint(equalTo: trailingAnchor),
      // Flag: Refactor this to have dynamic height
      label.heightAnchor.constraint(equalToConstant: 30)
    ])
  }
  
  private func setupTextField() {
    addSubview(textField)
    
    NSLayoutConstraint.activate([
      textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15),
      textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
    ])
  }
  
  private func setupMaskLayer() {
    // Have a mask layer to shape the view and hide the save button during animation
    maskLayer.frame = bounds
    maskLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.size.width / 5).cgPath
  }
  
  private func setupSaveButton() {
    saveButton.center.x = center.x + bounds.width
    addSubview(saveButton)
    // Flag: text
    saveButton.setTitle("Save", for: .normal)
    
    NSLayoutConstraint.activate([
      saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
      saveButton.widthAnchor.constraint(equalTo: widthAnchor, constant: 0.5),
      // FLAG: refactor for dymanic height
      saveButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
    ])
    
    saveButton.isHidden = true
    saveButton.isEnabled = true
  }
  
  func showSaveButton() {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
      self.saveButton.isHidden = false
      self.saveButton.center.x = self.center.x
    }) { completed in
      self.saveButton.isEnabled = true
    }
  }
  
  func hideSaveButton() {
    saveButton.isEnabled = false
    UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseIn], animations: {
      self.saveButton.isHidden = true
      self.saveButton.center.x = self.center.x + self.bounds.width
    })
  }
  
  // Needed UI
  // action label
  //  textfield
  // submit button
}
