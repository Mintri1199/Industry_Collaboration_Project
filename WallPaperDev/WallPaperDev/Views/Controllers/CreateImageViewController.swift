//
//  CreateImageViewController.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import CoreImage
import UIKit

class CreateImageViewController: UIViewController {
  
  // MARK: - Custom UIs
  private lazy var createImageButton = BigBlueButton(frame: .zero)
  private lazy var selectedImageView = UIImageView(frame: .zero)
  private lazy var chooseImageLabel = BlueLabel(frame: .zero)
  private lazy var chooseGoalLabel = BlueLabel(frame: .zero)
  private lazy var chooseImageStack = UIStackView()
  private lazy var imagePickerButton: CircleButton = {
    var button = CircleButton()
    button.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width * 0.15, height: view.bounds.width * 0.15))
    button.setupIcon(for: .camera)
    return button
  }()
  
  private lazy var unsplashButton: CircleButton = {
    var button = CircleButton()
    button.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width * 0.15, height: view.bounds.width * 0.15))
    button.setupIcon(for: .unsplash)
    return button
  }()
  
  private lazy var goalsTableView = GoalsTableView(frame: .zero, style: .plain)
  private lazy var changeGoalsButton = GrayTextButton(frame: .zero)
  private lazy var emptyView = SelectedGoalsEmptyView()
  
  private let viewModel = SelectionViewModel()
  weak var coordinator: MainCoordinator?
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    coordinator?.navigationController.setNavigationBarHidden(false, animated: true)
    setupViews()
  }
  
  private func expandImageView() {
    if viewModel.selectedImage != nil && selectedImageView.frame.height == 0 {
      selectedImageView.constraints.forEach { constaint in
        if constaint.firstAnchor == selectedImageView.heightAnchor && constaint.constant == 0 {
          let newHeight = view.bounds.height * 0.27
          constaint.constant = newHeight
          selectedImageView.layer.cornerRadius = newHeight / 4
          UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
          }
        }
      }
    }
  }
}

// MARK: - Setup UI functions
extension CreateImageViewController {
  private func setupViews() {
    setupNavBar()
    setupBlueButton()
    setupChooseImageLabel()
    setupSelectedImageView()
    setupChooseImageStackView()
    setupChooseGoalLabel()
    setupChangeGoalsButtonButton()
    setupTableView()
  }
  
