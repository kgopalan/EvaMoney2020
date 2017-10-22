//
//  MessageTypeViewController.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit
import CloverConnector_Hackathon_2017

class MessageTypeViewController: GraphViewController, StartTransactionDelegate {
    
    var currentViewType : String = ""
    let chart = VBPieChart();
    
    @IBOutlet weak var viewMessage: UIView?
    @IBOutlet weak var messageUserInputLabel : UILabel?
    @IBOutlet weak var messageLabel : UILabel?
    @IBOutlet weak var confirmationCheckMarkImageView: UIImageView?

    @IBOutlet weak var viewMessageWithChart: UIView?
    @IBOutlet weak var barMessageUserInputLabel : UILabel?
    @IBOutlet weak var barChartView : UIView?
    @IBOutlet weak var barMessageLabel : UILabel?
    
    @IBOutlet weak var viewMessageWithPieChart: UIView?
    @IBOutlet weak var pieMessageUserInputLabel : UILabel?
    @IBOutlet weak var pieChartView : UIView?
    @IBOutlet weak var pieMessageLabel : UILabel?
    @IBOutlet weak var pieNotesLabel : UILabel?
    @IBOutlet weak var pieChartViewHeightConstraint: NSLayoutConstraint?
    @IBOutlet weak var pieChartNotesTopConstraint: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initViewLoad()
        self.view.backgroundColor = UIColor.colorFromHex(hexString: "#1A1A2D")
        self.checkForPayments()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    func initViewLoad()  {
        if EvaDataController.sharedInstance.showBackArrow == true {
            self.addBackButton()
        }
        
        viewMessage?.isHidden = true
        viewMessageWithChart?.isHidden = true
        viewMessageWithPieChart?.isHidden = true
        // Show selected one alone
        self.displaySelectedType()
    }

    // TODO : Optimize it - once UI is ready
    func displaySelectedType() {
        
        let displayType: DisplayType = EvaDataController.sharedInstance.currentDisplayType ?? .message
        
        switch displayType {
        case .message:
            self.updateMessage()
        case .messageWithChart:
            self.updateBarChartMessage()
        case .messageWithPieChart:
            self.updatePieChartMessage()
        default:
            print("Different displayType")
        }
    }
    
    func updateMessage() {
        viewMessage?.isHidden = false
        self.confirmationCheckMarkImageView?.isHidden = true
        let message = EvaDataController.sharedInstance.transactionResponse?.transactionsHeader?.display_message ?? ""
        let userQuery = EvaDataController.sharedInstance.transactionResponse?.transactionsHeader?.user_query_text.trimTrailingWhitespace() ?? ""
        
        messageLabel?.attributedText = EvaUtils.stringFromHtml(string: message.emojiUnescapedString)
        messageLabel?.textColor = UIColor.colorFromHex(hexString: "#9B9B9B")
        messageUserInputLabel?.attributedText = EvaUtils.formatUserQuery(query: userQuery)
    }
        
    func updateBarChartMessage() {
        viewMessageWithChart?.isHidden = false
        let message = EvaDataController.sharedInstance.transactionResponse?.transactionsHeader?.display_message ?? ""
        let userQuery = EvaDataController.sharedInstance.transactionResponse?.transactionsHeader?.user_query_text.trimTrailingWhitespace() ?? ""
        
        barMessageLabel?.attributedText = EvaUtils.stringFromHtml(string: message.emojiUnescapedString)
        barMessageLabel?.textColor = UIColor.colorFromHex(hexString: "#9B9B9B")
        barMessageUserInputLabel?.attributedText = EvaUtils.formatUserQuery(query: userQuery)
        graphContainerView.frame = CGRect.init(x: 0, y: 0, width: barChartView?.frame.size.width ?? self.view.frame.size.width, height: barChartView?.frame.size.height ?? 200)
        graphContainerView.addSubview(graphView)
        barChartView?.addSubview(graphContainerView)
    }
    
    func updatePieChartMessage() {
        viewMessageWithPieChart?.isHidden = false
        let message = EvaDataController.sharedInstance.transactionResponse?.transactionsHeader?.display_message ?? ""
        let notes = EvaDataController.sharedInstance.transactionResponse?.transactionsHeader?.display_notes ?? ""
        let userQuery = EvaDataController.sharedInstance.transactionResponse?.transactionsHeader?.user_query_text.trimTrailingWhitespace() ?? ""
        
        pieMessageLabel?.attributedText = EvaUtils.stringFromHtml(string: message.emojiUnescapedString)
        pieMessageLabel?.textColor = UIColor.colorFromHex(hexString: "#9B9B9B")
        pieMessageUserInputLabel?.attributedText = EvaUtils.formatUserQuery(query: userQuery)
        pieNotesLabel?.text = notes.emojiUnescapedString
        pieNotesLabel?.textColor = UIColor.colorFromHex(hexString: "#9B9B9B")
        pieNotesLabel?.font = EvaUtils.getFont(of: "Helvetica Neue", of: 15.0)
        pieChartView?.addSubview(addPieChart())
    }
    
