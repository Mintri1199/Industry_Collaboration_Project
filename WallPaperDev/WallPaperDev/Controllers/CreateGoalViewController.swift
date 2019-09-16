//
//  ViewController.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/10/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class CreateGoalViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    lazy var createGoalView = CreateGoalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        _setupCreateGoalView()
        _setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       navigationController?.navigationBar.isHidden = false
    }
}

// MARK: Setup UI functions
extension CreateGoalViewController {
    private func _setupCreateGoalView() {
        createGoalView.frame = self.view.frame
        self.view.addSubview(createGoalView)
    }
    
    private func _setupNavBar() {
        navigationItem.title = "Create Goal"
    }
}
