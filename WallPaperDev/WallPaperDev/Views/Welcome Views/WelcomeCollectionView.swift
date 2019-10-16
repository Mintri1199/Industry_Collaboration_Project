//
//  WelcomeCollectionView.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class WelcomeCollectionView: UICollectionView {
    private let cellId = "WelcomeCell"
    private let headerText = ["Welcome to Kamigami"]
    private let subheaderText = ["We help you keep organize and keep track of your goals"]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configCollectionView() {
        translatesAutoresizingMaskIntoConstraints = false 
        showsHorizontalScrollIndicator = true
        bounces = false
        isPagingEnabled = true
        isScrollEnabled = false
        dataSource = self
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
}

extension WelcomeCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let colors: [UIColor] = [.red, .green, .yellow, .blue]
        let welcomeView = WelcomeCellViews(frame: cell.bounds)
        welcomeView.setupUI(headerText[0], subheaderText[0])
        welcomeView.setupPhotoLayer(UIImage(named: "welcome")!)
        cell.backgroundColor = colors[indexPath.row]
        cell.addSubview(welcomeView)
        return cell
    }
}
