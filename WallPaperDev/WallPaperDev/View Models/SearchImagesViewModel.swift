//
//  SearchImagesViewModel.swift
//  WallPaperDev
//
//  Created by Jamar Gibbs on 11/6/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

// TODO: Rework this
class SearchImagesViewModel {
  var imageURLS: [PhotosUrls] = []

  var selectedImage: UIImage?
  let networkManager = NetworkManager.shared

  func loadSearchURLS(for keyword: String, cv: UICollectionView) {
    networkManager.searchPhoto(query: keyword, completion: { result in
      switch result {
      case let .success(object):
        self.imageURLS = object.results
        print(self.imageURLS.count)
        DispatchQueue.main.async {
          cv.reloadData()
        }

      case let .failure(error):
        #if DEBUG
          print(error)
        #endif
      }
    })
  }
}
