// Created by Jackson Ho on 3/17/20.
// Copyright (c) 2020 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
  func searchPhoto(query: String, completion: @escaping (Result<UnsplashObject, Error>) -> Void)
  func getPhotoData(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}
