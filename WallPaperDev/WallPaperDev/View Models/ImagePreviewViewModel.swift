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

class ImagePreviewViewModel {
    
    var unprocessImage: UIImage?
    var selectedGoals: [String] = []
    
    func processImage(_ image: UIImage, _ goalArray: [String]) -> UIImage? {
        // crop the image into the right ratio
        let screenWidthRatio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
        let screenHeightRatio = UIScreen.main.bounds.height / UIScreen.main.bounds.width
        
        var cropHeight: CGFloat = image.size.height
        var cropWidth: CGFloat = image.size.height
        
        if image.size.width * screenHeightRatio > image.size.height {
            cropWidth = image.size.height * screenWidthRatio
        } else if image.size.height * screenWidthRatio > image.size.width {
            cropHeight = image.size.width * screenHeightRatio
        }
        
        let verticalInset = (image.size.height - cropHeight) / 2
        let horizontalInset = (image.size.width - cropWidth) / 2
        
        let cropRect = CGRect(x: horizontalInset, y: verticalInset, width: cropWidth, height: cropHeight)
        guard let cropImage = image.cgImage?.cropping(to: cropRect) else {
            print("Woah something is definitely wrong")
            return nil
        }
        
        return textToImage(drawText: goalArray, inImage: UIImage(cgImage: cropImage))
    }
    
    private func textToImage(drawText textArray: [String], inImage image: UIImage) -> UIImage? {
        let combinedText = textArray.joined(separator: "\n") + "\n\n\n"
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 20)!
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let textAttributes: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.font: textFont,
                                                               NSAttributedString.Key.foregroundColor: textColor,
                                                               NSAttributedString.Key.paragraphStyle: paragraphStyle ]
        
        let textSize = combinedText.size(withAttributes: textAttributes)
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        let rect = CGRect(origin: CGPoint(x: 0, y: image.size.height - textSize.height), size: image.size)
        combinedText.draw(in: rect, withAttributes: textAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
