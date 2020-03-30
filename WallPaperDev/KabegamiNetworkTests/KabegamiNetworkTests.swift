//
//  KabegamiNetworkTests.swift
//  KabegamiNetworkTests
//
//  Created by Jackson Ho on 3/21/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//
import Foundation

import XCTest

@testable import Kabegami

class KabegamiNetworkTests: XCTestCase {
  private var manager = MockNetworkManager.shared
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testURLParameterEncoder() {
    let baseURL = URL(string: "www.google.com")!
    var request = URLRequest(url: baseURL)
    let parameters: Parameters = ["q": "query"]
    var component = URLComponents(string: "www.google.com")
    component?.queryItems = [
      URLQueryItem(name: "q", value: "query")
    ]
    
    XCTAssertNil(request.value(forHTTPHeaderField: "Content_Type"))
    XCTAssertNoThrow(try URLParameterEncoder.encode(urlRequest: &request, with: parameters), "Should be able encode url parameter")
    XCTAssertNotNil(request.url, "The should still exist")
    XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/x-www-form-urlencoded; charset=utf-8")
    XCTAssertEqual(request.url, component?.url)
    
    // Test fail case
    assert(try URLParameterEncoder.encode(urlRequest: &request, with: ["illegaLType": HomeViewModel()]), throws: NetworkError.encodingFailed)
    
    request.url = nil
    assert(try URLParameterEncoder.encode(urlRequest: &request, with: parameters), throws: NetworkError.missingURL)
  }
  
  func testJSONParameterEncoder() {
    let baseURL = URL(string: "www.google.com")!
    var request = URLRequest(url: baseURL)
    let bodyParameters: Parameters = ["token": "example token", "username": "john doe", "phone": 555_555_5555]
    var data: Data?
    
    XCTAssertNoThrow(data = try JSONSerialization.data(withJSONObject: bodyParameters, options: .prettyPrinted))
    
    XCTAssertNil(request.httpBody)
    XCTAssertNil(request.value(forHTTPHeaderField: "Content_Type"))
    
    // Test Success
    XCTAssertNoThrow(try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters),
                     "Fail to encode with parameters:\n \(bodyParameters)")
    XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
    XCTAssertEqual(request.httpBody, data)
    
    // Test Fail
    //    assert(try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters), throws: NetworkError.encodingFailed)
  }
  
  func testHandleNetworkResponse() {
    let url = URL(string: "www.google.com")!
    let responses: [HTTPURLResponse] = [100, 200, 300, 400, 500, 600].compactMap { HTTPURLResponse(url: url, statusCode: $0, httpVersion: "2", headerFields: nil) }
    let successMessages = ["Information", "Success", "Redirect"]
    let failResponses: [MockNetworkManager.NetworkResponse] = [.authenticationError, .badRequest, .failed]
    let handledResponses = responses.compactMap { manager.handleNetworkResponse($0) }
    
    // Test all success response
    for i in 0...2 {
      XCTAssertTrue(handledResponses[i] == .success(successMessages[i]))
    }
    
    // Test all failed response
    for i in 3...5 {
      assert(handledResponses[i], containsError: failResponses[i - 3])
    }
  }
  
  func testUnsplashEndPoint() {
    let searchEndpoint = UnsplashAPI.search(id: Keys.clientID, keyword: "")
    XCTAssertEqual(searchEndpoint.baseURL.absoluteString, "https://api.unsplash.com/search")
  }
}
