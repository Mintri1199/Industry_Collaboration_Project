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
  private let imageName = ["welcome", "todo"]
  private let headerText = [Localized.string("tutorial_title_1"), Localized.string("tutorial_title_2")]
  private let subheaderText = [Localized.string("tutorial_message_1"),
                               Localized.string("tutorial_message_2")]
  
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
    delegate = self
    register(WelcomeCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
  }
}

extension WelcomeCollectionView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let cell = cell as? WelcomeCollectionViewCell else {
      return
    }
    
    if let demoView = cell.containerView as? DemoView {
      DispatchQueue.main.async {
        demoView.resetAnimation()
      }
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        demoView.resumeAnimation()
      }
    } else if let showView = cell.containerView as? ShowCaseView {
      DispatchQueue.main.async {
        showView.resetAnimation()
      }
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        showView.resumeAnimation()
      }
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
    
    let colors: [UIColor] = [.red, .green, .yellow, .blue]
    
    if indexPath.row == 0 || indexPath.row == 1 {
      let welcomeView = FirstTwoCellView(frame: cell.bounds)
      welcomeView.setupUI(headerText[indexPath.row], subheaderText[indexPath.row])
      welcomeView.setupPhotoLayer(UIImage(named: imageName[indexPath.row])!)
      cell.containerView = welcomeView
    } else if indexPath.row == 2 {
      let demoView = DemoView(frame: cell.bounds)
      cell.containerView = demoView
    } else {
      let showCaseView = ShowCaseView(frame: cell.bounds)
      cell.containerView = showCaseView
    }
    cell.backgroundColor = colors[indexPath.row]
    return cell
  }
}
