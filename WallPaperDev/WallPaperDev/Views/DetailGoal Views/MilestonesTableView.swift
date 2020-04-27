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
    layer.borderColor = ApplicationDependency.manager.currentTheme.colors.lightGray.cgColor
    separatorInset = UIEdgeInsets(top: 0, left: 62, bottom: 0, right: 0)
    register(MilestoneCell.self, forCellReuseIdentifier: MilestoneCell.id)
    tableFooterView = UIView(frame: .zero)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
