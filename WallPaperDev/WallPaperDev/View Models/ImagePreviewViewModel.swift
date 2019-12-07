//
//  ImagePreviewViewModel.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/26/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import CropViewController

enum ImageProcessError: String, Error {
    case unableToProcessImage
    case noImage
    case noText
    case unableToCreateTextLayer
}

class ImagePreviewViewModel {
    
    var originalImage: UIImage?
    var croppedImage: UIImage?
    var selectedGoals: [Goal] = []
    var currentCropRect: CGRect?
    var textLayerRect: CGRect?
    var textLayerRotation: CGFloat?
    var labelText: String?
    var rotate: Int?
    
    func configureCropVC() -> CropViewController? {
        // Build an instance of CropViewController for the VC to present
        guard let image = originalImage else {
            return nil
        }
        let cropVC = CropViewController(croppingStyle: .default, image: image)
        if #available(iOS 13, *) {
            cropVC.modalPresentationStyle = .fullScreen
        }
        
        if let rect = currentCropRect {
            cropVC.imageCropFrame = rect
        }
        if let angle = rotate {
            cropVC.angle = angle
        }
        
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
        guard let image = originalImage else {
            return
        }
        // Find the correct CGRect to crop the image to the Screen ratio
        // Calculate the Width and Height ratios
        let screenWidthRatio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
        let screenHeightRatio = UIScreen.main.bounds.height / UIScreen.main.bounds.width
        
        var cropHeight: CGFloat = image.size.height
        var cropWidth: CGFloat = image.size.width
        // Configure the cropping size to the screen ratio
        if image.size.width * screenHeightRatio > image.size.height {
            cropWidth = image.size.height * screenWidthRatio
        } else if image.size.height * screenWidthRatio > image.size.width {
            cropHeight = image.size.width * screenHeightRatio
        }
        // Set the cropping rect
        let cropRect = CGRect(origin: .zero, size: CGSize(width: cropWidth, height: cropHeight))
        // assign it to the current rect so we can use it later
        currentCropRect = cropRect
        // Create the cropped image
        guard let cropImage = image.cgImage?.cropping(to: cropRect) else {
            return
        }
        let initialCropImage = UIImage(cgImage: cropImage)
        croppedImage = initialCropImage
        
        // Step 2: Then generate a text layer with the correct size text
        // Map the goal array to a String
        let goalsText: String = selectedGoals.compactMap { $0.name }.joined(separator: "\n")
        labelText = goalsText
        // Configure the attributes and font for the string
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let bestFont = UIFont.bestFittingFont(for: goalsText,
                                              in: CGRect(origin: cropRect.origin, size: CGSize(width: cropRect.size.width / 2, height: cropRect.size.height / 6)),
                                              fontDescriptor: UIFontDescriptor(name: "Helvetica Bold", size: 20))
        
        let textAttr: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.font: bestFont,
                                                        NSAttributedString.Key.foregroundColor: UIColor.white,
                                                        NSAttributedString.Key.paragraphStyle: paragraphStyle ]
        // Get the size to fit the text
        let textSize = goalsText.size(withAttributes: textAttr)
        // Configure the CGRect with the text size and position it at the bottom of the screen
        let drawTextRect = CGRect(origin: CGPoint(x: (initialCropImage.size.width - textSize.width) / 2, y: initialCropImage.size.height - (textSize.height * 1.5 )),
                                  size: textSize)
        textLayerRect = drawTextRect
        // Draw the image with the text on it
        UIGraphicsBeginImageContextWithOptions(initialCropImage.size, false, UIScreen.main.scale)
        initialCropImage.draw(in: cropRect)
        goalsText.draw(in: drawTextRect, withAttributes: textAttr)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let newImage = newImage {
            completion(newImage)
        }
    }
    
    func updateImage(completion: @escaping (Result<UIImage, ImageProcessError>) -> Void) {
        guard let image = croppedImage, let cropRect = currentCropRect else {
            completion(.failure(.noImage))
            return
        }
        
        generateTextLayer { (result) in
            switch result {
            case .success(let textLayer):
                #if DEBUG
                print("create textlayer")
                #endif
                
                UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
                image.draw(in: cropRect)
                let context = UIGraphicsGetCurrentContext()!
                textLayer.draw(in: context)
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                if let newImage = newImage {
                    completion(.success(newImage))
                } else {
                    completion(.failure(.unableToProcessImage))
                }
                
            case .failure(let error):
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
        let text = selectedGoals.compactMap { $0.name }.joined(separator: "\n")
        labelText = text
        let bestFont = UIFont.bestFittingFont(for: text, in: textRect, fontDescriptor: UIFontDescriptor(name: "Helvetica Bold", size: 20))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let textLayer = CATextLayer()
        textLayer.string = NSAttributedString(string: text, attributes: [ NSAttributedString.Key.font: bestFont,
                                                                          NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                                                          NSAttributedString.Key.foregroundColor: UIColor.white])
        if let rotation = textLayerRotation {
            textLayer.transform = CATransform3DMakeRotation(rotation, 0, 0, 1)
        }
        completion(.success(textLayer))
    }
}
