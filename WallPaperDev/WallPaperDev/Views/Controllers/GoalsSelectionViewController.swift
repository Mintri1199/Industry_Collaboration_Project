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
  private let viewModel = ChooseGoalViewModel()

  override var preferredStatusBarStyle: UIStatusBarStyle {
    .lightContent
  }

  init(goals: [Goal]) {
    super.init(nibName: nil, bundle: nil)
    viewModel.populateDataSource()
    viewModel.selectedGoals = goals
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupUIs()

    for goal in viewModel.selectedGoals {
      if let index = viewModel.goals.firstIndex(of: goal) {
        tableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .none)
      }
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
    let navigationTitle = String(format: Localized.string("choose_goal_title"),
                                 String(viewModel.selectedGoals.count),
                                 String(viewModel.selectedGoalMaxCount))
    navigationItem.title = navigationTitle
    navigationItem.hidesBackButton = true

    let newBackButton = UIBarButtonItem(title: Localized.string("back_action"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(newBackButtonTapped))
    navigationItem.leftBarButtonItem = newBackButton

    navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: navigationTitle)
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

    let goal = viewModel.goals[indexPath.row]
    cell.accessoryType = .detailButton
    cell.textLabel?.text = goal.name!
    return cell
  }
}

// MARK: - TableViewDelegate

extension GoalsSelectionViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    let description = viewModel.goals[indexPath.row].summary == nil ? Localized.string("message_for_goal_with_no_description") : viewModel.goals[indexPath.row].summary!
    let alertView = UIAlertController(title: viewModel.goals[indexPath.row].name!,
                                      message: description,
                                      preferredStyle: .alert)
    let okAction = UIAlertAction(title: Localized.string("ok_action"),
                                 style: .cancel,
                                 handler: nil)
    alertView.addAction(okAction)
    present(alertView, animated: true)
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.selectedGoals.append(viewModel.goals[indexPath.row])
    navigationItem.title = String(format: Localized.string("choose_goal_title"),
                                  String(viewModel.selectedGoals.count),
                                  String(viewModel.selectedGoalMaxCount))
  }

  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    if viewModel.selectedGoals.count == viewModel.selectedGoalMaxCount {
      return nil
    }
    return indexPath
  }

  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    viewModel.selectedGoals = viewModel.selectedGoals.filter({ $0 != viewModel.goals[indexPath.row] })
    navigationItem.title = String(format: Localized.string("choose_goal_title"),
                                  String(viewModel.selectedGoals.count),
                                  String(viewModel.selectedGoalMaxCount))
  }
}