  private func setupChooseImageLabel() {
    chooseImageLabel.text = Localized.string("choose_image_title")
    self.view.addSubview(chooseImageLabel)
    NSLayoutConstraint.activate([
      chooseImageLabel.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
      chooseImageLabel.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07),
      chooseImageLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
      chooseImageLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
    ])
  }
  
  private func setupSelectedImageView() {
    selectedImageView.translatesAutoresizingMaskIntoConstraints = false
    selectedImageView.contentMode = .scaleAspectFill
    selectedImageView.layer.borderColor = ApplicationDependency.manager.currentTheme.colors.white.cgColor
    selectedImageView.layer.borderWidth = 5
    selectedImageView.clipsToBounds = true
    view.addSubview(selectedImageView)
    NSLayoutConstraint.activate([
      selectedImageView.topAnchor.constraint(equalToSystemSpacingBelow: chooseImageLabel.bottomAnchor, multiplier: 0.5),
      selectedImageView.leadingAnchor.constraint(equalTo: chooseImageLabel.leadingAnchor),
      selectedImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
      selectedImageView.heightAnchor.constraint(equalToConstant: 0)
    ])
  }
  
  private func setupChooseImageStackView() {
    chooseImageStack.axis = .horizontal
    chooseImageStack.spacing = 10
    chooseImageStack.distribution = .fillEqually
    chooseImageStack.translatesAutoresizingMaskIntoConstraints = false
    chooseImageStack.addArrangedSubview(imagePickerButton)
    chooseImageStack.addArrangedSubview(unsplashButton)
    chooseImageStack.backgroundColor = .red
    imagePickerButton.setupBorder(view.bounds.width * 0.15)
    unsplashButton.setupBorder(view.bounds.width * 0.15)
    view.addSubview(chooseImageStack)
    NSLayoutConstraint.activate([
      chooseImageStack.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: 10),
      chooseImageStack.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
      chooseImageStack.widthAnchor.constraint(equalToConstant: ((view.bounds.width * 0.15) * 2) + 10),
      chooseImageStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
    ])
    
    unsplashButton.addTarget(self, action: #selector(pushToUnsplash), for: .touchUpInside)
    imagePickerButton.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
  }
  
  private func setupChooseGoalLabel() {
    chooseGoalLabel.text = Localized.string("choose_goal_action")
    self.view.addSubview(chooseGoalLabel)
    NSLayoutConstraint.activate([
      chooseGoalLabel.widthAnchor.constraint(equalTo: chooseImageLabel.widthAnchor),
      chooseGoalLabel.heightAnchor.constraint(equalTo: chooseImageLabel.heightAnchor),
      chooseGoalLabel.leadingAnchor.constraint(equalTo: chooseImageLabel.leadingAnchor),
      chooseGoalLabel.topAnchor.constraint(equalTo: chooseImageStack.bottomAnchor)
    ])
  }
  
  private func setupBlueButton() {
    self.view.addSubview(createImageButton)
    createImageButton.isHidden = true
    createImageButton.setTitle(Localized.string("create_action"), for: .normal)
    createImageButton.addTarget(self, action: #selector(pushToPreview), for: .touchUpInside)
    NSLayoutConstraint.activate([
      createImageButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6),
      createImageButton.heightAnchor.constraint(equalToConstant: 50),
      createImageButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      createImageButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
    ])
  }
  
  private func setupChangeGoalsButtonButton() {
    self.view.addSubview(changeGoalsButton)
    changeGoalsButton.isHidden = true
    changeGoalsButton.label.text = Localized.string("change_goals_action")
    changeGoalsButton.label.textAlignment = .right
    changeGoalsButton.addTarget(self, action: #selector(pushToGoalSelection), for: .touchUpInside)
    NSLayoutConstraint.activate([
      changeGoalsButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
      changeGoalsButton.heightAnchor.constraint(equalTo: chooseImageLabel.heightAnchor),
      changeGoalsButton.topAnchor.constraint(equalTo: chooseGoalLabel.topAnchor),
      changeGoalsButton.leadingAnchor.constraint(equalTo: chooseGoalLabel.trailingAnchor, constant: 50)
    ])
  }
  
  private func setupTableView() {
    view.addSubview(goalsTableView)
    goalsTableView.dataSource = self
    goalsTableView.allowsSelection = false
    goalsTableView.tableFooterView = UIView(frame: .zero)
    NSLayoutConstraint.activate([
      goalsTableView.topAnchor.constraint(equalTo: chooseGoalLabel.bottomAnchor, constant: 5),
      goalsTableView.leadingAnchor.constraint(equalTo: chooseImageLabel.leadingAnchor),
      goalsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
      goalsTableView.bottomAnchor.constraint(greaterThanOrEqualTo: createImageButton.topAnchor, constant: -10)//(equalTo: createImageButton.topAnchor, constant: -10)
    ])
  }
  
  private func setupCustomEmptyView() {
    emptyView.frame = goalsTableView.bounds
    goalsTableView.backgroundView = emptyView
    emptyView.chooseGoalButton.addTarget(self, action: #selector(pushToGoalSelection), for: .touchUpInside)
    goalsTableView.separatorStyle = .none
  }
  
  private func setupNavBar() {
    navigationItem.title = Localized.string("create_wallpaper_title")
    navigationController?.navigationBar.largeTitleTextAttributes = navigationController?.navigationBar.configLargeText(length: Localized.string("create_wallpaper_title"))
  }
}

// MARK: - CAAnimationDelegate

extension CreateImageViewController: CAAnimationDelegate {
  func animationDidStop(_ anim: CAAnimation, finished _: Bool) {
    if let button = anim.value(forKey: "button") as? BigBlueButton {
      if let value = anim.value(forKey: "name") as? String {
        button.isHidden = value == "moveDown"
      }
    }
  }
}

// MARK: - Objc functions

extension CreateImageViewController {
  @objc private func pushToPreview() {
    guard let image = viewModel.selectedImage else {
      return
    }
    coordinator?.showImagePreview(image, viewModel.selectedGoals)
  }
  
  @objc private func pushToGoalSelection() {
    let goalsVC = GoalsSelectionViewController(goals: viewModel.selectedGoals)
    goalsVC.delegate = self
    navigationController?.pushViewController(goalsVC, animated: true)
  }
  
  @objc private func changeGoalTapped() {
    // TODO: Figure out how to use coordinator for passing data back
    let goalsVC = GoalsSelectionViewController(goals: viewModel.selectedGoals)
    goalsVC.delegate = self
    navigationController?.pushViewController(goalsVC, animated: true)
  }
  
  @objc private func showPicker() {
    let pickerController = UIImagePickerController()
    pickerController.sourceType = .photoLibrary
    pickerController.modalPresentationStyle = .popover
    pickerController.delegate = self
    present(pickerController, animated: true, completion: nil)
  }
  
  @objc private func pushToUnsplash() {
    let vc = SearchImageViewController()
    vc.delegate = self
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension CreateImageViewController: PassSelectedGoals {
  func passSelectedGoals(_ array: [Goal]) {
    viewModel.selectedGoals = array.isEmpty ? [] : array
    changeGoalsButton.isHidden = array.isEmpty
    viewModel.validation(button: createImageButton)
    goalsTableView.reloadData()
  }
}

// MARK: - TableViewDelegate
extension CreateImageViewController: UITableViewDelegate {
  // Currently serving no purpose at the moment but later can use drag to order
}

// MARK: - TableViewDataSource
extension CreateImageViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection _: Int) -> Int {
    viewModel.selectedGoals.isEmpty ? setupCustomEmptyView() : tableView.restore()
    return viewModel.selectedGoals.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: GoalsTableView.cellId, for: indexPath)
    if let name = viewModel.selectedGoals[indexPath.row].name {
      cell.textLabel?.text = name
    }
    return cell
  }
}

// MARK: - SelectedImageDelegate
extension CreateImageViewController: SelectedImageDelegate {
  func passImageSelected(image: UIImage) {
    viewModel.selectedImage = image
    selectedImageView.image = image
    expandImageView()
  }
}

// MARK: - ImagePickerDelegate
extension CreateImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    return
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    guard let image = info[.originalImage] as? UIImage else {
      return
    }
    
    viewModel.selectedImage = image
    selectedImageView.image = image
    expandImageView()
    picker.dismiss(animated: true, completion: nil)
  }
}
