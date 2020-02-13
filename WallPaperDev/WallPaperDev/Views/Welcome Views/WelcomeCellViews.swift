//
//  WelcomeCellViews.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

enum WelcomeStyle {
  case first
  case second
  case demo
  case showcase
}

class CustomView: UIView {
  private let defaultImageSchema = DefaultImageAsset()
  private lazy var phoneLayer = CALayer()
  private lazy var textLayer = CALayer()
  private lazy var fingerLayer = CALayer()
  private lazy var headerLabel = WelcomeLabel(frame: .zero)
  private lazy var subHeaderLabel = WelcomeLabel(frame: .zero)
  private lazy var labelStackView = UIStackView(frame: .zero)
  
  func setupUI(style: WelcomeStyle) {
    backgroundColor = .white
    setupLabels(for: style)
    switch style {
    case .first:
      setupWelcomePicture(for: .first)
    case .second:
      setupWelcomePicture(for: .second)
    case .demo:
      setupDemoLayers()
    case .showcase:
      setupShowCaseLayer()
    }
  }
  
  private func setupWelcomePicture(for imageStyle: WelcomeStyle) {
    guard imageStyle != .demo, imageStyle != .showcase else {
      return
    }
    
    let photoLayer = CALayer()
    let image: UIImage = imageStyle == .first ? defaultImageSchema.tutorialWelcomeBanner : defaultImageSchema.tutorialTodoBanner
    
    photoLayer.frame = CGRect(origin: .zero,
                              size: CGSize(width: bounds.width, height: bounds.height * 0.666))
    photoLayer.contents = image.cgImage
    photoLayer.contentsGravity = .resizeAspect
    photoLayer.preferredFrameSize()
    layer.addSublayer(photoLayer)
  }
  
  private func setupLabels(for style: WelcomeStyle) {
    var headerText: String
    var subHeaderText: String
    switch style {
    case .first:
      headerText = Localized.string(Localized.string("tutorial_title_1"))
      subHeaderText = Localized.string("tutorial_message_1")
    case .second:
      headerText = Localized.string(Localized.string("tutorial_title_2"))
      subHeaderText = Localized.string("tutorial_message_2")
    case .demo:
      headerText = Localized.string(Localized.string("tutorial_demo_title"))
      subHeaderText = Localized.string("tutorial_demo_message")
    case .showcase:
      headerText = Localized.string(Localized.string("tutorial_showcase_title"))
      subHeaderText = Localized.string("tutorial_showcase_message")
    }
    
    labelStackView.translatesAutoresizingMaskIntoConstraints = false
    labelStackView.distribution = .fillProportionally
    labelStackView.alignment = .center
    labelStackView.axis = .vertical
    addSubview(labelStackView)
    
    NSLayoutConstraint.activate([
      labelStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
      labelStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
    
    if style == .demo || style == .showcase {
      labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    headerLabel.configHeaderLabel(text: headerText)
    subHeaderLabel.configSubHeaderLabel(text: subHeaderText)
    labelStackView.addArrangedSubview(headerLabel)
    labelStackView.addArrangedSubview(subHeaderLabel)
    labelStackView.sizeToFit()
    labelStackView.layoutIfNeeded()
    
    if style == .first || style == .second {
      labelStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: labelStackView.frame.height).isActive = true
    }
  }
  
  private func setupShowCaseLayer() {
    let phoneSize = CGSize(width: bounds.width * 0.6, height: bounds.height - labelStackView.frame.height)
    let phoneXOffset: CGFloat = bounds.width / 5
    phoneLayer.frame = CGRect(origin: CGPoint(x: phoneXOffset, y: 0), size: phoneSize)
    phoneLayer.contents = ApplicationDependency.manager.currentTheme.imageAssets.tutorialPhone.cgImage
    phoneLayer.contentsGravity = .resizeAspect
    layer.addSublayer(phoneLayer)
  }
  
  private func setupDemoLayers() {
    let phoneSize = CGSize(width: bounds.width * 0.6, height: bounds.height - labelStackView.frame.height)
    let phoneXOffset: CGFloat = bounds.width / 5
    phoneLayer.frame = CGRect(origin: CGPoint(x: phoneXOffset, y: 0), size: phoneSize)
    phoneLayer.contents = ApplicationDependency.manager.currentTheme.imageAssets.tutorialExample1.cgImage
    phoneLayer.contentsGravity = .resizeAspect
    layer.addSublayer(phoneLayer)
    
    let textSize = CGSize(width: phoneLayer.bounds.width * 0.8, height: phoneLayer.bounds.height * 0.2)
    textLayer.frame = CGRect(origin: CGPoint(x: phoneLayer.bounds.width / 10, y: phoneLayer.bounds.maxY - textSize.height - 50), size: textSize)
    textLayer.contents = ApplicationDependency.manager.currentTheme.imageAssets.tutorialGoalTextExample.cgImage
    textLayer.contentsGravity = .resizeAspect
    phoneLayer.addSublayer(textLayer)
    
    let fingerSize = CGSize(width: bounds.width / 2, height: bounds.width / 2)
    fingerLayer.frame = CGRect(origin: CGPoint(x: bounds.midX, y: phoneLayer.bounds.midY - textSize.height), size: fingerSize)
    fingerLayer.contents = ApplicationDependency.manager.currentTheme.imageAssets.tutorialFinger.cgImage
    fingerLayer.contentsGravity = .resizeAspect
    layer.addSublayer(fingerLayer)
  }
  
  func animatePhone(for style: WelcomeStyle) {
    switch style {
    case .showcase:
      animateShowcase()
    case.demo:
      animateDemo()
    default:
      return
    }
  }
  
  private func animateShowcase() {
    let panDown = CABasicAnimation(keyPath: "position.y")
    panDown.fromValue = -phoneLayer.frame.height
    panDown.toValue = phoneLayer.position.y
    panDown.duration = 0.7
    panDown.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    phoneLayer.add(panDown, forKey: nil)
  }
  
  private func animateDemo() {
    let panDown = CABasicAnimation(keyPath: "position.y")
    panDown.fromValue = fingerLayer.position.y
    panDown.toValue = textLayer.position.y
    panDown.duration = 0.75
    panDown.timingFunction = CAMediaTimingFunction(name: .easeOut)
    textLayer.add(panDown, forKey: nil)
    panDown.autoreverses = true
    fingerLayer.add(panDown, forKey: nil)
  }
}
