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

        let elementsInSubrect = subRect.reduce(0) { (count, _) -> Int in
            return count + 1
        }

        XCTAssertEqual(elementsInSubrect, 10)
    }

    func testBoolInit() {
        let pattern = """
        .#.
        ..#
        #X#
        """

        let rect: Rect<Bool> = Rect(pattern: pattern)
        // indices below are column, row
        XCTAssertEqual(rect[0,0], false)
        XCTAssertEqual(rect[0,1], false)
        XCTAssertEqual(rect[0,2], true)
        XCTAssertEqual(rect[1,0], true)
        XCTAssertEqual(rect[1,1], false)
        XCTAssertEqual(rect[1,2], true)
        XCTAssertEqual(rect[2,0], false)
        XCTAssertEqual(rect[2,1], true)
        XCTAssertEqual(rect[2,2], true)
    }

    func testPrint() {
        let pattern = """
        .#.
        ..#
        ###

        """

        let rect: Rect<Bool> = Rect(pattern: pattern)

        let printed = rect.printed()
        XCTAssertEqual(pattern, printed)
    }

    func testHorizontalFlip() {

        let pattern = """
        .#.
        ..#
        ###

        """

        let rect: Rect<Bool> = Rect(pattern: pattern).flippedHorizontally()

        let printed = rect.printed()
        XCTAssertEqual("""
        .#.
        #..
        ###

        """, printed)
    }

    func testVerticalFlip() {

        let pattern = """
        .#.
        ..#
        ###

        """

        let rect: Rect<Bool> = Rect(pattern: pattern).flippedVertically()

        let printed = rect.printed()
        XCTAssertEqual("""
        ###
        ..#
        .#.

        """, printed)
    }

    func testRotate() {

        let pattern = """
        .#.
        ..#
        ###

        """

        let rect: Rect<Bool> = Rect(pattern: pattern).rotated()

        let printed = rect.printed()
        XCTAssertEqual("""
        ..#
        #.#
        .##

        """, printed)
    }
}
