//
//  GoalsViewController.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/23/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

protocol PassSelectedGoals: class {
    func passSelectedGoals(_ array: [String])
}

class GoalsSelectionViewController: UIViewController {
    
    private let cellId: String = "chooseGoalCell"
    private let tableView = GoalsTableView(frame: .zero, style: .plain)
    weak var delegate: PassSelectedGoals?
    let viewModel = ChooseGoalViewModel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUIs()
    }
}

// MARK: - UI functions
extension GoalsSelectionViewController {
    private func setupUIs() {
        setupNavBar()
        setupTableView()
        registerSwipe()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Choose Goal \(viewModel.selectedGoals.count) / 4"
        navigationItem.hidesBackButton = true
        
        let newBackButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(newBackButtonTapped))
        navigationItem.leftBarButtonItem = newBackButton
        navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: "Choose Goal \(viewModel.selectedGoals.count) / 4")
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        view.addSubview(tableView)
    }
    
    private func registerSwipe() {
        let swipingRight = UISwipeGestureRecognizer(target: self, action: #selector(newBackButtonTapped))
        swipingRight.direction = .right
        view.addGestureRecognizer(swipingRight)
    }
}

// MARK: - Objc functions
extension GoalsSelectionViewController {
    @objc private func newBackButtonTapped() {
        delegate?.passSelectedGoals(viewModel.selectedGoals)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - TableViewDataSource
extension GoalsSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.accessoryType = .detailButton
        
        if viewModel.selectedGoals.contains(goalArray[indexPath.row]) {
            cell.isSelected = true
        }
        
        cell.textLabel?.text = goalArray[indexPath.row]
        return cell
    }
}

// MARK: - TableViewDelegate
extension GoalsSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let alertView = UIAlertController(title: goalArray[indexPath.row], message: descriptionArray[indexPath.row], preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedGoals.append(goalArray[indexPath.row])
        navigationItem.title = "Choose Goal \(viewModel.selectedGoals.count) / 4"
        print("Select: \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if viewModel.selectedGoals.count == 4 {
            return nil
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel.selectedGoals = viewModel.selectedGoals.filter({ $0 != goalArray[indexPath.row] })
        navigationItem.title = "Choose Goal \(viewModel.selectedGoals.count) / 4"
        print("Deselect: \(indexPath)")
    }
}
