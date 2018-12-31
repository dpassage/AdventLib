//
//  Array+Compare.swift
//  AdventLib
//
//  Created by David Paschich on 12/31/18.
//

import Foundation

extension Array: Comparable where Element: Comparable {
    public static func < (lhs: Array<Element>, rhs: Array<Element>) -> Bool {
        for (left, right) in zip(lhs, rhs) {
            if left != right { return left < right }
        }
        return lhs.count < rhs.count
    }
}
