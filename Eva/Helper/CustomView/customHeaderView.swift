//
//  customHeaderView.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit

class customHeaderView: UIView, UIScrollViewDelegate {
    
    @IBOutlet weak var amountHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var messageLabelView: UIView?
    
    var contentView: customHeaderView!
    @IBOutlet weak var headerLabel: UILabel?
    
    @IBOutlet weak var searchTextLabel: UILabel?
    @IBOutlet weak var displayMessageLabel: UILabel?
    @IBOutlet weak var amtLabel: UILabel?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var lastpage = 0
    
    let chart = VBPieChart();
    
    init?(frame: CGRect, message: String) {
        super.init(frame: frame)
        
        guard let view = Bundle.main.loadNibNamed("customHeaderView", owner: self, options: nil)?.first as? customHeaderView else {
            return nil
        }
        contentView = view
        messageLabelView = view.messageLabelView
        amountView = view.amountView
        
        self.updateCellValues(view: view)
        
        headerLabel?.attributedText = EvaUtils.formatPoint8Text(text: headerLabel?.text ?? "")
        // Without the following line, my view was always 600 x 600
        contentView.frame = frame
        //self.autoresizingMask = UIViewAutoresizing.flexibleWidth;
        self.addSubview(contentView)
        self.setProperties()
        //self.setThemeColor()
    }
    
    func setProperties() {
        contentView.searchTextLabel?.isUserInteractionEnabled = true
        contentView.amtLabel?.isUserInteractionEnabled = true
    }
    
    func setThemeColor(view: customHeaderView) {
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        view.searchTextLabel?.textColor = UIColor.white
        view.displayMessageLabel?.textColor = UIColor.colorFromHex(hexString: "#9B9B9B")
        view.amtLabel?.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // For displayType - messageWithAmountTransactions
    func updateCellValues(view: customHeaderView) {
        if let transactionsHeader = EvaDataController.sharedInstance.transactionResponse?.transactionsHeader {
            let message = transactionsHeader.user_query_text.trimTrailingWhitespace()
            let attributedString = EvaUtils.stringFromHtml(string: transactionsHeader.display_message.emojiUnescapedString)
            let attrString = NSMutableAttributedString()
            attrString.append(attributedString ?? NSAttributedString())
            attrString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.colorFromHex(hexString: "#9B9B9B") , range: attributedString?.string.fullrange() ?? NSMakeRange(0, 0))
            view.searchTextLabel?.attributedText = EvaUtils.stringFromHtmlWithQuotation(string: message.emojiUnescapedString)
            view.displayMessageLabel?.attributedText = attrString
            view.searchTextLabel?.textAlignment = .right
            view.amtLabel?.text = "$" + transactionsHeader.display_value
            self.setThemeColor(view: view)
        }
    }
    
    func updateConstraintForView(_ constant: CGFloat) {
        
        if let height = contentView.amountHeightConstraint {
            height.constant = (constant / 2.0)
        }
        
        if let height = contentView.topViewHeightConstraint {
            height.constant = (constant / 2.0)
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {        
    }
}


extension customHeaderView {
    
    func addPieChart() -> UIView {
        
        chart.frame = CGRect(x: 0, y: 0, width: 300, height: 300);
        chart.holeRadiusPrecent = 0.3;
        chart.center = CGPoint.init(x: self.frame.size.width/2, y: chart.frame.size.height/2)
        let chartColorValues = [UIColor(hexString:"dd191daa"), UIColor(hexString:"d81b60aa"), UIColor(hexString:"8e24aaaa"), UIColor(hexString:"3f51b5aa"), UIColor(hexString:"5677fcaa")]
        
        var chartValues = [Dictionary<String, Any>]()
        let graphData = EvaDataController.sharedInstance.transactionResponse?.graphData ?? []
        var index = 0
        for _data in graphData {
            chartValues.append(["name":_data.category , "value": _data.value, "color":chartColorValues[index] ?? UIColor.red])
            index += 1
        }
        
        
        chart.setChartValues(chartValues as [AnyObject], animation:true);
        return chart
    }
}

extension customHeaderView {
    
    func viewController() -> TransactionsResultViewController? {
        var responder: UIResponder? = self
        while !(responder is UIViewController) {
            responder = responder?.next
            if nil == responder {
                break
            }
        }
        return (responder as? TransactionsResultViewController)
    }
}


class EvaLeftInsetLabel: UILabel {
    var topInset = CGFloat(0)
    var bottomInset = CGFloat(0)
    var leftInset = CGFloat(16)
    var rightInset = CGFloat(0)
    
    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override public var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
}


class EvaRightInsetLabel: UILabel {
    var topInset = CGFloat(0)
    var bottomInset = CGFloat(0)
    var leftInset = CGFloat(0)
    var rightInset = CGFloat(16)
    
    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override public var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
}
