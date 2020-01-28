//
//  GoalsViewController.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/23/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

protocol PassSelectedGoals: AnyObject {
    func passSelectedGoals(_ array: [Goal])
}

class GoalsSelectionViewController: UIViewController {
    private let cellId: String = "chooseGoalCell"
    private let tableView = GoalsTableView(frame: .zero, style: .plain)
    weak var delegate: PassSelectedGoals?
    let viewModel = ChooseGoalViewModel()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUIs()
        viewModel.populateDataSource()
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
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.goals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.accessoryType = .detailButton

        if viewModel.selectedGoals.contains(viewModel.goals[indexPath.row]) {
            cell.isSelected = true
        }

        cell.textLabel?.text = viewModel.goals[indexPath.row].name!
        return cell
    }
}

// MARK: - TableViewDelegate

extension GoalsSelectionViewController: UITableViewDelegate {
    func tableView(_: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let description = viewModel.goals[indexPath.row].summary == nil ? "There is no description for this goal" : viewModel.goals[indexPath.row].summary!
        let alertView = UIAlertController(title: viewModel.goals[indexPath.row].name!, message: description, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedGoals.append(viewModel.goals[indexPath.row])
        navigationItem.title = "Choose Goal \(viewModel.selectedGoals.count) / 4"
    }

    func tableView(_: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if viewModel.selectedGoals.count == 4 {
            return nil
        }
        return indexPath
    }

    func tableView(_: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel.selectedGoals = viewModel.selectedGoals.filter { $0 != viewModel.goals[indexPath.row] }
        navigationItem.title = "Choose Goal \(viewModel.selectedGoals.count) / 4"
    }
}
