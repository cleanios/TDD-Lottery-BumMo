//
//  ViewController.swift
//  TDD Lottery BumMo
//
//  Created by BumMo Koo on 25/03/2019.
//  Copyright © 2019 BumMo Koo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var cashTextField: UITextField!
    @IBOutlet weak var resultTextView: UITextView!
    
    private lazy var store = LotteryStore()
    private lazy var machine = LotteryMachine()
    
    private var purchasedLotteries: [Lottery]?
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action
    @IBAction private func tapped(buy button: UIButton) {
        guard let text = cashTextField.text,
            let cash = Int(text) else {
                return
        }
        let lotteries = store.purcahse(with: cash)
        purchasedLotteries = lotteries
        
        var lotteryText = getInitialText()
        lotteryText = appendLotteryDescription(to: lotteryText)
        updateResult(lotteryText)
    }
    
    @IBAction private func tapped(draw button: UIButton) {
        machine.drawWinningLottery()
        
        var text = getInitialText()
        text = appendLotteryDescription(to: text)
        text = appendDrawResult(to: text)
        updateResult(text)
    }
    
    private func updateResult(_ text: String) {
        resultTextView.text = text
    }
    
    private func getInitialText() -> String {
        guard let lotteries = purchasedLotteries else {
            return "No purchased lotteries."
        }
        return "Purchased \(lotteries.count) lotteries.\n"
    }
    
    private func appendLotteryDescription(to inputText: String) -> String {
        guard let lotteries = purchasedLotteries else {
            return inputText
        }
        
        var text = inputText
        for lottery in lotteries {
            let description = lottery.numbers
            text += "\(description)\n"
        }
        return text
    }
    
    private func appendDrawResult(to inputText: String) -> String {
        guard let lotteries = purchasedLotteries,
            let winningLottery = machine.winning,
            let bonusNumber = machine.bonusNumber else {
                return inputText
        }
        
        var text = inputText + "\nWinning lottery is \(winningLottery.numbers).\nBonus number is \(bonusNumber).\n"
        
        for (index, lottery) in lotteries.enumerated() {
            let result = lottery.checkMatching(with: winningLottery)
            text += "Lottery \(index + 1) matches \(result.count)."
            if let placement = machine.checkPlacement(for: lottery) {
                let prize = machine.checkPrize(for: placement)
                text += " \(placement) place! Won \(prize)!\n"
            } else {
                text += " Got nothing.\n"
            }
        }
        return text
    }
}

