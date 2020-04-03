//
//  MockNetworkManager.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 3/21/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import Foundation

// MARK: - Mock Network Manager
struct MockNetworkManager {

  enum NetworkResponse: String, Error {
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad Request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
  }

  static let environment: NetworkEnvironment = .qa
  static let shared = MockNetworkManager()
  private let unsplashEndpoint = MockRouter<UnsplashAPI>()

  func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String, NetworkResponse> {
    switch response.statusCode {
    case 100...199: return Result.success("Information")
    case 200...299: return Result.success("Success")
    case 300...399: return Result.success("Redirect")
    case 400...499: return Result.failure(.authenticationError)
    case 500...599: return Result.failure(.badRequest)
    default: return Result.failure(.failed)
    }
  }
}
