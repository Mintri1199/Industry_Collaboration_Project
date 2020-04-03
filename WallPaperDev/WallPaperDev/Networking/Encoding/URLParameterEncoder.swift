//
//  URLParameterEncoder.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 2/16/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

public struct URLParameterEncoder {
  static let illegalTypeArray: [Any] = [UIViewController.self, ViewModelProtocol.self]

  static func isIllegal<T>(_ value: T) -> Bool {
    if value as? ViewModelProtocol != nil {
      return true
    } else {
      return false
    }
  }
}

extension URLParameterEncoder: ParameterEncoder {

  public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
    guard let url = urlRequest.url else { throw NetworkError.missingURL }

    if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
      urlComponents.queryItems = [URLQueryItem]()

      for (key, value) in parameters {
        if isIllegal(value) {
          throw NetworkError.encodingFailed
        }
        let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
        urlComponents.queryItems?.append(queryItem)
      }
      urlRequest.url = urlComponents.url
    }

    if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
      urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
    }
  }
}
