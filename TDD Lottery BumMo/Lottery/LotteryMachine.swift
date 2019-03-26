//
//  LotteryMachine.swift
//  TDD Lottery BumMo
//
//  Created by BumMo Koo on 25/03/2019.
//  Copyright © 2019 BumMo Koo. All rights reserved.
//

import Foundation

class LotteryMachine {
    private(set) var winning: Lottery?
    private(set) var bonusNumber: Int?
    
    // MARK: - Draw
    @discardableResult
    func drawWinningLottery() -> (lottery: Lottery, bonusNumber: Int)  {
        let winning = Lottery()
        let bonusNumber = drawBonusNumber()
        self.winning = winning
        self.bonusNumber = bonusNumber
        return (winning, bonusNumber)
    }
    
    func drawBonusNumber() -> Int {
        return Int.random(in: (1...45))
    }
    
    // MARK: - Placement
    func checkPlacement(for lottery: Lottery) -> Int? {
        guard let winning = winning, let bonus = bonusNumber else {
            return nil
        }
        let result = lottery.checkMatching(with: winning)
        switch result.count {
        case 6: return 1
        case 5:
            if lottery.numbers.contains(bonus) && !result.contains(bonus) {
                return 2
            } else {
                return 3
            }
        case 4: return 4
        case 3: return 5
        default: return nil
        }
    }
    
    // MARK: - Prize
    func checkPrize(for placement: Int) -> Int {
        switch placement {
        case 1: return 20_0000_0000
        case 2: return 3000_0000
        case 3: return 150_0000
        case 4: return 5_0000
        case 5: return 5000
        default: return 0
        }
    }
}
