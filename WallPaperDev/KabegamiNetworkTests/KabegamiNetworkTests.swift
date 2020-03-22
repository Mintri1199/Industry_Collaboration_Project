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
    let parameters: [String: Any] = ["q": "query", "sort": "desc"]
    XCTAssertNil(request.value(forHTTPHeaderField: "Content_Type"))
    
    do {
      try URLParameterEncoder.encode(urlRequest: &request, with: parameters)
      XCTAssertNotNil(request.url, "The should still exist")
      XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/x-www-form-urlencoded; charset=utf-8")
      XCTAssertEqual(request.url?.absoluteString, "www.google.com?q=query&sort=desc")
    } catch {
      XCTFail(error.localizedDescription)
    }
    XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/x-www-form-urlencoded; charset=utf-8")
  }
  
  func testJSONParameterEncoder() {
    
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
