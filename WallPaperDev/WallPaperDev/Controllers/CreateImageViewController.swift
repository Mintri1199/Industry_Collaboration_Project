//
//  CreateImageViewController.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class CreateImageViewController: UIViewController {
    // MARK: - Custom UIs
    lazy var createImageButton = BigBlueButton(frame: .zero)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupNavBar()
        _setupBlueButton()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

// MARK: - Setup UI functions
extension CreateImageViewController {
    
    private func _setupBlueButton() {
        self.view.addSubview(createImageButton)
        createImageButton.setTitle("Create", for: .normal)
        createImageButton.addTarget(self, action: #selector(pushToPreview), for: .touchUpInside)
        NSLayoutConstraint.activate([
            createImageButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6),
            createImageButton.heightAnchor.constraint(equalToConstant: 50),
            createImageButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            createImageButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
    }
    
    private func setupNavBar() {
        navigationItem.title = "Create Wallpaper"
        navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: .long)
    }
}

// MARK: - Objc functions
extension CreateImageViewController {
    @objc func pushToPreview() {
        let previewVC = ImagePreviewViewController()
        navigationController?.pushViewController(previewVC, animated: true)
    }
}
