//
//  DevProfileLayout.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 5/12/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

final class DevProfileLayout: UICollectionViewFlowLayout {
  override func prepare() {
    super.prepare()
    guard let cv = collectionView else {
      return
    }
    scrollDirection = .vertical
    let availableWidth = cv.bounds.size.width - 2
    let availableHeight = cv.bounds.size.height - 2
    let cellWidth = availableWidth / 2
    let cellHeight = availableHeight / 2
    itemSize = CGSize(width: cellWidth, height: cellHeight)
    sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
    sectionInsetReference = .fromSafeArea
    minimumLineSpacing = 1
    minimumInteritemSpacing = 1
  }
}
