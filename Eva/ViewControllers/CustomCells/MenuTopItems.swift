//
//  MenuTopItems.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit

class MenuTopItems: UIView {
    
    @IBOutlet weak var lblTotal: UILabel?
    @IBOutlet weak var lblOutstanding: UILabel?
    
    @IBOutlet weak var lblTotalCashAmt: UILabel?
    @IBOutlet weak var lblOutstandingAmt: UILabel?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var nickNameLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.reloadUI()
        self.getTotalBalanceFromDB()
    }
    
    public func reloadUI() {
        
        nickNameLabel?.attributedText = EvaUtils.formatPoint8Text(text: EvaDataController.sharedInstance.currentBalances?.balance.merchant_name ?? "")
        
        let cashValue = EvaDataController.sharedInstance.currentBalances?.balance.sales_today
        // let cashAmount = cashValue.stringWithSepator
        
        let creditValue = EvaDataController.sharedInstance.currentBalances?.balance.sales_thismonth
        // let creditAmount = creditValue.stringWithSepator
        
        // CASH Label, CREDIT label
        let cashObj = Amount.init(type: amountType.cash, _cash: cashValue ?? "")
        let creditObj = Amount.init(type: amountType.credit, _credit: creditValue ?? "")
        if cashValue == "" {
            self.lblTotalCashAmt?.attributedText = EvaUtils.formatPoint8Text(text: "$0.0")
        } else {
            self.lblTotalCashAmt?.attributedText = cashObj.cashValue
        }
        if creditValue == "" {
            self.lblOutstandingAmt?.attributedText = EvaUtils.formatPoint8Text(text: "$0.0")
        } else {
            self.lblOutstandingAmt?.attributedText = creditObj.creditValue
        }
        
        
        self.lblTotal?.attributedText = EvaUtils.formatPoint8Text(text: "Sales Today")
        self.lblOutstanding?.attributedText = EvaUtils.formatPoint8Text(text: "Sales this month")
        
        //        self.lblTotalCashAmt?.isUserInteractionEnabled = true
        //        appDelegate?.addFontGesture(label: self.lblTotalCashAmt ?? UILabel())
        //        self.lblOutstandingAm t?.isUserInteractionEnabled = true
        //        appDelegate?.addFontGesture(label: self.lblOutstandingAmt ?? UILabel())
    }
    
    func getTotalBalanceFromDB() {
        
        DispatchQueue.global(qos: .background).async {
            var output = ("", [String: Any]())
            print("total Balance")
            output = EvaUtils.fetchFromDB(queryType: .totalBalance, vc: nil)
            EvaDataController.sharedInstance.currentBalances = Balances.Map(output.1)
            DispatchQueue.main.async(execute: {
                self.reloadUI()
            })
        }
    }
    
}

// Number digits formating by ","
struct Number {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "," // or possibly "." / ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}
extension BinaryInteger {
    var stringWithSepator: String {
        return Number.withSeparator.string(from: NSNumber(value: hashValue)) ?? ""
    }
}
