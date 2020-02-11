//
//  WelcomeCollectionView.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 10/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

final class WelcomeCollectionView: UICollectionView {
  private let cellId = "WelcomeCell"
  private let cellStyle: [WelcomeStyle]

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    cellStyle = [.first, .second, .demo, .showcase]

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
    delegate = self
    register(WelcomeCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
  }
}

extension WelcomeCollectionView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {}

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    guard let cell = cell as? WelcomeCollectionViewCell, let cellView = cell.containerView as? CustomView else {
      return
    }
    DispatchQueue.main.async {
      cellView.animatePhone(for: self.cellStyle[indexPath.row])
    }
  }
}

extension WelcomeCollectionView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? WelcomeCollectionViewCell else {
      return UICollectionViewCell()
    }
    let bannerView = CustomView(frame: cell.bounds)
    bannerView.setupUI(style: cellStyle[indexPath.row])
    cell.containerView = bannerView
    return cell
  }
}
