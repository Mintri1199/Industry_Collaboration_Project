//
//  ImageAsset.swift
//  WallPaperDev
//
//  Created by Alexander Dejeu on 1/20/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

protocol ImageAsset {
  var backgroundPreviewCamera: UIImage { get }
  var backgroundPreviewFlashlight: UIImage { get }
  var logo: UIImage { get }
  var tutorialExample1: UIImage { get }
  var tutorialFinger: UIImage { get }
  var tutorialGoalTextExample: UIImage { get }
  var tutorialPhone: UIImage { get }
  var tutorialTodoBanner: UIImage { get }
  var tutorialWelcomeBanner: UIImage { get }
  var unsplashLogo: UIImage { get }
  var jacksonProfile: UIImage { get }
  var jamarProfile: UIImage { get }
  var alexProfile: UIImage { get }
  var stephenProfile: UIImage { get }
}

struct DefaultImageAsset: ImageAsset {
  var unsplashLogo: UIImage {
    return #imageLiteral(resourceName: "unsplash")
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

  var jacksonProfile: UIImage {
    return #imageLiteral(resourceName: "jackson_cropped")
  }

  var jamarProfile: UIImage {
    return #imageLiteral(resourceName: "jamar_cropped")
  }

  var alexProfile: UIImage {
    return #imageLiteral(resourceName: "alex_cropped")
  }

  var stephenProfile: UIImage {
    return #imageLiteral(resourceName: "stephen_cropped")
  }
}
