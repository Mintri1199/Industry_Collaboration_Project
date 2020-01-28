//
//  BlueTextButton.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/24/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class GrayTextButton: UIButton {
  let label = BlueLabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    setupLabel()
    label.textColor = .gray
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupLabel() {
    addSubview(label)
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: leadingAnchor),
      label.trailingAnchor.constraint(equalTo: trailingAnchor),
      label.topAnchor.constraint(equalTo: topAnchor),
      label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
  }
}
