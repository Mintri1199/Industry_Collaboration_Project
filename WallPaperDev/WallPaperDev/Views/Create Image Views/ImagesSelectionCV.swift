//
//  ImagesSelectionCV.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ImagesSelectionCV: UICollectionView {
    let headerID = "headerView"
    let cellID = "cell"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: ImageSelectionLayout())
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .yellow
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImagesSelectionCV: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ImagesSelectionCV: UICollectionViewDelegate {
}
