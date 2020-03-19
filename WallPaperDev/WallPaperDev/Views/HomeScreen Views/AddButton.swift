//
//  AddButton.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/23/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

final class AddButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  override func didMoveToSuperview() {
    configButton()
  }

  private func configButton() {
    self.setTitle(Localized.string("add_action"), for: .normal)
    self.backgroundColor = ApplicationDependency.manager.currentTheme.colors.addButtonRed
    self.setTitleColor(ApplicationDependency.manager.currentTheme.colors.white, for: .normal)
    self.setTitleColor(ApplicationDependency.manager.currentTheme.colors.darkGray, for: .highlighted)
    self.titleLabel?.font = ApplicationDependency.manager.currentTheme.fontSchema.heavy20
    self.layer.cornerRadius = self.bounds.width / 2
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
