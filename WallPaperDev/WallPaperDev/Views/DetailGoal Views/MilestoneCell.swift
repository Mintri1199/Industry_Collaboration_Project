//
//  MilestoneCell.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 4/15/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

class MilestoneCell: UITableViewCell {
  
  static let id = "MilestoneCell"
  
  private let checkBox = CheckBoxButton(frame: .zero)
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  private func setupCheckBox() {
    addSubview(checkBox)
  }
  
  private func setupTextField() {}
}
