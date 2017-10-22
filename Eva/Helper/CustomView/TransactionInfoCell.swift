//
//  TransactionInfoCell.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit
let TRANSACTION_DETAILS = "Transaction Details"

class TransactionInfoCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var transDetailLabel: UILabel?
    @IBOutlet weak var transcategoryLabel: UILabel?
    @IBOutlet weak var pending_indicatorLabel: UILabel?
    @IBOutlet weak var amtLabel: UILabel?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var transDetailheaderLabel: UILabel?
    @IBOutlet weak var transDetailheaderImgView: UIImageView?
    @IBOutlet weak var topSeparatorImgView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.dateLabel?.isUserInteractionEnabled = true
        self.transDetailLabel?.isUserInteractionEnabled = true
        self.amtLabel?.isUserInteractionEnabled = true
    }
    
    func updateCellValues(indexPath: IndexPath) {
        
        if let orders = EvaDataController.sharedInstance.transactionResponse?.orders, orders.count > indexPath.row {
            topSeparatorImgView?.isHidden = true
            if indexPath.row == 0 {
                topSeparatorImgView?.isHidden = false
            }
            topSeparatorImgView?.backgroundColor = UIColor.colorFromHex(hexString: "#979797")
            
            let orders = orders[indexPath.row]
            
            // Date
            dateLabel?.attributedText = EvaUtils.formatPoint8Text(text: orders.order_date_as_display)
            
            //Name
            transDetailLabel?.attributedText = EvaUtils.formatPoint8Text(text: orders.title)
            
            // Amount
            if orders.display_total == "" {
                amtLabel?.attributedText = EvaUtils.formatAmount(amount: "N/A")
            } else {
                amtLabel?.attributedText = EvaUtils.formatAmount(amount: orders.display_total)
            }
            
            // Category
            transcategoryLabel?.isHidden = true
            // Status
            pending_indicatorLabel?.isHidden = false
            pending_indicatorLabel?.attributedText = EvaUtils.formatPoint8Text(text: orders.paymentType)
            
        }
        self.setThemeColor()
    }
    
    
    func setThemeColor() {
        transDetailheaderLabel?.attributedText = EvaUtils.formatPoint8Text(text: TRANSACTION_DETAILS)
        self.backgroundColor = UIColor.clear
        dateLabel?.textColor = UIColor.colorFromHex(hexString: "#9B9B9B")
        transDetailLabel?.textColor = UIColor.white
        amtLabel?.textColor = UIColor.white
        transcategoryLabel?.textColor = UIColor.colorFromHex(hexString: "#9B9B9B")
        transDetailheaderLabel?.textColor = UIColor.white
        transDetailheaderImgView?.backgroundColor = UIColor.white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
