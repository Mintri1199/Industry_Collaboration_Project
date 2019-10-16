//
//  GoalsTableView.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/17/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class GoalsTableView: UITableView {
    static let cellId = "selectedGoal"
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        translatesAutoresizingMaskIntoConstraints = false
        bounces = false
        register(UITableViewCell.self, forCellReuseIdentifier: GoalsTableView.cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
