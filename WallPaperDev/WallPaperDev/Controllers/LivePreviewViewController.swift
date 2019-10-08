//
//  LivePreviewViewController.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/26/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class LivePreviewViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    lazy var livePreview: UIImageView = {
        let view = UIImageView(frame: UIScreen.main.bounds)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLivePreview()
    }
    
    @objc private func dismissPreview() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupLivePreview() {
        view.addSubview(livePreview)
        livePreview.backgroundColor = .brown
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissPreview))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
}
