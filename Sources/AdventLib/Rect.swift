//
//  Rect.swift
//  AdventLib
//
//  Created by David Paschich on 12/9/18.
//

import Foundation

public struct Rect<Element> {
    private var storage: [Element]
    public let width: Int
    public let height: Int

    public init(width: Int, height: Int, defaultValue: Element) {
        storage = [Element](repeating: defaultValue, count: width * height)
        self.width = width
        self.height = height
    }

    private func index(x: Int, y: Int) -> Int? {  // swiftlint:disable:this identifier_name
        guard x < width, y < height else { return nil }
        return (y * width) + x
    }

    public subscript(point: Point) -> Element {
        get { return self[point.x, point.y] }
        set { self[point.x, point.y] = newValue }
    }

    public subscript(x: Int, y: Int) -> Element { // swiftlint:disable:this identifier_name
        get {
            guard let index = index(x: x, y: y) else { fatalError("out of range") }
            return storage[index]
        }
        set {
            guard let index = index(x: x, y: y) else { fatalError("out of range") }
            storage[index] = newValue
        }
    }

    public func reduce<Result>(_ initialResult: Result,
                               _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result {
        var finalResult = initialResult
        for element in storage {
            finalResult = try nextPartialResult(finalResult, element)
        }
        return finalResult
    }

    public func isValidIndex(_ point: Point) -> Bool {
        return (0..<width).contains(point.x) && (0..<height).contains(point.y)
    }
}

extension Rect: CustomStringConvertible {
    public var description: String {
        var result: String = ""
        for y in 0..<height { // swiftlint:disable:this identifier_name
            for x in 0..<width {  // swiftlint:disable:this identifier_name
                let thisIndex = (y * width) + x
                result += "\(storage[thisIndex]) "
            }
            result += "\n"
        }

        return result
    }
}

extension Rect: Sequence {

    public func makeIterator() -> AnyIterator<Element> {
        return AnyIterator(storage.makeIterator())
    }
}

extension Rect: Collection {
    public func index(after i: Point) -> Point { // swiftlint:disable:this identifier_name
        if i.x == width - 1 {
            if i.y == height - 1 {
                return endIndex
            }
            return Point(x: 0, y: i.y + 1)
        } else {
            return Point(x: i.x + 1, y: i.y)
        }
    }

    public var startIndex: Point {
        return Point(x: 0, y: 0)
    }

    public var endIndex: Point {
        // the index of the element _after_ the last element
        // we use the index after the end of the last row so that
        // ranges can "encode" the height and width of the specified
        // slice.
        return Point(x: width, y: height - 1)
    }

    public subscript(bounds: Range<Point>) -> SubRect<Element> {
        let topLeft = bounds.lowerBound
        let bottomRight = bounds.upperBound + Point(x: -1, y: 0)
        return SubRect(rect: self, topLeft: topLeft, bottomRight: bottomRight)
    }
}

public struct SubRect<Element>: Collection {
    public func index(after i: Point) -> Point { // swiftlint:disable:this identifier_name
        if i.x == bottomRight.x {
            return Point(x: topLeft.x, y: i.y + 1)
        } else {
            return Point(x: i.x + 1, y: i.y)
        }
    }

    public typealias SubSequence = SubRect

    public subscript(position: Point) -> Element {
        return rect[position]
    }

    public var startIndex: Point { return topLeft }
    public var endIndex: Point { return Point(x: topLeft.x, y: bottomRight.y + 1)}

    var rect: Rect<Element>
    var topLeft: Point
    var bottomRight: Point

    public typealias Index = Point
}

extension Rect where Element == Bool {
    public init(pattern: String, separator: Character = "\n") {
        let lines = pattern.split(separator: separator)
        let width = lines[0].count
        let height = lines.count
        self.init(width: width, height: height, defaultValue: false)
        for (row, line) in lines.enumerated() {
            for (column, char) in line.enumerated() {
                switch char {
                case ".": self[column, row] = false
                default: self[column, row] = true
                }
            }
        }
    }

    public func printed() -> String {
        var result = ""
        for row in 0..<height {
            for column in 0..<width {
                result.append(self[column, row] ? "#" : ".")
            }
            result.append("\n")
        }

        return result
    }
}

extension Rect {
    public func flippedHorizontally() -> Rect<Element> {
        var result = self

        for row in 0..<height {
            // go halfway across the columns
            let halfway = width / 2
            for column in 0..<halfway {
                let rightColumn = width - column - 1
                result[column, row] = self[rightColumn, row]
                result[rightColumn, row] = self[column, row]
            }
        }
        return result
    }

    public func flippedVertically() -> Rect<Element> {
        var result = self

        let halfway = height / 2
        for row in 0..<halfway {
            let lowerRow = height - row - 1
            for column in 0..<width {
                result[column, lowerRow] = self[column, row]
                result[column, row] = self[column, lowerRow]
            }
        }

        return result
    }

    public func rotated() -> Rect<Element> {
        var result = self

        for column in 0..<width {
            for row in 0..<height {
                result[width - row - 1, column] = self[column, width - row - 1]
            }
        }

        return result
    }
}

extension Rect: Equatable where Element: Equatable {}

extension Rect: Hashable where Element: Hashable {}
