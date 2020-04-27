//
//  MilestoneCell.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 4/15/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

class MilestoneCell: UITableViewCell {
  
  static let id = "MilestoneCell"
  private let milestone: Milestone
  let checkBox = CheckBoxButton()
  lazy var milestoneLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .natural
    label.textColor = ApplicationDependency.manager.currentTheme.colors.black
    label.font = ApplicationDependency.manager.currentTheme.fontSchema.medium16
    return label
  }()
  
  init(_ milestone: Milestone) {
    self.milestone = milestone
    super.init(style: .default, reuseIdentifier: MilestoneCell.id)
    setupCheckBox()
    setupLabel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
//    checkBox.isSelected = true
//    let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: milestone.name!)
//    attributedText.addAttributes([
//      NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
//      NSAttributedString.Key.strikethroughColor: ApplicationDependency.manager.currentTheme.colors.darkGray,
//      NSAttributedString.Key.font: ApplicationDependency.manager.currentTheme.fontSchema.medium16
//    ], range: NSRange(location: 0, length: attributedText.length))
//
//    milestoneLabel.attributedText = attributedText
  }
  
  // TODO: write a custom complete animation
  private func toggleCompletedState() {
    // Dimming the views in the cell
    
    // checking the box
    
    // strike out the text
  }
  
  private func setupCheckBox() {
    addSubview(checkBox)
    NSLayoutConstraint.activate([
      
      checkBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      checkBox.centerYAnchor.constraint(equalTo: centerYAnchor),
      checkBox.widthAnchor.constraint(equalToConstant: bounds.width / 12),
      checkBox.heightAnchor.constraint(equalToConstant: bounds.width / 12)
    ])
  }
  
  private func setupLabel() {
    addSubview(milestoneLabel)
    NSLayoutConstraint.activate([
      milestoneLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
      milestoneLabel.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 20),
      milestoneLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      milestoneLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
    ])
    
    if let cellText = milestone.name {
      milestoneLabel.text = cellText
    }
  }
}
