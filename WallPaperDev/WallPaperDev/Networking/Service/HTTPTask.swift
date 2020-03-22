//
//  HTTPTask.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 2/16/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
  case request
  
  case requestParameter(bodyParameters: Parameters?, urlParameters: Parameters?)
  
  case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
  
  // case download, upload ... etc
}

extension HTTPTask: Equatable {
  public static func == (lhs: HTTPTask, rhs: HTTPTask) -> Bool {
    
    func isEqual(lhs: [String: Any], rhs: [String: Any]) -> Bool {
      return (lhs as NSDictionary).isEqual(to: rhs)
    }
    
    func compare(lhs: [String: Any]?, rhs: [String: Any]?) -> Bool {
      if let lhs = lhs, let rhs = rhs {
        
        return isEqual(lhs: lhs, rhs: rhs)
        
      } else if lhs == nil && rhs == nil {
        
        return true
        
      } else {
        
        return false
      }
    }
    
    switch (lhs, rhs) {
    case (.request, .request):
      return true
      
    case (let .requestParameter(bodyParameters: bodyParams1, urlParameters: urlParams1),
          let .requestParameter(bodyParameters: bodyParams2, urlParameters: urlParams2)):
      
      return compare(lhs: bodyParams1, rhs: bodyParams2) && compare(lhs: urlParams1, rhs: urlParams2)
      
    case (let .requestParametersAndHeaders(bodyParameters: bodyParams1, urlParameters: urlParams1, additionHeaders: headers1),
          let .requestParametersAndHeaders(bodyParameters: bodyParams2, urlParameters: urlParams2, additionHeaders: headers2)):
      
      return compare(lhs: bodyParams1, rhs: bodyParams2) && compare(lhs: urlParams1, rhs: urlParams2) && compare(lhs: headers1, rhs: headers2)
      
    default:
      return false
    }
  }
}
