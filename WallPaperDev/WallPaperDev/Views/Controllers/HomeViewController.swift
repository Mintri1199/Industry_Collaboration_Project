//
//  HomeViewController.swift
//  WallPaperDev
//
//  Created by Stephen Ouyang on 9/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  private var homeTableView = UITableView(frame: .zero)
  private let titleView = HomeBackgroundView(frame: .zero)
  private let emptyStateView = EmptyStateView(frame: .zero)
  private let addButton = AddButton(frame: .zero)
  private let wallpaperButton = AddButton(frame: .zero)
  private let homeViewModel = HomeViewModel()
  private let aboutButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.contentVerticalAlignment = .fill
    button.contentHorizontalAlignment = .fill
    let infoIcon = UIImage.templateIcon(for: "info.circle")
    button.tintColor = ApplicationDependency.manager.currentTheme.colors.white
    button.setImage(infoIcon!, for: .normal)
    return button
  }()
  
  weak var coordinator: MainCoordinator?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = ApplicationDependency.manager.currentTheme.colors.backgroundOffWhite
    initTitleView()
    setupTableView()
    initButton()
    setupWallpaperButton()
    setupAboutButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.coordinator?.navigationController.setNavigationBarHidden(true, animated: true)
    self.coordinator?.navigationController.navigationItem.hidesBackButton = true
    self.coordinator?.navigationController.navigationBar.prefersLargeTitles = true
    
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = ApplicationDependency.manager.currentTheme.colors.navBarBlue
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.shadowColor = nil
    self.coordinator?.navigationController.navigationBar.tintColor = .white
    self.coordinator?.navigationController.navigationBar.standardAppearance = appearance
    self.coordinator?.navigationController.navigationBar.compactAppearance = appearance
    self.coordinator?.navigationController.navigationBar.scrollEdgeAppearance = appearance
    
    homeViewModel.update {
      DispatchQueue.main.async {
        self.homeTableView.reloadData()
      }
    }
  }
}

// MARK: - UIs functions
extension HomeViewController {
  private func setupWallpaperButton() {
    let wallpaperButtonFrame = CGRect(x: addButton.frame.minX - addButton.frame.width - 20,
                                      y: view.bounds.height * 0.85,
                                      width: addButton.frame.width,
                                      height: addButton.frame.height)
    
    wallpaperButton.frame = wallpaperButtonFrame
    view.addSubview(wallpaperButton)
    wallpaperButton.backgroundColor = ApplicationDependency.manager.currentTheme.colors.wallpaperBlue
    wallpaperButton.titleLabel?.adjustsFontSizeToFitWidth = true
    wallpaperButton.setTitle(Localized.string("wallpaper_action"), for: .normal)
    wallpaperButton.addTarget(self, action: #selector(wallpaperButtonTapped), for: .touchUpInside)
    wallpaperButton.isHidden = true
  }
  
  private func setupTableView() {
    homeTableView.frame = CGRect(x: 0,
                                 y: view.bounds.height * 0.34,
                                 width: view.bounds.width * 0.85,
                                 height: view.bounds.height * 0.5)
    
    homeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ID")
    homeTableView.delegate = self
    homeTableView.dataSource = self
    homeTableView.layer.cornerRadius = 25
    homeTableView.separatorStyle = .none
    homeTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    homeTableView.center.x = view.center.x
    homeTableView.backgroundColor = ApplicationDependency.manager.currentTheme.colors.foregroundWhite
    homeTableView.bounces = false
    homeTableView.tableFooterView = UIView()
    view.addSubview(homeTableView)
  }
  
  private func initTitleView() {
    let titleViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2.3)
    titleView.frame = titleViewFrame
    view.addSubview(titleView)
  }
  
  private func initButton() {
    let addButtonFrame = CGRect(x: view.bounds.width * 0.75,
                                y: view.bounds.height * 0.85,
                                width: view.bounds.width / 5,
                                height: view.bounds.width / 5)
    
    addButton.frame = addButtonFrame
    addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    addButton.setTitle(Localized.string("add_action"), for: .normal)
    view.addSubview(addButton)
  }
  
  private func setupAboutButton() {
    view.addSubview(aboutButton)
    NSLayoutConstraint.activate([
      aboutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      aboutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      aboutButton.widthAnchor.constraint(equalToConstant: 25),
      aboutButton.heightAnchor.constraint(equalToConstant: 25)
    ])
    aboutButton.addTarget(self, action: #selector(aboutTapped), for: .touchUpInside)
  }
  
  @objc private func aboutTapped() {
    coordinator?.showAbout()
  }
  
  @objc private func addTapped() {
    coordinator?.showCreateGoal()
  }
  
  @objc private func wallpaperButtonTapped() {
    coordinator?.showImageCreation()
  }
}

// MARK: - TableViewDataDelegate
extension HomeViewController: UITableViewDelegate {
  func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedGoal = homeViewModel.goalsArr[indexPath.row]
    coordinator?.showGoal(selectedGoal: selectedGoal)
  }
}

// MARK: - TableViewDataSource
extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if homeViewModel.goalsArr.isEmpty {
      homeTableView.setEmptyView(title: Localized.string("set_goal_today_prompt"), message: "")
      if !wallpaperButton.isHidden {
        wallpaperButton.isHidden.toggle()
      }
    } else {
      homeTableView.restore()
      if wallpaperButton.isHidden {
        wallpaperButton.isHidden.toggle()
      }
    }
    
    return homeViewModel.goalsArr.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ID", for: indexPath)
    cell.textLabel?.text = homeViewModel.goalsArr[indexPath.row].name
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = PaddingLabel(frame: view.frame)
    label.frame = view.frame
    label.text = "Goals"
    label.font = ApplicationDependency.manager.currentTheme.fontSchema.heavy24
    label.backgroundColor = ApplicationDependency.manager.currentTheme.colors.foregroundWhite
    return label
  }
}

// MARK: - UINavigationControllerDelegate
extension HomeViewController: UINavigationControllerDelegate {
  func navigationController(_: UINavigationController, didShow _: UIViewController, animated _: Bool) {}
}
