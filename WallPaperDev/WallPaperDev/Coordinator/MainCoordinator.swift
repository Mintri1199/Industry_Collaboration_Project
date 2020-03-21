//
//  MainCoordinator.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
  var childCoordinator: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }

  func start()
}

// protocol BackwardConscious where Self: UIViewController {
//    var backwardHandler: ((_ passingInfo: [AnyHashable: Any]?) -> Void)? { get set }
//
//    func getPassingInfo() -> [AnyHashable: Any]?
//    func backwardCheck(with passingInfo: [AnyHashable: Any]?)
// }
//
// extension BackwardConscious {
//    func getPassingInfo() -> [AnyHashable: Any]? {
//        return nil
//    }
//
//    func backwardCheck(with passingInfo: [AnyHashable: Any]? = nil) {
//        if isMovingFromParent {
//            backwardHandler?(passingInfo)
//        } else {
//            if let navigationController = self.navigationController {
//                if navigationController.isBeingDismissed {
//                    backwardHandler?(passingInfo)
//                }
//            } else {
//                if isBeingDismissed {
//                    backwardHandler?(passingInfo)
//                }
//            }
//        }
//    }
// }

class MainCoordinator: Coordinator {
  var childCoordinator: [Coordinator] = []

  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    if UserDefaults.standard.bool(forKey: "Welcome") {
      let vc = HomeViewController()
      vc.coordinator = self
      navigationController.pushViewController(vc, animated: true)
    } else {
      let vc = WelcomeViewController()
      vc.coordinator = self
      navigationController.pushViewController(vc, animated: true)
    }
  }

  func showGoal(selectedGoal: Goal) {
    let vc = DetailGoalViewController(goal: selectedGoal)
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
  }

  func showCreateGoal() {
    let vc = CreateGoalViewController()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
  }

  func showImageCreation() {
    let vc = CreateImageViewController()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
  }

  func showImagePreview(_ image: UIImage, _ selectedGoals: [Goal]) {
    let vc = ImagePreviewViewController(image, selectedGoals)
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
  }

  func showGoalSelection(_ selectedGoals: [Goal] = []) {
    let vc = GoalsSelectionViewController(goals: selectedGoals)
    navigationController.pushViewController(vc, animated: true)
  }

  func popToHome() {
    for vc in navigationController.viewControllers {
      if let vc = vc as? HomeViewController {
        vc.coordinator = self
        navigationController.popToViewController(vc, animated: true)
      }
    }
  }
}
