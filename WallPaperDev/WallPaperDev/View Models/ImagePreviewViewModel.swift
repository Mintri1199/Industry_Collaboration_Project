//
//  ImagePreviewViewModel.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/26/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import CoreGraphics
import CropViewController
import Foundation
import UIKit

enum ImageProcessError: String, Error {
  case unableToProcessImage
  case noImage
  case noText
  case unableToCreateTextLayer
}

class ImagePreviewViewModel: ViewModelProtocol {
  private let originalImage: UIImage
  var croppedImage: UIImage?
  var selectedGoals: [Goal] = []
  var currentCropRect = CGRect(origin: .zero, size: .zero)
  var textLayerRect: CGRect?
  var textLayerRotation: CGFloat?
  var labelText: String?
  var rotate: Int = 0

  init(image: UIImage, goals: [Goal]) {
    self.originalImage = image
    self.selectedGoals = goals
  }

  func configureCropVC() -> CropViewController? {
    // Build an instance of CropViewController for the VC to present
    let cropVC = CropViewController(croppingStyle: .default, image: originalImage)
    cropVC.modalPresentationStyle = .fullScreen
    // Must configure the currentCropRect before should not be zero
    cropVC.imageCropFrame = currentCropRect

    cropVC.angle = rotate
    cropVC.aspectRatioPreset = .presetCustom
    cropVC.customAspectRatio = UIScreen.main.bounds.size
    cropVC.aspectRatioLockEnabled = true
    cropVC.resetAspectRatioEnabled = false
    cropVC.aspectRatioPickerButtonHidden = true
    cropVC.toolbarPosition = .bottom
    return cropVC
  }

  func initialGenerate(completion: @escaping (UIImage) -> Void) {
    // This function will generate a wallpaper initially when the user preview the picture

    // constants
    let imageSize = originalImage.size
    let screenWidthRatio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
    let screenHeightRatio = UIScreen.main.bounds.height / UIScreen.main.bounds.width

    var cropHeight: CGFloat = imageSize.height
    var cropWidth: CGFloat = imageSize.width

    // Configure the cropping size to the screen ratio
    if imageSize.width * screenHeightRatio > imageSize.height {
      cropWidth = imageSize.height * screenWidthRatio
    } else if imageSize.height * screenWidthRatio > imageSize.width {
      cropHeight = imageSize.width * screenHeightRatio
    }

    // center the crop size to the center of the image
    let cropOriginX = (imageSize.width / 2) - (cropWidth / 2)
    let cropOriginY = (imageSize.height / 2) - (cropHeight / 2)

    // Set the cropping rect
    currentCropRect = CGRect(origin: CGPoint(x: cropOriginX, y: cropOriginY),
                             size: CGSize(width: cropWidth, height: cropHeight))

    // Create the cropped image
    guard let cropImage = originalImage.cgImage?.cropping(to: currentCropRect) else {
      return
    }

    // Focus on getting the right crop image first
    let initialCropImage = UIImage(cgImage: cropImage)
    croppedImage = initialCropImage
    completion(initialCropImage)

//    let goalsText: String = selectedGoals.compactMap { $0.name }.joined(separator: "\n")
//    labelText = goalsText
//    // Configure the attributes and font for the string
//    let paragraphStyle = NSMutableParagraphStyle()
//    paragraphStyle.alignment = .center
//
//    let bestFont = UIFont.bestFittingFont(for: goalsText,
//                                          in: CGRect(origin: currentCropRect.origin, size: CGSize(width: currentCropRect.size.width * 0.65, height: currentCropRect.size.height / 6)),
//                                          fontDescriptor: ApplicationDependency.manager.currentTheme.fontSchema.medium20.fontDescriptor)
//
//    let textAttr: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.font: bestFont,
//                                                    NSAttributedString.Key.foregroundColor: UIColor.white,
//                                                    NSAttributedString.Key.paragraphStyle: paragraphStyle ]
//    // Get the size to fit the text
//    let textSize = goalsText.size(withAttributes: textAttr)
//    // Configure the CGRect with the text size and position it at the bottom of the screen
//    let drawTextRect = CGRect(origin: CGPoint(x: (initialCropImage.size.width - textSize.width) / 2, y: initialCropImage.size.height - (textSize.height * 1.5 )),
//                              size: textSize)
//    textLayerRect = drawTextRect
//    // Draw the image with the text on it
//    UIGraphicsBeginImageContextWithOptions(initialCropImage.size, false, UIScreen.main.scale)
//    initialCropImage.draw(in: currentCropRect)
//    goalsText.draw(in: drawTextRect, withAttributes: textAttr)
//    let newImage = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//
//    if let newImage = newImage {
//      completion(newImage)
//    }
  }

  func updateImage(completion: @escaping (Result<UIImage, ImageProcessError>) -> Void) {
    guard let image = croppedImage else {
      completion(.failure(.noImage))
      return
    }

    generateTextLayer { result in
      switch result {
      case let .success(textLayer):
        UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        image.draw(in: self.currentCropRect)
        context.translateBy(x: textLayer.frame.origin.x, y: textLayer.frame.origin.y)
        // MARK: - Figure out how to draw rotate textlayer while keeping it original shape
        //                if let rotation = self.textLayerRotation {
//                    print(rotation)
//                    context.rotate(by: rotation)
//                }
        textLayer.draw(in: context)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if let newImage = newImage {
          completion(.success(newImage))
        } else {
          completion(.failure(.unableToProcessImage))
        }

      case let .failure(error):
        #if DEBUG
          print(error.rawValue)
        #endif
        completion(.failure(.noText))
      }
    }
  }

  private func generateTextLayer(completion: @escaping (Result<CATextLayer, ImageProcessError>) -> Void) {
    guard let textRect = textLayerRect else {
      completion(.failure(.unableToCreateTextLayer))
      return
    }
    // TODO: Figure out how to configure this more
    let text = selectedGoals.compactMap { $0.name }.joined(separator: "\n")
    labelText = text
    let bestFont = UIFont.bestFittingFont(for: text, in: textRect, fontDescriptor: UIFontDescriptor(name: "Helvetica Bold", size: 20))
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center

    let textLayer = CATextLayer()
    textLayer.frame = textRect // CGRect(x: (textRect.origin.x * image.scale), y: (textRect.origin.y * image.scale), width: (textRect.width * image.scale), height: (textRect.height * image.scale))
    textLayer.alignmentMode = .center
    textLayer.string = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: bestFont,
                                                                     NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                                                     NSAttributedString.Key.foregroundColor: UIColor.white])

    completion(.success(textLayer))
  }
}
