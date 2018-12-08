import XCTest
@testable import AdventLib

final class AdventLibTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AdventLib().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
