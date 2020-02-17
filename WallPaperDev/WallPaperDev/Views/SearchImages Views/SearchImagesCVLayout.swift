//
//  SearchImagesCVLayout.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class SearchImagesCVLayout: UICollectionViewFlowLayout {
  override func prepare() {
    super.prepare()
    guard let cv = collectionView else {
      return            
    }
    scrollDirection = .vertical
    let availableWidth = cv.bounds.inset(by: cv.layoutMargins).size.width
    let cellWidth = Int(availableWidth / 2.3)
//        itemSize = CGSize(width: cellWidth, height: Int(cv.bounds.height) - 10)
    itemSize = CGSize(width: cellWidth, height: Int(cv.bounds.height / 2))
    sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 25)
    sectionInsetReference = .fromSafeArea
    minimumLineSpacing = 15
  }
}
