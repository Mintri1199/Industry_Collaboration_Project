//
//  NetworkManager.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 2/16/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

enum NetworkEnvironment {
  case qa, staging, production
}

struct NetworkManager {

  enum NetworkResponse: String, Error {
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad Request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
  }

  static let environment: NetworkEnvironment = .production
  static let shared = NetworkManager()
  private let unsplashEndpoint = Router<UnsplashAPI>()

  private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String, NetworkResponse> {
    switch response.statusCode {
    case 200...299: return Result.success("Success")
    case 401...500: return Result.failure(.authenticationError)
    case 501...599: return Result.failure(.badRequest)
    case 600: return Result.failure(.outdated)
    default: return Result.failure(.failed)
    }
  }

  func searchPhoto(query: String, completion: @escaping (Result<NewPhotos, NetworkResponse>) -> Void) {
    unsplashEndpoint.request(.search(id: Keys.clientID, keyword: query)) { data, response, error in
      if let response = response as? HTTPURLResponse {
        switch self.handleNetworkResponse(response) {
        case .success:
          guard let responseData = data else {
            completion(.failure(.noData))
            return
          }

          do {
            let model = try JSONDecoder().decode(NewPhotos.self, from: responseData)
            completion(.success(model))
          } catch {
            completion(.failure(.unableToDecode))
          }

        case let .failure(error):
          completion(.failure(error))
        }
      }
    }
  }

  func getPhotoData(from urlString: String, completion: @escaping (Result<UIImage, NetworkResponse>) -> Void) {
    guard let url = URL(string: urlString) else {
      completion(.failure(.badRequest))
      return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)

    session.dataTask(with: request) { data, response, error in

      guard let response = response as? HTTPURLResponse else {return}

      print(response.statusCode)

      guard error == nil else {
        completion(.failure(.failed))
        return
      }
      guard let responseData = data else {
        completion(.failure(.noData))
        return
      }
      if let image = UIImage(data: responseData) {
        completion(.success(image))
      } else {
        completion(.failure(.unableToDecode))
      }
    }.resume()
  }
}
