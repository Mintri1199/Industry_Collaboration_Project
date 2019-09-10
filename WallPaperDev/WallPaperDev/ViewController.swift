//
//  ViewController.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/10/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let createGoalView = CreateGoalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createGoalView.frame = view.frame
        view.addSubview(createGoalView)
        navigationItem.title = "Create Goal"
    }
}

