//
//  Photos.swift
//  WallPaperDev
//
//  Created by Jamar Gibbs on 11/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

struct UnsplashObject: Codable {
  enum CodingKeys: String, CodingKey {
    case total
    case totalPages = "total_pages"
    case results
  }

  let total, totalPages: Int
  let results: [PhotosUrls]
}

struct PhotosUrls: Codable {
  let urls: Urls
}

struct Urls: Codable {
  let raw, full, regular, small: String
  let thumb: String
}
