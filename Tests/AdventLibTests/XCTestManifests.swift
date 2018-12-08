import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Array_CombosTests.allTests),
    ]
}
#endif
