//
//  HomeTitleView.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

final class HomeBackgroundView: UIView {

  private let morningTitleLabel: UILabel = {
    let label = UILabel()
    label.text = Localized.string("good_morning_title")
    label.textColor = .white
    label.font = UIFont(name: "Avenir-Black", size: 40)
    label.textAlignment = .left
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.numberOfLines = 0
    return label
  }()

  private let currentDateLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont(name: "Avenir-Medium", size: 25)
    label.textAlignment = .left
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor =  .navBarBlue
    addSubview(morningTitleLabel)
    addSubview(currentDateLabel)
    setDateLabel()
    titleConstraint()
    dateLabelConstraint()
  }

  private func setDateLabel() {
    currentDateLabel.text = getDateString()
  }

  private func getDateString() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateStyle = DateFormatter.Style.long
    formatter.timeStyle = DateFormatter.Style.none
    return String(format: Localized.string("current_date_time_title", comment: ""), formatter.string(from: date))
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func titleConstraint() {
    morningTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    morningTitleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 4).isActive = true
    morningTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 10).isActive = true
    morningTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
    morningTitleLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
  }

  private func dateLabelConstraint() {
    currentDateLabel.translatesAutoresizingMaskIntoConstraints = false
    currentDateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
    currentDateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    currentDateLabel.leftAnchor.constraint(equalTo: morningTitleLabel.leftAnchor).isActive = true
    currentDateLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 25).isActive = true
  }
}
