//
//  DetailViewController.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 10/8/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class DetailGoalViewController: CreateGoalViewController {
  
  private let viewModel: GoalDetailViewModel
  private let milestonesTableView = MilestonesTableView()
  private let mileStoneLabel = BlueLabel()
  private let addButton = UIButton()
  
  init(goal: Goal) {
    viewModel = GoalDetailViewModel(goal: goal)
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBlueButton()
    createGoalView.goalNameTextField.resignFirstResponder()
    configTextFields(goal: viewModel.goal)
    setupMilestoneLabel()
    setupAddButton()
    setupTable()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setupNavBar() {
    navigationItem.title = Localized.string("goal_details_title")
    navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: Localized.string("goal_details_title"))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped))
  }
  
  override func setupBlueButton() {
    view.addSubview(blueButton)
    blueButton.setTitle(Localized.string("update_action"), for: .normal)
    blueButton.removeTarget(nil, action: nil, for: .allEvents)
    NSLayoutConstraint.activate([
      blueButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
      blueButton.heightAnchor.constraint(equalToConstant: 50),
      blueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      blueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    
    blueButton.addTarget(self, action: #selector(updateTapped), for: .touchUpInside)
  }
}

// MARK: - UI setup function
extension DetailGoalViewController {
  
  private func configTextFields(goal: Goal) {
    guard let unwrappedName = goal.name,
      let unwrappedDescription = goal.summary else { return }
    createGoalView.goalNameTextField.text = unwrappedName
    createGoalView.goalDescriptionTextView.text = unwrappedDescription
    createGoalView.goalDescriptionTextView.textColor = ApplicationDependency.manager.currentTheme.colors.black
  }
  
  private func setupMilestoneLabel() {
    mileStoneLabel.text = Localized.string("milestone_title")
    mileStoneLabel.sizeToFit()
    view.addSubview(mileStoneLabel)
    mileStoneLabel.leadingAnchor.constraint(equalTo: createGoalView.goalNameLabel.leadingAnchor).isActive = true
    mileStoneLabel.topAnchor.constraint(equalTo: createGoalView.goalDescriptionTextView.bottomAnchor, constant: 10).isActive = true
  }
  
  private func setupAddButton() {
    addButton.translatesAutoresizingMaskIntoConstraints = false
    addButton.tintColor = ApplicationDependency.manager.currentTheme.colors.navBarBlue
    addButton.contentVerticalAlignment = .fill
    addButton.contentHorizontalAlignment = .fill
    addButton.setImage(UIImage(systemName: "plus.circle")?.withRenderingMode(.alwaysTemplate), for: .highlighted)
    addButton.setImage(UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
    view.addSubview(addButton)
    NSLayoutConstraint.activate([
      addButton.heightAnchor.constraint(equalTo: mileStoneLabel.heightAnchor, multiplier: 1),
      addButton.widthAnchor.constraint(equalTo: mileStoneLabel.heightAnchor, multiplier: 1),
      addButton.topAnchor.constraint(equalTo: mileStoneLabel.topAnchor),
      addButton.trailingAnchor.constraint(equalTo: createGoalView.goalDescriptionTextView.trailingAnchor)
    ])
    addButton.addTarget(self, action: #selector(showMilestoneprompt), for: .touchUpInside)
  }
  
  private func setupTable() {
    view.addSubview(milestonesTableView)
    milestonesTableView.dataSource = self
    milestonesTableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      milestonesTableView.topAnchor.constraint(equalTo: mileStoneLabel.bottomAnchor, constant: 15),
      milestonesTableView.leadingAnchor.constraint(equalTo: mileStoneLabel.leadingAnchor),
      milestonesTableView.trailingAnchor.constraint(equalTo: addButton.trailingAnchor),
      milestonesTableView.bottomAnchor.constraint(equalTo: blueButton.topAnchor, constant: -15)
    ])
  }
  
  private func setupCustomEmptyView() {
    let emptyView = EmptyStateView()
    emptyView.frame = milestonesTableView.bounds
    emptyView.noGoalsLabel.text = Localized.string("no_milestone_prompt")
    milestonesTableView.backgroundView = emptyView
  }
  
  // adjust table view height function
}

// MARK: - OBJC methods
extension DetailGoalViewController {
  @objc private func updateTapped() {
    if validInputs() {
      guard let userGoalName = createGoalView.goalNameTextField.text,
        let userGoalSummary = createGoalView.goalDescriptionTextView.text else {
        return
      }
      viewModel.updateGoal(userGoalName, userGoalSummary)
      navigationController?.popViewController(animated: true)
    } else {
      presentError()
    }
  }
  
  @objc private func deleteTapped() {
    viewModel.delete()
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func showMilestoneprompt() {
    let promptVC = MilestonePromptVC()
    promptVC.delegate = self
    promptVC.modalPresentationStyle = .fullScreen
    present(promptVC, animated: true, completion: nil)
  }
}

extension DetailGoalViewController: passMilestoneData {
  func passMilestone(_ description: String) {
    print(description)
  }
}

extension DetailGoalViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.milestones.isEmpty ? setupCustomEmptyView() : tableView.restore()
    
    return viewModel.milestones.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}

extension DetailGoalViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      tableView.deleteRows(at: [indexPath], with: .left)
    }
  }
}
