//
//  ImagesSelectionCV.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ImagesSelectionCV: UICollectionView {
    private let cellID = "cell"
    private let viewModel = SelectionViewModel()
    
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

// MARK: - Datasource
extension ImagesSelectionCV: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ImageSelectionCell else {
            return UICollectionViewCell()
        }
        indexPath.row == viewModel.imageArray.count ? cell.setupShowMoreViews() : cell.getImage(viewModel.imageArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageArray.count + 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

// MARK: - Delegate
extension ImagesSelectionCV: UICollectionViewDelegate {
}
