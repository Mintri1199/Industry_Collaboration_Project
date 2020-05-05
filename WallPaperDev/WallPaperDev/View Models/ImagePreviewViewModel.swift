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
  
  private enum ScaleText {
    case resize
    case resizeToScreen
    case resizeFromScreen
    case noChanges
  }
  
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
  var croppedImage: UIImage
  var selectedGoals: [Goal]
  var textLayerRect = CGRect(origin: .zero, size: .zero)
  var textLayerRotation: CGFloat?
  var labelText: String
  
  init(image: UIImage, goals: [Goal]) {
    self.originalImage = image
    self.selectedGoals = goals
    self.labelText = goals.compactMap { $0.name }.joined(separator: "\n")
    self.croppedImage = UIImage()
    self.croppedImage = createInitialCroppedImage()
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
    cropVC.rotateButtonsHidden = true // TODO: Fix rotate image later
    cropVC.aspectRatioPickerButtonHidden = true
    cropVC.toolbarPosition = .bottom
    return cropVC
  }
  
  private func createInitialCroppedImage() -> UIImage {
    currentCropRect = defaultCropRect()
    let cropImage = originalImage.cgImage?.cropping(to: currentCropRect)
    return UIImage(cgImage: cropImage!)
  }
  
  func initialGenerate(completion: @escaping (UIImage) -> Void) {
    // This function will generate a wallpaper initially when the user preview the picture
    
    if textLayerRect.origin == .zero && textLayerRect.size == .zero {
      textLayerRect = defaultTextLayerFrame(for: croppedImage)
    }
    
    let textAttr = generateTextAttributes(font: nil)
    
    UIGraphicsBeginImageContextWithOptions(croppedImage.size, false, UIScreen.main.scale)
    croppedImage.draw(in: CGRect(origin: .zero, size: currentCropRect.size))
    labelText.draw(in: textLayerRect, withAttributes: textAttr)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    if let generatedImage = newImage {
      completion(generatedImage)
    } else {
      completion(croppedImage)
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
  
  func updateCroppedImage(new image: UIImage, newCropRect: CGRect, angle: Int, completion: @escaping (Result<UIImage, ImageProcessError>) -> Void) {
    
    // The new crop rect is smaller than the screen of the device
    let resizeToScreen: Bool = newCropRect.size.height < UIScreen.main.bounds.size.height && newCropRect.size.width < UIScreen.main.bounds.width
    
    // Keep the new cropped image if the size is greater than the screen of the device. Otherwise resize it
    let usingImage: UIImage = resizeToScreen ? resizeImageToScreen(image: image) : image
    
    var textScaleFactor: (CGFloat, CGFloat)
    
    // Get the scaling factor for the textRect
    if resizeToScreen {
      // Check whether this is the first time creating a stetch image
      if croppedImage.size != UIScreen.main.bounds.size {
        textScaleFactor = textLayerScaleFactor(option: .resizeToScreen, cropSize: newCropRect.size)
      } else {
        textScaleFactor = textLayerScaleFactor(option: .noChanges, cropSize: newCropRect.size)
      }
    } else if croppedImage.size == UIScreen.main.bounds.size {
      textScaleFactor = textLayerScaleFactor(option: .resizeFromScreen, cropSize: newCropRect.size)
    } else {
      textScaleFactor = textLayerScaleFactor(option: .resize, cropSize: newCropRect.size)
    }
    
    // Apply scaling factor to the textLayerRect
    if textScaleFactor != (0, 0) {
      let transform = CGAffineTransform(scaleX: textScaleFactor.0, y: textScaleFactor.1)
      textLayerRect = textLayerRect.applying(transform)
    }
    
    rotate = angle
    currentCropRect = newCropRect
    croppedImage = usingImage
    
    UIGraphicsBeginImageContextWithOptions(usingImage.size, false, UIScreen.main.scale)
    image.draw(in: CGRect(origin: .zero, size: usingImage.size))
    labelText.draw(in: textLayerRect, withAttributes: generateTextAttributes(font: nil))
    let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    if let newImage = drawnImage {
      completion(.success(newImage))
    } else {
      completion(.failure(.unableToProcessImage))
    }
  }
  
  private func textLayerScaleFactor( option: ScaleText, cropSize: CGSize) -> (CGFloat, CGFloat) {
    switch option {
    case .resize:
      return (cropSize.width / currentCropRect.size.width, cropSize.width / currentCropRect.size.width)
    case .resizeToScreen:
      return (UIScreen.main.bounds.size.height / currentCropRect.size.height, UIScreen.main.bounds.size.width / currentCropRect.size.width)
    case .resizeFromScreen:
      return (cropSize.width / UIScreen.main.bounds.size.width, cropSize.width / UIScreen.main.bounds.size.width)
    case .noChanges:
      return (0, 0)
    }
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
  
  private func resizeImageToScreen(image: UIImage) -> UIImage {
    let widthRatio = UIScreen.main.bounds.size.width / image.size.width
    let heightRatio = UIScreen.main.bounds.size.height / image.size.height
    let newSize = CGSize(width: image.size.width * widthRatio, height: image.size.height * heightRatio)
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
  }
}

struct EditLabelObject {
  let image: UIImage
  let frame: CGRect
  let text: String
  let rotation: CGFloat
}
