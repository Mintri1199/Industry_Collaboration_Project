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
  var buttonCenterXConstraint: NSLayoutConstraint?
  
  override init(frame: CGRect) {
    super.init(frame: frame) // FLAG: color
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
      label.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
  
  private func setupTextField() {
    addSubview(textField)
    NSLayoutConstraint.activate([
      textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15),
      textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
    ])
  }
  
  func setupMaskLayer() {
    // Have a mask layer to shape the view and hide the save button during animation
    maskLayer.frame = bounds
    maskLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 15).cgPath
    layer.mask = maskLayer
  }
  
  private func setupSaveButton() {
    buttonCenterXConstraint = saveButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 300)
    addSubview(saveButton)
    // Flag: text
    
    saveButton.setTitle(Localized.string("save_action"), for: .normal)
    saveButton.titleLabel?.font = ApplicationDependency.manager.currentTheme.fontSchema.medium24
    saveButton.sizeToFit()
    saveButton.layer.cornerRadius = saveButton.frame.height / 3
    NSLayoutConstraint.activate([
      saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
      saveButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
      saveButton.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: textField.bottomAnchor, multiplier: 3),
      // FLAG: figure out a way to add it to the middle without constraint
      buttonCenterXConstraint!
    ])
    saveButton.isEnabled = false
    saveButton.isHidden = true
  }
  
  func showSaveButton() {
    buttonCenterXConstraint?.constant = 0
    saveButton.isHidden = false 
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
      self.layoutIfNeeded()
    }, completion: { _ in
      self.saveButton.isEnabled = true
    })
  }
  
  func hideSaveButton() {
    saveButton.isEnabled = false
    buttonCenterXConstraint?.constant = 300
    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
      self.layoutIfNeeded()
    }, completion: { _ in
      self.saveButton.isHidden = true
    })
  }
}