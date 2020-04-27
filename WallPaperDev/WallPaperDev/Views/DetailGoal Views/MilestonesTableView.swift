//
//  MilestonesTableView.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 4/15/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

class MilestonesTableView: UITableView {
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    separatorStyle = .none
    estimatedRowHeight = 40
    rowHeight = UITableView.automaticDimension
    layer.cornerRadius = 15
    register(MilestoneCell.self, forCellReuseIdentifier: MilestoneCell.id)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
