//
//  ImagesSelectionCV.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ImagesSelectionCV: UICollectionView {
  let cellID = "cell"

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .white
    showsHorizontalScrollIndicator = false
    allowsMultipleSelection = false
    register(ImageSelectionCell.self, forCellWithReuseIdentifier: cellID)
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