    func addPieChart() -> UIView {
        
        let size = (self.view.frame.size.width > 320.0) ? CGFloat(300) : CGFloat(250)
        pieChartViewHeightConstraint?.constant = size
        pieChartNotesTopConstraint?.constant = (self.view.frame.size.width > 320.0) ? CGFloat(33.0) : CGFloat(0)
        let x = (self.view.frame.size.width > 320.0) ? CGFloat(self.view.frame.size.width - size)/2 : CGFloat(45.0)
        chart.frame = CGRect(x: x - 10, y: 0, width: size, height: size);
        chart.holeRadiusPrecent = 0.3;
        // chart.center = CGPoint.init(x: (pieChartView?.frame.size.width ?? 0)/2 , y: (pieChartView?.frame.size.height ?? 0)/2)
        
        let chartColorValues = [UIColor(hexString:"dd191daa"), UIColor(hexString:"d81b60aa"), UIColor(hexString:"8e24aaaa"), UIColor(hexString:"3f51b5aa"), UIColor(hexString:"5677fcaa")]
        
        var chartValues = [Dictionary<String, Any>]()
        let graphData = EvaDataController.sharedInstance.transactionResponse?.graphData ?? []
        var index = 0
        for _data in graphData {
            let value = (round(_data.value*100)) / 100.0;
            chartValues.append(["name":_data.category.emojiUnescapedString , "value": value, "color":chartColorValues[index] ?? UIColor.red])
            index += 1
        }
        
        
        chart.setChartValues(chartValues as [AnyObject], animation:true);
        return chart
    }
    
    // MARK: - Animate Tick Image from center
    func animateTickImage() {
        
        self.confirmationCheckMarkImageView?.isHidden = false
        self.confirmationCheckMarkImageView?.image = UIImage(named: "confirmation_check", in: Bundle(for:self.classForCoder), compatibleWith: nil)
        self.confirmationCheckMarkImageView?.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 1.0,
                       delay: 0.5,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: UIViewAnimationOptions(),
                       animations: { () -> Void in
                        
                        self.confirmationCheckMarkImageView?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (Bool) -> Void in
            
            self.confirmationCheckMarkImageView?.transform = CGAffineTransform.identity
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarView?.backgroundColor = .clear
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addBackButton() {
        let btn: UIButton = UIButton(frame: CGRect(x: 15, y: 22, width: 50, height: 50))
        btn.setImage(UIImage.init(named: "Back"), for: .normal)
        btn.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        btn.imageEdgeInsets = UIEdgeInsetsMake(-15, -30, 0, 0); //TOP | LEFT | BOTTOM | RIGHT
        btn.backgroundColor = UIColor.clear
        btn.tag = 1
        self.view.addSubview(btn)
        
    }
    
    @objc public func backButtonAction(sender: UIButton?) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func checkForPayments() {
        if let transactionsHeader = EvaDataController.sharedInstance.transactionResponse?.transactionsHeader {
            SHARED.delegateStartTransaction = self
            self.doSaleTransaction(amount: transactionsHeader.display_value)
        }
    }
    
    func doSaleTransaction(amount: String) {
        if let totalInInt = Int(amount), totalInInt > 0 {
            let saleReq = SaleRequest(amount:totalInInt*100, externalId:"\(arc4random())")
            (UIApplication.shared.delegate as! AppDelegate).cloverConnector?.sale(saleReq)
        }
    }

    //MARK: StartTransactionDelegate delegates
    
    func proceedAfterReaderReady(merchantInfo: MerchantInfo) {
    }
    
    func onSalePaymentSuccess(_ saleResponse: SaleResponse?) {
        print("saleResponse")
        let transactionsHeader = EvaDataController.sharedInstance.transactionResponse?.transactionsHeader
        if let amt = transactionsHeader?.display_value {
            let confirmMsg = "Successfully processed your payment of $" + amt
            let finalConfirmMsg = confirmMsg + " :thumbsup:."
            messageLabel?.attributedText = EvaUtils.stringFromHtml(string: finalConfirmMsg.emojiUnescapedString)
            self.triggerPollyForPaymentSuccess(message: confirmMsg)
        } else {
            let confirmMsg = "Successfully processed your payment."
            messageLabel?.attributedText = EvaUtils.stringFromHtml(string: confirmMsg)
            self.triggerPollyForPaymentSuccess(message: confirmMsg)
        }
        self.animateTickImage()
        messageLabel?.textColor = UIColor.colorFromHex(hexString: "#9B9B9B")
        EvaDataController.sharedInstance.transactionResponse?.transactionsHeader = nil
    }
    
    func readerDisconnected() {
        
    }

    func triggerPollyForPaymentSuccess(message: String) {
        DispatchQueue.main.async(execute: {
            if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
                appdelegate.convertInputToVoice(queryString: message)
                
            }
        })
    }

}
