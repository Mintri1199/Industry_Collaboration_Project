//
//  HomeViewController.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let titleView = HomeBackgroundView(frame: .zero)
    let emptyStateView = EmptyStateView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9052448869, green: 0.8998637795, blue: 0.9093814492, alpha: 1)
        initViews()
    }
    
    private func initViews() {
        let titleViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2.3)
        let emptyStateViewFrame = CGRect(x: 0, y: view.bounds.height * 0.38, width: view.frame.width * 0.9, height: view.frame.height / 2)
        titleView.frame = titleViewFrame
        emptyStateView.frame = emptyStateViewFrame
        emptyStateView.center.x = view.center.x
        view.addSubview(titleView)
        view.addSubview(emptyStateView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}
