//
//  RectTests.swift
//  AdventLibTests
//
//  Created by David Paschich on 12/9/18.
//

import XCTest
import AdventLib

class RectTests: XCTestCase {

    func testSlice() {
        let rect = Rect(width: 10, height: 10, defaultValue: true)

        let subRect = rect[Point(x: 1, y: 1)...Point(x: 2, y: 5)]

        let start = subRect.startIndex
        XCTAssertEqual(start, Point(x: 1, y: 1))
        let next = subRect.index(after: start)
        XCTAssertEqual(next, Point(x: 2, y: 1))
        let nextNext = subRect.index(after: next)
        XCTAssertEqual(nextNext, Point(x: 1, y: 2))
    }
}
