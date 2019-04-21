//
//  LotteryTestCase.swift
//  TDD Lottery BumMoTests
//
//  Created by BumMo Koo on 25/03/2019.
//  Copyright © 2019 BumMo Koo. All rights reserved.
//

import XCTest
@testable import TDD_Lottery_BumMo

class LotteryTestCase: XCTestCase {
    private let numberOfTestLotteries = 100
    private var lotteries = [Lottery]()
    
    // MARK: - Setup
    override func setUp() {
        if lotteries.count <= 0 {
            lotteries = (1...numberOfTestLotteries).map { _ in Lottery() }
        }
    }
    
    override func tearDown() {
        
    }
    
    // MARK: - Purchase
    func testPurchasableLotteryCount() {
        
    }
    
    func testPurchaseLottery() {
        
    }
    
    // MARK: - Lottery
    func testNewLotteryNumberCount() {
        lotteries.forEach {
            XCTAssertEqual($0.numbers.count, 6)
        }
    }
    
    func testNewLotteryNumberRange() {
        lotteries.forEach { lottery in
            lottery.numbers.forEach { number in
                XCTAssertTrue(number >= 1)
                XCTAssertTrue(number <= 45)
                XCTAssertTrue((number as Any) is Int)
            }
        }
    }
    
    func testNewLotteryNumberUnique() {
        lotteries.forEach { lottery in
            let set = Set(lottery.numbers)
            XCTAssertEqual(set.count, lottery.numbers.count)
        }
    }
    
    func testNewFailableLottery() {
        var lottery = Lottery(numbers: [1, 2, 3])
        XCTAssertNil(lottery)
        
        lottery = Lottery(numbers: [1, 2, 3, 4, 5, 100])
        XCTAssertNil(lottery)
    }
    
    func testLotteryUnique() {
        let lottery1 = Lottery()
        let lottery2 = Lottery()
        
        let result = lottery1.checkMatching(with: lottery2)
        XCTAssertTrue(result.count < lottery1.numbers.count)
    }
    
    func testLotteryGenerationPerformance() {
        measure {
            lotteries = (1...numberOfTestLotteries).map { _ in Lottery() }
        }
    }
    
    func testMatchingLotteryNumber() {
        guard let baseLottery = Lottery(numbers: [1, 2, 3, 4, 5, 6]) else {
            XCTFail()
            return
        }
        var checkLottery = Lottery(numbers: [1, 2, 3, 4, 5, 6])
        var result = checkLottery?.checkMatching(with: baseLottery)
        XCTAssertEqual(result?.count, 6)
        
        checkLottery = Lottery(numbers: [1, 2, 3, 4, 5, 45])
        result = checkLottery?.checkMatching(with: baseLottery)
        XCTAssertEqual(result?.count, 5)
        
        checkLottery = Lottery(numbers: [1, 2, 3, 4, 44, 45])
        result = checkLottery?.checkMatching(with: baseLottery)
        XCTAssertEqual(result?.count, 4)
        
        checkLottery = Lottery(numbers: [1, 2, 3, 43, 44, 45])
        result = checkLottery?.checkMatching(with: baseLottery)
        XCTAssertEqual(result?.count, 3)
        
        checkLottery = Lottery(numbers: [1, 2, 42, 43, 44, 45])
        result = checkLottery?.checkMatching(with: baseLottery)
        XCTAssertEqual(result?.count, 2)
        
        checkLottery = Lottery(numbers: [1, 41, 42, 43, 44, 45])
        result = checkLottery?.checkMatching(with: baseLottery)
        XCTAssertEqual(result?.count, 1)
        
        checkLottery = Lottery(numbers: [40, 41, 42, 43, 44, 45])
        result = checkLottery?.checkMatching(with: baseLottery)
        XCTAssertEqual(result?.count, 0)
    }
    
    func testMathingLotteryNumberPerformance1() {
        guard let winningLottery = Lottery(numbers: [1, 2, 3, 4, 5, 6]) else {
            XCTFail()
            return
        }
        measure {
            lotteries.forEach { lottery in
                let _ = lottery.checkMatching(with: winningLottery)
            }
        }
    }
    
    func testMathingLotteryNumberPerformance2() {
        guard let winningLottery = Lottery(numbers: [40, 41, 42, 43, 44, 45]) else {
            XCTFail()
            return
        }
        measure {
            lotteries.forEach { lottery in
                let _ = lottery.checkMatching(with: winningLottery)
            }
        }
    }
    
    func testMathingLotteryNumberPerformance3() {
        let randomLottery = Lottery()
        measure {
            lotteries.forEach { lottery in
                let _ = lottery.checkMatching(with: randomLottery)
            }
        }
    }
}
