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
        
        updateResult()
    }
    
    @IBAction private func tapped(draw button: UIButton) {
        machine.drawWinningLottery()
        
        updateResult()
    }
    
    private func updateResult() {
        var text = ""
        
        guard let lotteries = purchasedLotteries else {
            resultTextView.text = "No purchased lotteries."
            return
        }
        
        text += "Purchased \(lotteries.count) lotteries.\n"
        
        for lottery in lotteries {
            let description = lottery.numbers
            text += "\(description)\n"
        }
        
        resultTextView.text = text
        
        // MARK: Draw Result
        guard let winningLottery = machine.winning,
            let bonusNumber = machine.bonusNumber else {
                return
        }
        
        text += "\nWinning lottery is \(winningLottery.numbers).\nBonus number is \(bonusNumber).\n"
        
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
        
        resultTextView.text = text
    }
}

