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
}
