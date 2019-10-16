//
//  WelcomeViewController.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    private let collectionView = WelcomeCollectionView(frame: .zero, collectionViewLayout: WelcomeCVLayout())
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configNavBar()
        setupCollectionView()
    }
}

// MARK: - UI functions
extension WelcomeViewController {
    private func configNavBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .navBarBlue
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SKIP", style: .plain, target: self, action: #selector(skipTapped))
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: view.bounds.height / 1.5)
        ])
        
    }
}

// MARK: - OBJC functions
extension WelcomeViewController {
    @objc private func skipTapped() {
        print("SKIP tapped")
    }
}
