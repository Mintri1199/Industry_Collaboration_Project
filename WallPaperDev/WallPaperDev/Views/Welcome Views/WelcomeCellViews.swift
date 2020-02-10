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

class FirstTwoCellView: UIView {
  private let photoLayer = CALayer()
  private let headerLabel = WelcomeLabel(frame: .zero)
  private let subHeaderLabel = WelcomeLabel(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
  }
  
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupUI(_ header: String, _ subHeader: String) {
    headerLabel.configHeaderLabel(text: header)
    headerLabel.frame.size.width = bounds.width * 0.8
    headerLabel.sizeToFit()
    headerLabel.center = center
    headerLabel.center.y = center.y + (headerLabel.frame.height * 2)
    
    subHeaderLabel.configSubHeaderLabel(text: subHeader)
    subHeaderLabel.frame.size.width = bounds.width * 0.7
    subHeaderLabel.sizeToFit()
    subHeaderLabel.center = CGPoint(x: center.x, y: headerLabel.center.y + headerLabel.frame.height * 1.5)
    addSubview(headerLabel)
    addSubview(subHeaderLabel)
  }
  
  func setupPhotoLayer(_ image: UIImage) {
    photoLayer.frame = CGRect(origin: .zero, size: CGSize(width: bounds.width, height: bounds.height / 2))
    photoLayer.contents = image.cgImage
    photoLayer.contentsGravity = .resizeAspect
    layer.addSublayer(photoLayer)
  }
}

// TODO: Fix text and animation bugs (The first one is wonky, and smooth out the second)

class CustomView: UIView {
  private let defaultImageSchema = DefaultImageAsset()
  private let headerLabel = WelcomeLabel(frame: .zero)
  private let subHeaderLabel = WelcomeLabel(frame: .zero)
  
  func setupUI(style: WelcomeStyle) {
    switch style {
    case .first:
      setupMidLabel(for: .first)
      setupWelcomePicture(for: .first)
    case .second:
      setupMidLabel(for: .second)
      setupWelcomePicture(for: .second)
    default:
      return
    }
  }
  
  private func setupWelcomePicture(for imageStyle : WelcomeStyle) {
    let photoLayer = CALayer()
    var image: UIImage
    switch imageStyle {
    case .first:
      image = defaultImageSchema.tutorialWelcomeBanner
    case.second:
      image = defaultImageSchema.tutorialTodoBanner
    default:
      image = defaultImageSchema.tutorialWelcomeBanner
    }
    
    photoLayer.frame = CGRect(origin: .zero, size: CGSize(width: bounds.width, height: bounds.height * 0.666))
    photoLayer.contents = image.cgImage
    photoLayer.contentsGravity = .resizeAspect
    photoLayer.preferredFrameSize()
    layer.addSublayer(photoLayer)
  }
  
  private func setupMidLabel(for textStyle: WelcomeStyle) {
    var headerText: String
    var subHeaderText: String
    switch textStyle {
    case .first:
      headerText = Localized.string(Localized.string("tutorial_title_1"))
      subHeaderText = Localized.string("tutorial_message_1")
    case .second:
      headerText = Localized.string(Localized.string("tutorial_title_2"))
      subHeaderText = Localized.string("tutorial_message_2")
    default:
      headerText = Localized.string(Localized.string("tutorial_title_1"))
      subHeaderText = Localized.string("tutorial_message_1")
    }
    
    let stackView = UIStackView(frame: .zero)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .fillProportionally
    stackView.alignment = .center
    stackView.axis = .vertical
    addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
      stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
    ])
    
    headerLabel.configHeaderLabel(text: headerText)
    subHeaderLabel.configSubHeaderLabel(text: subHeaderText)
    
    stackView.addArrangedSubview(headerLabel)
    stackView.addArrangedSubview(subHeaderLabel)
    stackView.sizeToFit()
    layoutIfNeeded()
    stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: stackView.frame.height).isActive = true
  }
  
  private func setupShowCase() {}
  
  private func setupDemo() {}
}

class DemoView: UIView {
  private let headerText = Localized.string("tutorial_demo_title")
  private let subHeaderText = Localized.string("tutorial_demo_message")
  private let container = CALayer()
  private let fingerLayer = CALayer()
  private let textLayer = CALayer()
  private let phoneLayer = CALayer()
  private let headerLabel = WelcomeLabel(frame: .zero)
  private let subHeaderLabel = WelcomeLabel(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .yellow
    setupUI()
//    setupLayers()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func resetAnimation() {
    prepAnimation()
  }
  
  private func setupUI() {
    subHeaderLabel.frame.size.width = bounds.width * 0.7
    subHeaderLabel.configSubHeaderLabel(text: subHeaderText)
    subHeaderLabel.sizeToFit()
    subHeaderLabel.center = CGPoint(x: center.x, y: bounds.maxY - subHeaderLabel.frame.height / 2)
    
    headerLabel.frame.size.width = bounds.width * 0.8
    headerLabel.configHeaderLabel(text: headerText)
    headerLabel.sizeToFit()
    headerLabel.center = center
    headerLabel.center.y = subHeaderLabel.frame.minY - headerLabel.frame.height / 2
    
    addSubview(headerLabel)
    addSubview(subHeaderLabel)
  }
  
