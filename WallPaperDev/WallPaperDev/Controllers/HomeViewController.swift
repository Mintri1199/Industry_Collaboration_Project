//
//  HomeViewController.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // Turn the status bar on this VC white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private var homeTableView = UITableView(frame: .zero)
    private let titleView = HomeBackgroundView(frame: .zero)
    private let emptyStateView = EmptyStateView(frame: .zero)
    private let addButton = AddButton(frame: .zero)
    private let homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9052448869, green: 0.8998637795, blue: 0.9093814492, alpha: 1)
        initTitleView()
        setupTableView()
        initButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setupTableView() {
        let tableViewFrame = CGRect(x: 0, y: view.bounds.height * 0.4, width: view.bounds.width * 0.85, height: view.bounds.height * 0.5)
        homeTableView.frame = tableViewFrame
        homeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ID")
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.layer.cornerRadius = 25
        homeTableView.separatorStyle = .none
        homeTableView.center.x = view.center.x
        homeTableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(homeTableView)
    }
    
    private func initTitleView() {
        let titleViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2.3)
        titleView.frame = titleViewFrame
        view.addSubview(titleView)
    }
    
    private func initButton() {
        let addButtonFrame = CGRect(x: view.bounds.width * 0.75, y: view.bounds.height * 0.85, width: view.bounds.width / 5, height: view.bounds.width / 5)
        addButton.frame = addButtonFrame
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        view.addSubview(addButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func addTapped() {
        print("add tapped")
        let vc = CreateGoalViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate {
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if homeViewModel.goalsArr.isEmpty {
            homeTableView.backgroundView = emptyStateView
        }
        return homeViewModel.goalsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID", for: indexPath)
        cell.textLabel?.text = homeViewModel.goalsArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = PaddingLabel(frame: view.frame)
        label.frame = view.frame
        label.text = "Goals"
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
