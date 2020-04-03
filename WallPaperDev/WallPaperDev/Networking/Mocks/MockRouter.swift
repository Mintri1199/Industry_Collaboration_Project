//
//  MockRouter.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 3/21/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import Foundation

class MockRouter<EndPoint: EndPointType>: NetworkRouter {
  
  func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
    return
  }
  
  func cancel() {
    return
  }
  
  fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
    var request: URLRequest
    if route.path.isEmpty {
      request = URLRequest(url: route.baseURL, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
    } else {
      request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
    }
    request.httpMethod = route.httpMethod.rawValue
    
    do {
      switch route.task {
      case .request:
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
      case let .requestParameter(bodyParameters, urlParameters):
        
        try self.configureParameters(bodyParameters: bodyParameters,
                                     urlParameters: urlParameters,
                                     request: &request)
        
      case let .requestParametersAndHeaders(bodyParameters, urlParameters, additionHeaders):
        self.addAdditionalHeaders(additionHeaders, request: &request)
        try self.configureParameters(bodyParameters: bodyParameters,
                                     urlParameters: urlParameters,
                                     request: &request)
      }
      return request
    } catch {
      throw error
    }
  }
  
  func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
    
    do {
      if let bodyParameters = bodyParameters {
        try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
      }
      if let urlParameters = urlParameters {
        try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
      }
    } catch {
      throw error
    }
  }
  
  func addAdditionalHeaders( _ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
    guard let headers = additionalHeaders else {
      return
    }
    for (key, value) in headers {
      request.setValue(value, forHTTPHeaderField: key)
    }
  }
}
