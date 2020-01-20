//
//  WelcomeViewController.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    private var cellIndex = 0
    weak var coordinator: MainCoordinator?
    private let collectionView = WelcomeCollectionView(frame: .zero, collectionViewLayout: WelcomeCVLayout())
    private let pageIndicators = PageIndicators(frame: .zero)
    private let backButton: UIButton = {
        var button = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
      button.setTitle(Localized.string("back_action").uppercased(), for: .normal)
        button.isHidden = true
        button.isEnabled = false
        button.setTitleColor(.navBarBlue, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()
    private let nextButton: UIButton = {
        var button = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
      button.setTitle(Localized.string("next_action").uppercased(), for: .normal)
        button.setTitleColor(.navBarBlue, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()
    private let startButton = BigBlueButton(frame: .zero)
    private var startButtonTrailingConstraint: NSLayoutConstraint?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configNavBar()
        setupUI()
    }
}

// MARK: - UI functions
extension WelcomeViewController {
    private func configNavBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .navBarBlue
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: Localized.string("skip_action").uppercased(),
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(skipTapped))
    }
    
    private func setupUI() {
        setupCollectionView()
        setupPageIndicators()
        setupNextButton()
        setupBackButton()
        setupStartButton()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(nextTapped))
        swipeLeft.direction = .left

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(backTapped))
        swipeRight.direction = .right

        collectionView.addGestureRecognizer(swipeRight)
        collectionView.addGestureRecognizer(swipeLeft)

        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: view.bounds.height / 1.5)
        ])
    }
    
    private func setupPageIndicators() {
        view.addSubview(pageIndicators)
        NSLayoutConstraint.activate([
            pageIndicators.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageIndicators.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            pageIndicators.widthAnchor.constraint(equalToConstant: 75),
            pageIndicators.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func setupNextButton() {
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.centerYAnchor.constraint(equalTo: pageIndicators.centerYAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 15),
            nextButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupBackButton() {
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: pageIndicators.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 15),
            backButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupStartButton() {
        view.addSubview(startButton)
        startButton.isEnabled = false
      startButton.setTitle(Localized.string("start_action").uppercased(), for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        startButtonTrailingConstraint = startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 100)
        startButtonTrailingConstraint?.isActive = true
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        startButton.layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            startButton.centerYAnchor.constraint(equalTo: pageIndicators.centerYAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 40),
            startButton.widthAnchor.constraint(equalToConstant: 75)
        ])
    }
}

// MARK: - OBJC functions
extension WelcomeViewController {
    
    @objc private func skipTapped() {
        UserDefaults.standard.set(true, forKey: "Welcome")
        coordinator?.start()
    }
    
    @objc private func startTapped() {
        // TODO: Trigger guided onboarding
        UserDefaults.standard.set(true, forKey: "Welcome")
        coordinator?.start()
    }
    
    @objc private func backTapped() {
        if cellIndex == 0 {
            return 
        }
        if startButton.isEnabled {
            startButton.isEnabled = false
            startButtonTrailingConstraint?.constant = 100
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.nextButton.isHidden = false
                self.nextButton.isEnabled = true
            })
        }
        
        cellIndex -= 1
        
        pageIndicators.selectPage(at: cellIndex, prev: cellIndex + 1)
        let indexPath = IndexPath(row: cellIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if cellIndex == 0 {
            backButton.isHidden = true
            backButton.isEnabled = false
        }
    }
    
    @objc private func nextTapped() {
        if cellIndex == 3 {
            return 
        }
        if backButton.isHidden {
            backButton.isHidden = false
            backButton.isEnabled = true
        }
        
        cellIndex += 1
        
        pageIndicators.selectPage(at: cellIndex, prev: cellIndex - 1)
        let indexPath = IndexPath(row: cellIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if cellIndex == 3 {
            nextButton.isHidden = true
            nextButton.isEnabled = false
            startButtonTrailingConstraint?.constant = -20
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.startButton.isEnabled = true
            })
        }
    }
}
