//
//  ViewController.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/10/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class CreateGoalViewController: UIViewController {

    let createGoalView = CreateGoalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createGoalView.frame = view.frame
        view.addSubview(createGoalView)
        navigationItem.title = "Create Goal"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
}

