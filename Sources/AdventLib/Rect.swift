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
}

extension Rect: CustomStringConvertible {
    public var description: String {
        var result: String = ""
        for y in 0..<height {
            for x in 0..<width {
                let thisIndex = (y * width) + x
                result += "\(storage[thisIndex]) "
            }
            result += "\n"
        }

        return result
    }
}
