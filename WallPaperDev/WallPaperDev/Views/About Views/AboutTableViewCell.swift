//
// Created by Jackson Ho on 5/13/20.
// Copyright (c) 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

final class AboutTableViewCell: UITableViewCell {

  enum CellType {
    case credits(text: NSAttributedString)
    case library(title: String, license: String)
  }

  private lazy var feedbackTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.textAlignment = .natural
    textView.isScrollEnabled = false
    textView.isEditable = false
    return textView
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = ApplicationDependency.manager.currentTheme.fontSchema.black32
    label.textColor = ApplicationDependency.manager.currentTheme.colors.black
    label.textAlignment = .left
    label.adjustsFontSizeToFitWidth = true
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var bodyTextLabel: UILabel = {
    let label = UILabel()
    label.font = ApplicationDependency.manager.currentTheme.fontSchema.medium16
    label.textColor = ApplicationDependency.manager.currentTheme.colors.black
    label.textAlignment = .left
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var profileCollectionView = DevProfileCollectionView()

  func prepareProfiles(completion: (UICollectionView) -> Void) {
    profileCollectionView.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3))
    addSubview(profileCollectionView)
    NSLayoutConstraint.activate([
      profileCollectionView.topAnchor.constraint(equalTo: topAnchor),
      profileCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
      profileCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      profileCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
    completion(profileCollectionView)
  }

  func prepare(type: CellType) {
    switch type {
    case let .credits(text):
      feedbackTextView.attributedText = text
      feedbackTextView.font = ApplicationDependency.manager.currentTheme.fontSchema.medium20
      feedbackTextView.textColor = ApplicationDependency.manager.currentTheme.colors.black
      setupTextView()

    case let .library(title, license):
      if subviews.contains(feedbackTextView) {
        feedbackTextView.removeFromSuperview()
      }
      titleLabel.text = title
      setupTitleLabel()
      bodyTextLabel.text = license
      setupBodyTextLabel()
    }
  }

  private func setupTitleLabel() {
    addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
    titleLabel.sizeToFit()
  }

  private func setupBodyTextLabel() {
    addSubview(bodyTextLabel)
    NSLayoutConstraint.activate([
      bodyTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      bodyTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      bodyTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      bodyTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
    bodyTextLabel.sizeToFit()
  }

  private func setupTextView() {
    addSubview(feedbackTextView)
    NSLayoutConstraint.activate([
      feedbackTextView.topAnchor.constraint(equalTo: topAnchor),
      feedbackTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
      feedbackTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
      feedbackTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])

    feedbackTextView.sizeToFit()
  }
}
