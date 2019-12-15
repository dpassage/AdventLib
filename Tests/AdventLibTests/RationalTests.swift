//
//  RationalTests.swift
//  AdventLibTests
//
//  Created by David Paschich on 12/10/19.
//

import XCTest
import AdventLib

class RationalTests: XCTestCase {

    func testNormalizes() {
        let number = Rational(numerator: 2, denominator: 4)
        XCTAssertEqual(number.numerator, 1)
        XCTAssertEqual(number.denominator, 2)
    }

    func testNormalizesSigns() {
        let bothNeg = Rational(numerator: -1, denominator: -2)
        XCTAssertEqual(bothNeg.numerator, 1)
        XCTAssertEqual(bothNeg.denominator, 2)
    }

    func testZeros() {
        let zero = Rational(numerator: 0, denominator: 2438542)
        XCTAssertEqual(zero.numerator, 0)
        XCTAssertEqual(zero.denominator, 1)

        let infinite = Rational(numerator: 235, denominator: 0)
        XCTAssertEqual(infinite.numerator, 1)
        XCTAssertEqual(infinite.denominator, 0)
    }


    func testAsDouble() {
        let oneHalf = Rational(numerator: 2, denominator: 4)
        XCTAssertEqual(oneHalf.asDouble(), 0.5)

        let negInf = Rational(numerator: -4, denominator: 0)
        XCTAssertEqual(negInf.asDouble(), -Double.infinity)

        let posInf = Rational(numerator: 9, denominator: 0)
        XCTAssertEqual(posInf.asDouble(), Double.infinity)

        let nuthin = Rational(numerator: 0, denominator: 0)
        XCTAssertEqual(nuthin.asDouble(), 0)
    }
}
