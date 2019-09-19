//
//  ImagePreviewViewController.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
    }
}

// MARK: - UIs setup functions
extension ImagePreviewViewController {
    
    private func setupViews() {
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Preview"
        
        navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: "Preview")
    }
}
