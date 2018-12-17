//
//  Point.swift
//  AdventLib
//
//  Created by David Paschich on 12/9/18.
//

import Foundation

public struct Point {
    public var x: Int
    public var y: Int
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
