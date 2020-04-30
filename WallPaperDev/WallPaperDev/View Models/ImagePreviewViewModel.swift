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
  private var defaultParagraphStyle: NSMutableParagraphStyle {
    let style = NSMutableParagraphStyle()
    style.alignment = .center
    return style
  }
  
  private var defaultTextLayerWidth: CGFloat {
    return currentCropRect.size.width * 0.65
  }
  
  private var defaultTextLayerHeight: CGFloat {
    return currentCropRect.size.height / 6
  }
  
  private var rotate: Int = 0
  private var currentCropRect = CGRect(origin: .zero, size: .zero)
  
  var croppedImage: UIImage?
  var selectedGoals: [Goal]
  var textLayerRect = CGRect(origin: .zero, size: .zero)
  var textLayerRotation: CGFloat?
  var labelText: String
  
  init(image: UIImage, goals: [Goal]) {
    self.originalImage = image
    self.selectedGoals = goals
    self.labelText = goals.compactMap { $0.name }.joined(separator: "\n")
  }
  
  func configureCropVC() -> CropViewController? {
    // Build an instance of CropViewController for the VC to present
    let cropVC = CropViewController(croppingStyle: .default, image: originalImage)
    cropVC.modalPresentationStyle = .fullScreen
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
    
    if currentCropRect.origin == .zero && currentCropRect.size == .zero {
      currentCropRect = defaultCropRect()
    }
    
    // Create the cropped image
    guard let cropImage = originalImage.cgImage?.cropping(to: currentCropRect) else {
      return
    }
    
    // Focus on getting the right crop image first
    let initialCropImage = UIImage(cgImage: cropImage)
    croppedImage = initialCropImage
    
    if textLayerRect.origin == .zero && textLayerRect.size == .zero {
      textLayerRect = defaultTextLayerFrame(for: initialCropImage)
    }
    
    let textAttr = generateTextAttributes(font: nil)
    
    UIGraphicsBeginImageContextWithOptions(initialCropImage.size, false, UIScreen.main.scale)
    initialCropImage.draw(in: CGRect(origin: .zero, size: currentCropRect.size))
    labelText.draw(in: textLayerRect, withAttributes: textAttr)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    if let generatedImage = newImage {
      completion(generatedImage)
    } else {
      completion(initialCropImage)
    }
  }
  
  private func defaultTextLayerFrame(for croppedImage: UIImage) -> CGRect {
    /*
     This method is responsible for generating a default CGRect for the textLayer
     The CGRect be near the bottom
     The CGRect should be in in the center X of the cropped image
     The CGRect height should also be the cropped image height / 6
     The CGRect width should also be the cropped image width * 0.65
     */
    let bestFont = UIFont.bestFittingFont(for: labelText,
                                          in: CGRect(origin: currentCropRect.origin, size: CGSize(width: defaultTextLayerWidth, height: defaultTextLayerHeight)),
                                          fontDescriptor: ApplicationDependency.manager.currentTheme.fontSchema.medium20.fontDescriptor)
    
    let textAttr = [ NSAttributedString.Key.font: bestFont,
                     NSAttributedString.Key.foregroundColor: ApplicationDependency.manager.currentTheme.colors.white,
                     NSAttributedString.Key.paragraphStyle: defaultParagraphStyle ]
    
    let textSize = labelText.size(withAttributes: textAttr)
    
    // Configure the CGRect with the text size and position it near the bottom of the screen
    return CGRect(origin: CGPoint(x: (croppedImage.size.width - textSize.width) / 2, y: croppedImage.size.height - (textSize.height * 1.5 )),
                  size: textSize)
  }
  
  private func defaultCropRect() -> CGRect {
    /*
     This method is responsible for generating a default CGRect for the cropping
     The CGRect should fill in the original image size while keeping the device's aspect ratio
     The CGRect should also be in the center of the image
     */
    
    // constants
    let imageSize = originalImage.size
    let screenWidthRatio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
    let screenHeightRatio = UIScreen.main.bounds.height / UIScreen.main.bounds.width
    
    // initial crop size height and width
    var cropHeight: CGFloat = imageSize.height
    var cropWidth: CGFloat = imageSize.width
    
    // Configure the cropping size to the screen ratio
    if imageSize.width * screenHeightRatio > imageSize.height {
      cropWidth = imageSize.height * screenWidthRatio
    } else if imageSize.height * screenWidthRatio > imageSize.width {
      cropHeight = imageSize.width * screenHeightRatio
    }
    
    // Configure the origin that will adjust the crop size to the center of the image
    let cropOriginX = (imageSize.width / 2) - (cropWidth / 2)
    let cropOriginY = (imageSize.height / 2) - (cropHeight / 2)
    
    return CGRect(origin: CGPoint(x: cropOriginX, y: cropOriginY),
                  size: CGSize(width: cropWidth, height: cropHeight))
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
  
  func updateCroppedImage(new image: UIImage, newCropRect: CGRect, angle: Int, completion: @escaping (Result<UIImage, ImageProcessError>) -> Void) {
    // TODO: Fix the bug where text is not drawing properly for zoomed in image
    
    // Get the scalling factor for the new cropRect
    let heightFactor = newCropRect.size.height / currentCropRect.size.height
    let widthFactor = newCropRect.size.width / currentCropRect.size.width
    
    // Apply scaling factor to the textLayerRect
    let transform = CGAffineTransform(scaleX: widthFactor, y: heightFactor)
    textLayerRect = textLayerRect.applying(transform)
    rotate = angle
    currentCropRect = newCropRect
    croppedImage = image
    
    // Handle any changes on the cropped image
    UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
    image.draw(in: CGRect(origin: .zero, size: image.size))
    labelText.draw(in: textLayerRect, withAttributes: generateTextAttributes(font: nil))
    let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    if let newImage = drawnImage {
      completion(.success(newImage))
    } else {
      completion(.failure(.unableToProcessImage))
    }
  }
  
  private func updateTextRect() {
    // update the height
  }
  
  private func generateTextAttributes(font: UIFont?) -> [NSAttributedString.Key: Any] {
    var bestFont: UIFont
    if let font = font {
      bestFont = font
    } else {
      bestFont = UIFont.bestFittingFont(for: labelText, in: textLayerRect, fontDescriptor: ApplicationDependency.manager.currentTheme.fontSchema.heavy20.fontDescriptor)
    }
    
    return [ NSAttributedString.Key.font: bestFont,
             NSAttributedString.Key.foregroundColor: ApplicationDependency.manager.currentTheme.colors.white,
             NSAttributedString.Key.paragraphStyle: defaultParagraphStyle ]
  }
  
  private func generateTextLayer(completion: @escaping (Result<CATextLayer, ImageProcessError>) -> Void) {
    // TODO: Figure out how to configure this more
    let text = selectedGoals.compactMap { $0.name }.joined(separator: "\n")
    labelText = text
    let bestFont = UIFont.bestFittingFont(for: text, in: textLayerRect, fontDescriptor: UIFontDescriptor(name: "Helvetica Bold", size: 20))
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    
    let textLayer = CATextLayer()
    textLayer.frame = textLayerRect // CGRect(x: (textRect.origin.x * image.scale), y: (textRect.origin.y * image.scale), width: (textRect.width * image.scale), height: (textRect.height * image.scale))
    textLayer.alignmentMode = .center
    textLayer.string = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: bestFont,
                                                                     NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                                                     NSAttributedString.Key.foregroundColor: UIColor.white])
    
    completion(.success(textLayer))
  }
}
