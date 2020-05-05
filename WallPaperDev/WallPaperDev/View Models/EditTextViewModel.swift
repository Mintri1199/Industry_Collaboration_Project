//
//  EditTextViewModel.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 12/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

protocol SaveChange: AnyObject {
  func applyChanges(_ textFrame: CGRect, _ layerRotation: CGFloat)
}

class EditTextViewModel: ViewModelProtocol {
  private(set) var labelText: String
  private(set) var labelFrame: CGRect
  private(set) var labelRotation: CGFloat
  private(set) var image: UIImage
  weak var delegate: SaveChange?
  var newRotation: CGFloat?
  
  init(_ textObject: EditLabelObject) {
    labelFrame = textObject.frame
    labelText = textObject.text
    labelRotation = textObject.rotation
    image = textObject.image
    
    if image.size != UIScreen.main.bounds.size {
      makeTextSmaller()
    }
  }
  
  func updateText(newFrame: CGRect, newRotation: CGFloat) {
    if labelFrame != newFrame || labelRotation != newRotation {
      delegate?.applyChanges(newFrame, newRotation)
    }
  }
  
  private func makeTextSmaller() {
    let widthRatio = UIScreen.main.bounds.size.width / image.size.width
    let heightRatio = UIScreen.main.bounds.size.height / image.size.height
    
    // Flag: print statement
    print((widthRatio, heightRatio))
    
    let transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    labelFrame = labelFrame.applying(transform)
  }
}
