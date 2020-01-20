//
//  ImageAsset.swift
//  WallPaperDev
//
//  Created by Alexander Dejeu on 1/20/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

// TODO: (alex) Introduce tests to ensure all assets are present if used
protocol ImageAsset {
  var background1: UIImage { get }
  var background2: UIImage { get }
  var background3: UIImage { get }

  var backgroundPreviewCamera: UIImage { get }
  var backgroundPreviewFlashlight: UIImage { get }
  var logo: UIImage { get }
  var tutorialExample1: UIImage { get }
  var tutorialFinger: UIImage { get }
  var tutorialGoalTextExample: UIImage { get }
  var tutorialPhone: UIImage { get }
  var tutorialTodoBanner: UIImage { get }
  var tutorialWelcomeBanner: UIImage { get }
}

struct DefaultImageAsset: ImageAsset {
  var background1: UIImage {
    return #imageLiteral(resourceName: "background_1")
  }

  var background2: UIImage {
    return #imageLiteral(resourceName: "background_2")
  }

  var background3: UIImage {
    return #imageLiteral(resourceName: "background_3")
  }

  var backgroundPreviewCamera: UIImage {
    return #imageLiteral(resourceName: "background_preview_camera")
  }

  var backgroundPreviewFlashlight: UIImage {
    return #imageLiteral(resourceName: "background_preview_flashlight")
  }

  var logo: UIImage {
    return #imageLiteral(resourceName: "logo")
  }

  var tutorialExample1: UIImage {
    return #imageLiteral(resourceName: "tutorial_example_1")
  }

  var tutorialFinger: UIImage {
    return #imageLiteral(resourceName: "tutorial_finger")
  }

  var tutorialGoalTextExample: UIImage {
    return #imageLiteral(resourceName: "tutorial_goal_text_example")
  }

  var tutorialPhone: UIImage {
    return #imageLiteral(resourceName: "tutorial_phone")
  }

  var tutorialTodoBanner: UIImage {
    return #imageLiteral(resourceName: "tutorial_todo_banner")
  }

  var tutorialWelcomeBanner: UIImage {
    return #imageLiteral(resourceName: "tutorial_welcome_banner")
  }
}


