//
//  SearchErrorView.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 5/25/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

class SearchErrorView: UIView {
  private lazy var iconImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFill
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = nil
    view.tintColor = ApplicationDependency.manager.currentTheme.colors.darkGray
    return view
  }()
  
  private let textLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.backgroundColor = nil
    label.numberOfLines = 1
    label.font = ApplicationDependency.manager.currentTheme.fontSchema.medium24
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.25
    label.textAlignment = .center
    label.textColor = ApplicationDependency.manager.currentTheme.colors.darkGray
    return label
  }()
  
  enum ViewType {
    case intro
    case emptyResult(input: String)
    case noConnection
    case apiError
  }
  
  func prepare(for type: ViewType) {
    var icon: UIImage?
    var text: String
    
    switch type {
    case .intro:
      icon = UIImage.templateIcon(for: "magnifiyingglass.circle.fill")
      text = Localized.string("unsplash_intro")
      
    case let .emptyResult(input):
      icon = UIImage.templateIcon(for: "bin.xmark.fill")
      textLabel.numberOfLines = 2
      text = String(format: Localized.string("no_results"), input)
      
    case .noConnection:
      icon = UIImage.templateIcon(for: "wifi.slash")
      text = Localized.string("unsplash_network_error")
      
    case .apiError:
      icon = UIImage.templateIcon(for: "exclamationmark.circle.fill")
      text = Localized.string("unsplash_api_error")
    }
    iconImageView.image = icon
    textLabel.text = text
    
    setupConstaints()
  }
  
  private func setupConstaints() {
    addSubview(iconImageView)
    addSubview(textLabel)
    
    NSLayoutConstraint.activate([
      iconImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
      iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
      iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -iconImageView.bounds.height),
      
      textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      textLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
      textLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 15),
      textLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.20)
    ])
  }
}
