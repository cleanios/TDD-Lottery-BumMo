//
//  LottoStoreTestCase.swift
//  TDD Lottery BumMoTests
//
//  Created by BumMo Koo on 25/03/2019.
//  Copyright © 2019 BumMo Koo. All rights reserved.
//

import XCTest
@testable import TDD_Lottery_BumMo

class LotteryStoreTestCase: XCTestCase {
    private let store = LotteryStore()

    // MARK: - Setup
    override func setUp() {
        
    }

    override func tearDown() {
        
    }

    // MARK: - Purchase
    func testPurchaseCount() {
        var money = 10000
        var lottories = store.purcahse(with: money)
        XCTAssertEqual(lottories.count, 10)
        
        money = 5000
        lottories = store.purcahse(with: money)
        XCTAssertEqual(lottories.count, 5)
        
        money = 2500
        lottories = store.purcahse(with: money)
        XCTAssertEqual(lottories.count, 2)
        
        money = 100000
        lottories = store.purcahse(with: money)
        XCTAssertEqual(lottories.count, 100)
        
        money = 1905
        lottories = store.purcahse(with: money)
        XCTAssertEqual(lottories.count, 1)
    }
}
