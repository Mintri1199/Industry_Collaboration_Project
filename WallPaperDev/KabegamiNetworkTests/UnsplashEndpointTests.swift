//
//  UnsplashEndpointTests.swift
//  KabegamiNetworkTests
//
//  Created by Jackson Ho on 3/22/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import XCTest

@testable import Kabegami

class UnsplashEndpointTests: XCTestCase {
  
  private let api = UnsplashAPI.self
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testSearchVariables() {
    let searchEndpoint = api.search(id: "", keyword: "")
    let baseURLString = "https://api.unsplash.com/search"
    let controlHTTPTask = HTTPTask.requestParameter(bodyParameters: nil, urlParameters: ["client_id": "", "query": "", "per_page": 50])
    XCTAssertTrue(searchEndpoint.environmentBaseURL == baseURLString)
    XCTAssertEqual(searchEndpoint.baseURL, URL(string: baseURLString)!)
    XCTAssertEqual(searchEndpoint.path, "/photos", "Path should be /photos for search endpoint")
    XCTAssertTrue(searchEndpoint.httpMethod == .get, "Method should be GET for search")
    XCTAssertEqual(searchEndpoint.task, controlHTTPTask)
    XCTAssertNil(searchEndpoint.headers)
  }
  
  func testPhotoDataVariable() {
    let urlString = "https://images.unsplash.com/photo-1546373727-f803b7298d14?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3599&q=80"
    let dataEndpoint = api.getPhotoData(urlString: urlString)
    XCTAssertEqual(dataEndpoint.baseURL, URL(string: urlString)!)
    XCTAssertEqual(dataEndpoint.path, "", "Path should be nothing for data endpoint")
    XCTAssertTrue(dataEndpoint.httpMethod == .get, "Method should be GET for search")
    XCTAssertEqual(dataEndpoint.task, HTTPTask.request)
    XCTAssertNil(dataEndpoint.headers)
  }
}
