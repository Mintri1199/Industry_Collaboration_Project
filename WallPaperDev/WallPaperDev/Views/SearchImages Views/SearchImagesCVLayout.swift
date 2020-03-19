//
//  SearchImagesCVLayout.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

final class SearchImagesCVLayout: UICollectionViewFlowLayout {
  override func prepare() {
    super.prepare()
    guard let cv = collectionView else {
      return
    }
    scrollDirection = .vertical
    let availableWidth = cv.bounds.size.width - 2
    let cellWidth = (availableWidth / 3)
    itemSize = CGSize(width: cellWidth, height: cellWidth)
    sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
    sectionInsetReference = .fromSafeArea
    minimumLineSpacing = 1
    minimumInteritemSpacing = 1
  }
}
