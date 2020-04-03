//
//  XCTestCase_Extension.swift
//  KabegamiNetworkTests
//
//  Created by Jackson Ho on 3/21/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import Foundation

import XCTest

extension XCTestCase {
  func assert<T, V>(_ result: Result<T, V>?,
                    containsError expectedError: Error,
                    in file: StaticString = #file,
                    line: UInt = #line) {
    switch result {
    case .success?:
      XCTFail("No error thrown", file: file, line: line)
    case .failure(let error)?:
      XCTAssertEqual(
        error.localizedDescription,
        expectedError.localizedDescription,
        file: file, line: line
      )
    case nil:
      XCTFail("Result was nil", file: file, line: line)
    }
  }

  func assert<T, E: Error & Equatable>(
    _ expression: @autoclosure () throws -> T,
    throws error: E,
    in file: StaticString = #file,
    line: UInt = #line
  ) {
    var thrownError: Error?

    XCTAssertThrowsError(try expression(),
                         file: file, line: line) {
      thrownError = $0
    }

    XCTAssertTrue(
      thrownError is E,
      "Unexpected error type: \(type(of: thrownError))",
      file: file, line: line
    )

    XCTAssertEqual(
      thrownError as? E, error,
      file: file, line: line
    )
  }
}