  private func setupLayers() {
    container.frame = CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: bounds.height - headerLabel.frame.height - subHeaderLabel.frame.height))
    layer.addSublayer(container)
    
    let phoneSize = CGSize(width: container.bounds.width * 0.6, height: container.bounds.height)
    let phoneXOffset = bounds.width / 5
    phoneLayer.frame = CGRect(origin: CGPoint(x: phoneXOffset, y: 0), size: phoneSize)
    phoneLayer.contents = ApplicationDependency.manager.currentTheme.imageAssets.tutorialExample1.cgImage
    phoneLayer.contentsGravity = .resizeAspect
    container.addSublayer(phoneLayer)
    
    let textSize = CGSize(width: phoneLayer.bounds.width * 0.8, height: phoneLayer.bounds.height * 0.2)
    textLayer.frame = CGRect(origin: CGPoint(x: phoneLayer.bounds.width / 10, y: phoneLayer.bounds.maxY - textSize.height - 30), size: textSize)
    textLayer.contents = ApplicationDependency.manager.currentTheme.imageAssets.tutorialGoalTextExample.cgImage
    textLayer.contentsGravity = .resizeAspect
    phoneLayer.addSublayer(textLayer)
    
    let fingerSize = CGSize(width: container.bounds.width / 2, height: container.bounds.width / 2)
    fingerLayer.frame = CGRect(origin: CGPoint(x: container.bounds.midX, y: container.bounds.midY), size: fingerSize)
    fingerLayer.contents = ApplicationDependency.manager.currentTheme.imageAssets.tutorialFinger.cgImage
    fingerLayer.contentsGravity = .resizeAspect
    container.addSublayer(fingerLayer)
  }
  
  private func prepAnimation() {
    let textMoveDown = CABasicAnimation(keyPath: "position.y")
    textMoveDown.fromValue = phoneLayer.bounds.midY
    textMoveDown.toValue = CGAffineTransform.identity
    textMoveDown.duration = 0.5
    textMoveDown.timingFunction = CAMediaTimingFunction(name: .linear)
    textLayer.add(textMoveDown, forKey: nil)
    
    let fingerMoveDownUP = CABasicAnimation(keyPath: "position.y")
    fingerMoveDownUP.fromValue = CGAffineTransform.identity
    fingerMoveDownUP.toValue = phoneLayer.bounds.maxY
    fingerMoveDownUP.autoreverses = true
    fingerMoveDownUP.duration = 0.5
    textMoveDown.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    fingerLayer.add(fingerMoveDownUP, forKey: nil)
  }
}

class ShowCaseView: UIView {
  private let headerText = Localized.string("tutorial_showcase_title")
  private let subHeaderText = Localized.string("tutorial_showcase_message")
  private let container = CALayer()
  private let phoneLayer = CALayer()
  private let headerLabel = WelcomeLabel(frame: .zero)
  private let subHeaderLabel = WelcomeLabel(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .yellow
    setupUI()
    setupLayers()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func resetAnimation() {
    prepAnimation()
  }
  
  private func setupUI() {
    subHeaderLabel.configSubHeaderLabel(text: subHeaderText)
    subHeaderLabel.frame.size.width = bounds.width * 0.7
    subHeaderLabel.sizeToFit()
    subHeaderLabel.center = CGPoint(x: center.x, y: bounds.maxY - subHeaderLabel.frame.height / 2)
    
    headerLabel.frame.size.width = bounds.width * 0.8
    headerLabel.configHeaderLabel(text: headerText)
    headerLabel.sizeToFit()
    headerLabel.center = center
    headerLabel.center.y = subHeaderLabel.frame.minY - headerLabel.frame.height / 2
    
    addSubview(headerLabel)
    addSubview(subHeaderLabel)
    
    container.frame = CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: bounds.height - headerLabel.frame.height - subHeaderLabel.frame.height))
  }
  
  private func setupLayers() {
    container.frame = CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: bounds.height - headerLabel.frame.height - subHeaderLabel.frame.height))
    layer.addSublayer(container)
    
    let phoneSize = CGSize(width: container.bounds.width * 0.6, height: container.bounds.height)
    let phoneXOffset = bounds.width / 5
    phoneLayer.frame = CGRect(origin: CGPoint(x: phoneXOffset, y: 0), size: phoneSize)
    phoneLayer.contents = ApplicationDependency.manager.currentTheme.imageAssets.tutorialPhone.cgImage
    phoneLayer.contentsGravity = .resizeAspect
    container.addSublayer(phoneLayer)
  }
  
  private func prepAnimation() {
    let scrollUp = CABasicAnimation(keyPath: "position.y")
    scrollUp.fromValue = -phoneLayer.frame.height + 100
    scrollUp.toValue = CGAffineTransform.identity
    scrollUp.duration = 0.5
    scrollUp.timingFunction = CAMediaTimingFunction(name: .easeOut)
    phoneLayer.add(scrollUp, forKey: nil)
  }
}
