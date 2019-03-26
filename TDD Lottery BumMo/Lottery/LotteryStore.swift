//
//  LottoStore.swift
//  TDD Lottery BumMo
//
//  Created by BumMo Koo on 25/03/2019.
//  Copyright © 2019 BumMo Koo. All rights reserved.
//

import Foundation

class LotteryStore {
    private let price = 1000
    
    func purcahse(with money: Int) -> [Lottery] {
        let count = money / price
        let lotteries = (1...count).map { _ in Lottery() }
        return lotteries
    }
}
