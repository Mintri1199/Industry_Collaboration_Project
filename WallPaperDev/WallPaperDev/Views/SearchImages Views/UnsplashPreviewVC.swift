//
//  UnsplashPreviewVC.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 3/20/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

class UnsplashPreviewVC: UIViewController {
  private let imageView = UIImageView()
  
  private let photoView = UIImageView()
  
  override func loadView() {
    photoView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view = photoView
  }
  
  init(photo: UIImage) {
    super.init(nibName: nil, bundle: nil)
    
    photoView.image = photo
    preferredContentSize = photo.size
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
