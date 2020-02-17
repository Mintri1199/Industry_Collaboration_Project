//
//  NetworkManager.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 2/16/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
  case qa, staging, production
}

struct NetworkManager {

  enum NetworkReponse: String, Error {
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad Request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
  }

  static let environment: NetworkEnvironment = .production

  private func newHandleNetworkResponse(_ response: HTTPURLResponse) -> Result<String, NetworkReponse> {
    switch response.statusCode {
    case 200...299: return Result.success("Success")
    case 401...500: return Result.failure(.authenticationError)
    case 501...599: return Result.failure(.badRequest)
    case 600: return Result.failure(.outdated)
    default: return Result.failure(.failed)
    }
  }

//
//    func newGetKeywords(completion: @escaping (Result<[Keyword], NetworkReponse>) -> Void) {
//
//        keywordRouter.request(.keywords) { (data, response, error) in
//
//            if error != nil {
//                print("Check your network connection")
//                return
//            }
//
//            if let response = response as? HTTPURLResponse {
//                let result = self.newHandleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data  else { completion(.failure(.noData)); return }
//
//                    do {
//                        let apiResponse = try JSONDecoder().decode([Keyword].self, from: responseData)
//                        completion(.success(apiResponse))
//                    } catch {
//                        completion(.failure(.unableToDecode))
//                    }
//                case .failure(let networkFailureError):
//                    completion(.failure(networkFailureError))
//                }
//            }
//        }
//    }
//
//    func refactoredGetAllSets(completion: @escaping (Result<ListObject, NetworkReponse>) -> Void) {
//        scryfallRouter.request(.sets) { (data, response, error) in
//            if error != nil {
//                print("Check your network connection")
//                return
//            }
//
//            if let response = response as? HTTPURLResponse {
//                let result = self.newHandleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data  else { completion(.failure(.noData)); return }
//
//                    do {
//                        let apiResponse = try JSONDecoder().decode(ListObject.self, from: responseData)
//                        print(apiResponse)
  ////                        completion(.success(apiResponse))
//                    } catch {
//                        completion(.failure(.unableToDecode))
//                    }
//                case .failure(let networkFailureError):
//                    completion(.failure(networkFailureError))
//                }
//            }
//        }
//    }

//    func refactoredAllCardsFromSet(searchURI: String, completion: @escaping (Result<CardListObject, NetworkReponse>) -> Void) {
//        guard let url = URL(string: searchURI) else { print("Invalid search URI"); return }
//        let session = URLSession.shared
//        let request = URLRequest(url: url)
//
//        let task = session.dataTask(with: request) { (data, response, error) in
//            if error != nil {
//                print("Check your network connection")
//                return
//            }
//            if let response = response as? HTTPURLResponse {
//                let result = self.newHandleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data  else { completion(.failure(.noData)); return }
//
//                    do {
//                        let apiResponse = try JSONDecoder().decode(CardListObject.self, from: responseData)
//                        completion(.success(apiResponse))
//                    } catch {
//                        completion(.failure(.unableToDecode))
//                    }
//                case .failure(let networkFailureError):
//                    completion(.failure(networkFailureError))
//                }
//            }
//        }
//        task.resume()
//    }
//
//    func refactoredGetPicture(searchURI: String, completion: @escaping(Result<UIImage, NetworkReponse>) -> Void) {
//        guard let url = URL(string: searchURI) else { print("Invalid picture URI"); return }
//        let session = URLSession.shared
//        let request = URLRequest(url: url)
//        let task = session.dataTask(with: request) { (data, response, error) in
//            if error != nil {
//                print("Check your network connection")
//                return
//            }
//            if let response = response as? HTTPURLResponse {
//                let result = self.newHandleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else { completion(.failure(.noData)); return }
//                    let apiImage = UIImage(data: responseData)
//                    if let image = apiImage{
//                        completion(.success(image))
//                    } else {
//                        completion(.failure(.unableToDecode))
//                    }
//
//                case .failure(let networkFailureError):
//                    completion(.failure(networkFailureError))
//                }
//            }
//        }
//        task.resume()
//
//    }
//
//
//    func getTokenFromSet(tokenName: String, setCode: String, completion: @escaping (Result<CardListObject, NetworkReponse>) -> Void) {
//        scryfallRouter.request(.allRelatedCards(name: tokenName, set: setCode)) { (data, response, error) in
//            if error != nil {
//                print("Please check your network connection")
//                return
//            }
//
//            if let response = response as? HTTPURLResponse {
//                let result = self.newHandleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else { completion(.failure(.noData)); return }
//                    do {
//                        let apiResponse = try JSONDecoder().decode(CardListObject.self, from: responseData)
//
//                        if apiResponse.data.isEmpty {
//                            completion(.failure(.noData))
//                        } else {
//                            completion(.success(apiResponse))
//                        }
//                    } catch {
//                        completion(.failure(.unableToDecode))
//                    }
//                case .failure(let networkFailureError):
//                    completion(.failure(networkFailureError))
//                }
//            }
//        }
//    }
}
