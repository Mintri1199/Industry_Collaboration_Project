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
}

extension UnsplashAPI: EndPointType {

    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "https://api.unsplash.com/search"
        case .qa: return "https://api.unsplash.com/search"
        case .staging:  return "https://api.unsplash.com/search"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("baseURL could not be configure")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .search:
            return "/photos"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case let .search(id, keyword):
            return .requestParameter(bodyParameters: nil, urlParameters: ["client_id": id, "query" : keyword])
        }
    }
    
    var headers: HTTPHeaders? {
        nil
    }
}