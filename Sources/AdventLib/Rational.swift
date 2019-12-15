//
//  Rational.swift
//  AdventLib
//
//  Created by David Paschich on 12/10/19.
//

import Foundation

public struct Rational {
    public var numerator: Int
    public var denominator: Int

    public init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
        normalize()
    }

    public mutating func normalize() {
        if numerator == 0 {
            denominator = (denominator < 0) ? -1 : 1
            return
        }
        if denominator == 0 {
            numerator = (numerator < 0) ? -1 : 1
            return
        }
        let divisor = gcd(a: abs(numerator), b: abs(denominator))
        numerator /= divisor
        denominator /= divisor
    }

    func gcd(a: Int, b: Int) -> Int {
        if a == b {
            return a
        } else if a > b {
            return gcd(a: a - b, b: b)
        } else { // b < a
            return gcd(a: a, b: b - a)
        }
    }

    public func asDouble() -> Double {
        return Double(numerator) / Double(denominator)
    }
}

extension Rational: Hashable, Equatable {}
