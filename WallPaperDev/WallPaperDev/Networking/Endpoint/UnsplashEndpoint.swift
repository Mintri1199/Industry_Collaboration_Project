//
//  UnsplashEndpoint.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 2/16/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import Foundation

public enum UnsplashAPI {
  case search(id: String, keyword: String)
  case getPhotoData(urlString: String)
}

extension UnsplashAPI: EndPointType {
  var environmentBaseURL: String {
    switch NetworkManager.environment {
    case .production: return "https://api.unsplash.com/search"
    case .qa: return "https://api.unsplash.com/search"
    case .staging: return "https://api.unsplash.com/search"
    }
  }

  var baseURL: URL {
    var url: String
    switch self {
    case .search:
      url = environmentBaseURL

    case let .getPhotoData(urlString):
      url = urlString
    }

    guard let validUrl = URL(string: url) else {
      fatalError("Invalid url: \(url)")
    }
    return validUrl
  }

  var path: String {
    switch self {
    case .search:
      return "/photos"
    case .getPhotoData:
      return ""
    }
  }

  var httpMethod: HTTPMethod {
    .get
  }

  var task: HTTPTask {
    switch self {
    case let .search(id, keyword):
      return .requestParameter(bodyParameters: nil, urlParameters: ["client_id": id, "query": keyword, "per_page": 50])

    case .getPhotoData:
      return .request
    }
  }

  var headers: HTTPHeaders? {
    nil
  }
}
