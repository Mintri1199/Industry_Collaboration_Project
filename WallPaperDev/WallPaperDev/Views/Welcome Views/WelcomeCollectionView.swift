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
  private let image: [UIImage]
  private let cellStyle: [WelcomeStyle]

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    image = [ApplicationDependency.manager.currentTheme.imageAssets.tutorialWelcomeBanner,
             ApplicationDependency.manager.currentTheme.imageAssets.tutorialTodoBanner]
    cellStyle = [.first, .second]

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
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let cell = cell as? WelcomeCollectionViewCell else {
      return
    }

//    if let demoView = cell.containerView as? DemoView {
//      DispatchQueue.main.async {
//        demoView.resetAnimation()
//      }
//      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//        demoView.resumeAnimation()
//      }
//    } else if let showView = cell.containerView as? ShowCaseView {
//      DispatchQueue.main.async {
//        showView.resetAnimation()
//      }
//      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//        showView.resumeAnimation()
//      }
//    }
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

    if indexPath.row == 0 || indexPath.row == 1 {
      let bannerView = CustomView(frame: cell.bounds)
      bannerView.setupUI(style: cellStyle[indexPath.row])
//      welcomeView.setupUI(headerText[indexPath.row], subheaderText[indexPath.row])
//      welcomeView.setupPhotoLayer(image[indexPath.row])
      cell.containerView = bannerView
    } else if indexPath.row == 2 {
      let demoView = DemoView(frame: cell.bounds)
      cell.containerView = demoView
    } else {
      let showCaseView = ShowCaseView(frame: cell.bounds)
      cell.containerView = showCaseView
    }
    return cell
  }
}
