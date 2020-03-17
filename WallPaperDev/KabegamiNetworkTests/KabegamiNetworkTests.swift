//
//  KabegamiNetworkTests.swift
//  KabegamiNetworkTests
//
//  Created by Jackson Ho on 2/25/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import XCTest

// TODO: (Jackson) - Implement Network unit test
class KabegamiNetworkTests: XCTestCase {

  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }

//
//  func testRetrieveProductsValidResponse() {
//    // we have a locally stored product list in JSON format to test against.
//    let testBundle = Bundle(forClass: type(of: self))
//    let filepath = testBundle.pathForResource("products", ofType: "txt")
//    let data = Data(contentsOfFile: filepath!)
//    let urlResponse = HTTPURLResponse(url: URL(string: "https://anyurl.doesntmatter.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
//    // setup our mock response with the above data and fake response.
//    MockSession.mockResponse = (data, urlResponse: urlResponse, error: nil)
//    let requestsClass = RequestManager()
//    // All our network calls are in here.
//    requestsClass.Session = MockSession.self
//    // Replace NSURLSession with our own MockSession.
//    // We still need to test as if it's asynchronous. Because well, it is.
//    let expectation = XCTestExpectation(description: "ready")
//    // For this test, no need to pass in anything useful since it doesn't affect our mocked response.
//    // This particular function fetches JSON, converts it to custom objects, and returns them.
//    requestsClass.retrieveProducts("N/A", products: { (products) -> () in
//      XCTAssertTrue(products.count == 7)
//      expectation.fulfill()
//    }) { (error) -> () in
//      XCTAssertFalse(error == Errors.NetworkError, "Its a network error")
//      XCTAssertFalse(error == Errors.ParseError, "Its a parsing error")
//      XCTFail("Error not covered by previous asserts.")
//      expectation.fulfill()
//    }
//    waitForExpectations(timeout: 3.0, handler: nil)
//  }

  func testPerformanceExample() {
    // This is an example of a performance test case.
    measure {
      // Put the code you want to measure the time of here.
    }
  }
}
