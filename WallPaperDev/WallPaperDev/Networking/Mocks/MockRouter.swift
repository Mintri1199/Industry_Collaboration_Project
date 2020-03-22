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
}
