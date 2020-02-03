//
//  SelectedGoalsEmptyView.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/24/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class SelectedGoalsEmptyView: UIView {
  
  private let titleLabel = UILabel()
  let chooseGoalButton = GrayTextButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLabel()
    setupButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLabel() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.text = Localized.string("selected_goal_empty_view_title")
    titleLabel.textColor = .darkGray
    addSubview(titleLabel)
    titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -70).isActive = true
    titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
  }
  
  private func setupButton() {
    chooseGoalButton.label.text = Localized.string("selected_goal_empty_view_button_cta")
    chooseGoalButton.label.textAlignment = .center
    addSubview(chooseGoalButton)
    chooseGoalButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
    chooseGoalButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    chooseGoalButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
    chooseGoalButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
  }
}
