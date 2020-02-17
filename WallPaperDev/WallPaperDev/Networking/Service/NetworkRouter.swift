//
//  NetworkRouter.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 2/16/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol NetworkRouter: class {
  associatedtype EndPoint: EndPointType
  func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
  func cancel()
}
