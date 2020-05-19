//
//  DevProfileCell.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 5/12/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

class DevProfileCell: UICollectionViewCell {
  static let id = "DevProfileCell"
  private let nameLabel = UILabel(frame: .zero)
  private let imageView = UIImageView(frame: .zero)

  // Flag: change input type to developer object
  func prepare(for dev: DevProfile) {
    nameLabel.text = dev.name
    imageView.image = dev.image
    setupImageView()
    setupLabel()
    backgroundColor = ApplicationDependency.manager.currentTheme.colors.white
    configureLayer()
  }

  private func setupLabel() {
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.font = ApplicationDependency.manager.currentTheme.fontSchema.medium16
    nameLabel.adjustsFontSizeToFitWidth = true
    nameLabel.textAlignment = .center
    addSubview(nameLabel)
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
      nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
		])
    nameLabel.sizeToFit()
  }

  private func setupImageView() {
    imageView.layer.cornerRadius = (bounds.size.width / 1.5) / 2

    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = .black
    imageView.contentMode = .scaleAspectFit
    addSubview(imageView)
    NSLayoutConstraint.activate([
      imageView.widthAnchor.constraint(equalToConstant: bounds.size.width / 1.5),
      imageView.heightAnchor.constraint(equalToConstant: bounds.size.width / 1.5),
      imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
		])
  }

  private func configureLayer() {
    layer.cornerRadius = bounds.width / 5
    addShadow(width: 0, height: 2, opacity: 0.75, radius: 2)
  }
}
