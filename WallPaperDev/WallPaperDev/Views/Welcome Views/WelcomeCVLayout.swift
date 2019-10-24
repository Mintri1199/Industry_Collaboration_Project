//
//  WelcomeCVLayout.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class WelcomeCVLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        guard let cv = collectionView else {
            return
        }
        scrollDirection = .horizontal
        itemSize = cv.bounds.size
        minimumLineSpacing = 0
    }
}
