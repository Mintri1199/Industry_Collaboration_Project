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
    
    let viewModel = SelectionViewModel()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        
        self.register(ImageSelectionCell.self, forCellWithReuseIdentifier: cellID)
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImagesSelectionCV: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ImageSelectionCell else {
            return UICollectionViewCell()
        }
        
        if let image = viewModel.imageArray[indexPath.row] {
            cell.image = image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ImagesSelectionCV: UICollectionViewDelegate {
}
