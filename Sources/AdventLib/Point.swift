//
//  Point.swift
//  AdventLib
//
//  Created by David Paschich on 12/9/18.
//

import Foundation

// swiftlint:disable identifier_name
public struct Point {
    public var x: Int
    public var y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

extension Point: Hashable {}

extension Point: Comparable {
    public static func < (lhs: Point, rhs: Point) -> Bool {
        if lhs.y == rhs.y {
            return lhs.x < rhs.x
        }
        return lhs.y < rhs.y
    }

    public static func + (lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

extension Point {
    public func adjacents() -> [Point] {
        return [
            Point(x: x + 1, y: y),
            Point(x: x - 1, y: y),
            Point(x: x, y: y + 1),
            Point(x: x, y: y - 1)
        ]
    }

    public func distance(from other: Point) -> Int {
        return abs(x - other.x) + abs(y - other.y)
    }
}
