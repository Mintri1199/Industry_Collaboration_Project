//
//  View.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/22/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {

  let noGoalsLabel: UILabel = {
    let label = UILabel()
    label.text = Localized.string("set_goal_today_prompt")
    label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    label.font = ApplicationDependency.manager.currentTheme.fontSchema.medium20
    label.textAlignment = .center
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configView()
  }

  private func configView() {
    backgroundColor = .white
    layer.cornerRadius = 25
    addSubview(noGoalsLabel)
    noGoalsLabelConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func noGoalsLabelConstraints() {
    noGoalsLabel.translatesAutoresizingMaskIntoConstraints = false
    noGoalsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
    noGoalsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    noGoalsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    noGoalsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
  }
}
