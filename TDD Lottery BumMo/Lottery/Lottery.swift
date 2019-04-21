//
//  Lottery.swift
//  TDD Lottery BumMo
//
//  Created by BumMo Koo on 25/03/2019.
//  Copyright © 2019 BumMo Koo. All rights reserved.
//

import Foundation

struct Lottery {
    let numbers: [Int]
    
    // MARK: - Initialization
    init() {
        let array = (1...45).map { $0 }.shuffled()
        numbers = Array(array.prefix(6).sorted())
    }
    
    init?(numbers: [Int]) {
        guard numbers.count == 6 else {
            return nil
        }
        do {
            try numbers.forEach {
                guard $0 >= 0 && $0 <= 45 else {
                    throw NSError()
                }
            }
        } catch {
            return nil
        }
        self.numbers = numbers
    }
    
    // MARK: - Match
    func checkMatching(with another: Lottery) -> [Int] {
        let matchingSet = Set(numbers).intersection(another.numbers)
        let matching = Array(matchingSet).sorted()
        return matching
    }
}
