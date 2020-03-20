//
//  HomeTitleView.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

final class HomeBackgroundView: UIView {
  fileprivate enum PartOfDay {
    case morning
    case afternoon
    case evening
  }
  
  fileprivate let greetingLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = ApplicationDependency.manager.currentTheme.fontSchema.black40
    label.textAlignment = .left
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.numberOfLines = 0
    return label
  }()
  
  fileprivate let currentDateLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = ApplicationDependency.manager.currentTheme.fontSchema.medium24
    label.textAlignment = .left
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    backgroundColor = ApplicationDependency.manager.currentTheme.colors.navBarBlue
    
    addSubview(greetingLabel)
    addSubview(currentDateLabel)
    
    titleConstraint()
    dateLabelConstraint()
    
    let part = getPartOfDay()
    var greeting: String
    // Add to localize string
    switch part {
    case .morning:
      greeting = Localized.string("good_morning_title")
    case .afternoon:
      greeting = Localized.string("good_afternoon_title")
    case .evening:
      greeting = Localized.string("good_evening_title")
    }
    greetingLabel.text = greeting
    setDateLabel()
  }
  
  fileprivate func getPartOfDay() -> PartOfDay {
    switch Calendar.current.component(.hour, from: Date()) {
    case 0 ... 11 :
      return .morning
      
    case 12 ... 18:
      return .afternoon
      
    case 19 ... 24:
      return .evening
      
    default:
      return .morning
    }
  }
  
  fileprivate func setDateLabel() {
    let date = Date()
    let dateString = DateFormatter.localizedString(from: date, dateStyle: .long, timeStyle: .none)
    currentDateLabel.text = String(format: Localized.string("current_date_time_title", comment: ""), dateString)
  }
  
  fileprivate func titleConstraint() {
    greetingLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      greetingLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 4),
      greetingLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 10),
      greetingLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
      greetingLabel.heightAnchor.constraint(equalToConstant: 120)
    ])
  }
  
  fileprivate func dateLabelConstraint() {
    currentDateLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      currentDateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
      currentDateLabel.heightAnchor.constraint(equalToConstant: 50),
      currentDateLabel.leftAnchor.constraint(equalTo: greetingLabel.leftAnchor),
      currentDateLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 25)
    ])
  }
}
