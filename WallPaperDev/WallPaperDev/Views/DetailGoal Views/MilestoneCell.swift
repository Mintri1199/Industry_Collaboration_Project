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
  let checkBox = CheckBoxButton(frame: .zero)
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
    setupTextField()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    checkBox.isSelected = true
    let attributedText : NSMutableAttributedString = NSMutableAttributedString(string: milestone.description)
    attributedText.addAttributes([
      NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
      NSAttributedString.Key.strikethroughColor: ApplicationDependency.manager.currentTheme.colors.lightGray,
      NSAttributedString.Key.font: ApplicationDependency.manager.currentTheme.fontSchema.medium16
                    ], range: NSMakeRange(0, attributedText.length))
    
    milestoneLabel.attributedText = attributedText
  }
  
  private func setupCheckBox() {
    addSubview(checkBox)
    NSLayoutConstraint.activate([
      checkBox.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      checkBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      checkBox.widthAnchor.constraint(equalToConstant: bounds.width / 10),
      checkBox.heightAnchor.constraint(equalToConstant: bounds.width / 10)
    ])
  }
  
  private func setupTextField() {
    addSubview(milestoneLabel)
    NSLayoutConstraint.activate([
      milestoneLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13),
      milestoneLabel.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 15),
      milestoneLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      milestoneLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13)
      
    ])
  }
}
