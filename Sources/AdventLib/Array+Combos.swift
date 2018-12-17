//
//  Array+Combos.swift
//  AdventLib
//
//  Created by David Paschich on 12/8/18.
//

import Foundation

extension Array {
    public func combinations(choose: Int) -> [[Element]] {
        if isEmpty { return [] }
        if choose == 0 { return [] }

        if choose == 1 {
            return self.map { [$0] }
        }

        var tail = self
        let head = tail.removeFirst()

        let withHead = tail.combinations(choose: choose - 1).map { [head] + $0 }
        let withoutHead = tail.combinations(choose: choose)
        return withHead + withoutHead
    }
}
