//
//  LotteryMachineTestCase.swift
//  TDD Lottery BumMoTests
//
//  Created by BumMo Koo on 25/03/2019.
//  Copyright © 2019 BumMo Koo. All rights reserved.
//

import XCTest
@testable import TDD_Lottery_BumMo

class LotteryMachineTestCase: XCTestCase {
    private let numberOfTestBonusNumber = 100
    private lazy var machine = LotteryMachine()
    
    // MARK: - Draw
    func testDrawWinningLottery() {
        machine.drawWinningLottery()
        XCTAssertNotNil(machine.winning)
        XCTAssertNotNil(machine.bonusNumber)
    }
    
    func testBonusNumber() {
        (1...numberOfTestBonusNumber).forEach { _ in
            let number = machine.drawBonusNumber()
            XCTAssertTrue(number >= 1)
            XCTAssertTrue(number <= 45)
            XCTAssertTrue((number as Any) is Int)
        }
    }
    
    // MARK: - Placement
    func testUndrawnLotteryMachine() {
        guard let lottery = Lottery(numbers: [1, 2, 3, 4, 5, 6]) else {
            XCTFail()
            return
        }
        let machine = LotteryMachine()
        let result = machine.checkPlacement(for: lottery)
        XCTAssertNil(result)
    }
    
    func testLotteryPlacementWinner() {
        machine.drawWinningLottery()
        
        guard let winning = machine.winning else {
            XCTFail()
            return
        }
        
        guard let newLottery = Lottery(numbers: winning.numbers) else {
            XCTFail()
            return
        }
        
        let placement = machine.checkPlacement(for: newLottery)
        XCTAssertEqual(placement, 1)
    }
    
    func testLotteryPlacementSecond() {
        machine.drawWinningLottery()
        
        guard let winning = machine.winning,
            let bonus = machine.bonusNumber else {
            XCTFail()
            return
        }
        
        let numbers = Array(winning.numbers.prefix(5)) + [bonus]
        guard let newLottery = Lottery(numbers: numbers) else {
            XCTFail()
            return
        }
        
        let placement = machine.checkPlacement(for: newLottery)
        XCTAssertEqual(placement, 2)
    }
    
    func testLotteryPlacementThird() {
        machine.drawWinningLottery()
        
        guard let winning = machine.winning else {
            XCTFail()
            return
        }
        
        let numbers = Array(winning.numbers.prefix(5)) + [0]
        guard let newLottery = Lottery(numbers: numbers) else {
            XCTFail()
            return
        }
        
        let placement = machine.checkPlacement(for: newLottery)
        XCTAssertEqual(placement, 3)
    }
    
    func testLotteryPlacementFourth() {
        machine.drawWinningLottery()
        
        guard let winning = machine.winning else {
            XCTFail()
            return
        }
        
        let numbers = Array(winning.numbers.prefix(4)) + [0, 0]
        guard let newLottery = Lottery(numbers: numbers) else {
            XCTFail()
            return
        }
        
        let placement = machine.checkPlacement(for: newLottery)
        XCTAssertEqual(placement, 4)
    }
    
    func testLotteryPlacementFifth() {
        machine.drawWinningLottery()
        
        guard let winning = machine.winning else {
            XCTFail()
            return
        }
        
        let numbers = Array(winning.numbers.prefix(3)) + [0, 0, 0]
        guard let newLottery = Lottery(numbers: numbers) else {
            XCTFail()
            return
        }
        
        let placement = machine.checkPlacement(for: newLottery)
        XCTAssertEqual(placement, 5)
    }
    
    func testLotteryPlacementNone() {
        machine.drawWinningLottery()
        
        guard let newLottery = Lottery(numbers: [0, 0, 0, 0, 0, 0]) else {
            XCTFail()
            return
        }
        
        let placement = machine.checkPlacement(for: newLottery)
        XCTAssertNil(placement)
    }
    
    // MARK: - Prize
    func testPrizeAvailable() {
        XCTAssertTrue(machine.checkPrize(for: 1) != 0)
        XCTAssertTrue(machine.checkPrize(for: 2) != 0)
        XCTAssertTrue(machine.checkPrize(for: 3) != 0)
        XCTAssertTrue(machine.checkPrize(for: 4) != 0)
        XCTAssertTrue(machine.checkPrize(for: 5) != 0)
    }
    
    func testPrizeValue() {
        let firstPrize = machine.checkPrize(for: 1)
        let secondPrize = machine.checkPrize(for: 2)
        let thirdPrize = machine.checkPrize(for: 3)
        let fourthPrize = machine.checkPrize(for: 4)
        let fifthPrize = machine.checkPrize(for: 5)
        
        XCTAssertTrue(firstPrize > secondPrize)
        XCTAssertTrue(secondPrize > thirdPrize)
        XCTAssertTrue(thirdPrize > fourthPrize)
        XCTAssertTrue(fourthPrize > fifthPrize)
        XCTAssertTrue(fifthPrize > 0)
    }
}
