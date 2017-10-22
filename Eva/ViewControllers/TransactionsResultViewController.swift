//
//  TransactionsResultViewController.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit

class TransactionsResultViewController: GraphViewController {
    
    var items = [String]()
    var tableViewOffsetRange: CGFloat = 0.0
    // BottomView min height = 50
    let bottomViewMinHeight: CGFloat = 60.0
    let iconsMinHeight: CGFloat = 47.0
    let bottomViewMaxHeight: CGFloat = 80.0
    let iconsMaxHeight: CGFloat = 64.0
    
    var topViewMaxHeight: CGFloat = 250.0
    let topViewMinHeight: CGFloat = 100.0
    let TABLECELL_HEIGHT = 99
    let TABLE_FIRST_CELL_HEIGHT = 137
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var appleHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var appleWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomViewaHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var menuButton: UIButton?
    @IBOutlet weak var microphoneButton: UIButton?
    
    var headerView: customHeaderView!
    
    let HEADER_HEIGHT_125 = CGFloat(125.0)
    let HEADER_HEIGHT_325 = CGFloat(325.0)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        EvaDataController.sharedInstance.selectedAccountIndex = 0
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Graph
        topViewMaxHeight = HEADER_HEIGHT_325
        self.headerSetup()
        self.initUI()
        self.setThemeColor()
        self.setHeaderThemeColor()
    }
    
    @objc func setStatusBarColor() {
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.colorFromHex(hexString: "#1A1A2D")
    }
    
    func setThemeColor() {
        self.tableView?.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor.colorFromHex(hexString: "#1A1A2D")
        // Show back arrow for Recent Search Transactions
        if EvaDataController.sharedInstance.showBackArrow == true {
            self.addBackButton()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func initUI() {
        self.tableView.reloadData()
        self.tableView.tableFooterView = UIView()
        self.setButtonProperties()
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.setStatusBarColor), userInfo: nil, repeats: false)
    }
    
    
    func addBackButton() {
        let btn: UIButton = UIButton(frame: CGRect(x: 15, y: 22, width: 50, height: 50))
        btn.setImage(UIImage.init(named: "Back"), for: .normal)
        btn.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        btn.imageEdgeInsets = UIEdgeInsetsMake(-15, -30, 0, 0); //TOP | LEFT | BOTTOM | RIGHT
        btn.backgroundColor = UIColor.clear
        btn.tag = 1
        headerView.addSubview(btn)
    }
    
    @objc public func backButtonAction(sender: UIButton?) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func headerSetup() {
        
        guard let headerViewObj = customHeaderView(frame: CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.size.width, height: topViewMaxHeight), message: "test") else {
            return
        }
        headerView = headerViewObj
    }
    
    func initialLoad() {
        tableViewTopConstraint.constant = topViewMaxHeight
        headerHeightConstraint.constant = topViewMaxHeight
        if let _ = headerView {
            headerView.updateConstraintForView(topViewMaxHeight)
        }
    }
    
    func setButtonProperties() {
        
        self.microphoneButton?.backgroundColor = .clear
        self.microphoneButton?.setTitle("", for: .normal)
        self.microphoneButton?.layer.borderWidth = 4.0
        self.microphoneButton?.setImage(nil, for: .normal)
        self.microphoneButton?.setBackgroundImage(UIImage.init(named: "SiriRecord"), for: .normal)
        
        self.menuButton?.addTarget(self, action:#selector(self.menuButtonClicked), for: .touchUpInside)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     Method used to calculate the height of footer disclaimer text
     */
    internal func heightOfFooter(_ headerString : String, font : UIFont, width : CGFloat) -> CGFloat {
        
        let message = headerString
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.attributedText = EvaUtils.stringFromHtml(string: message.emojiUnescapedString)
        label.sizeToFit()
        return label.frame.height + 1
    }
    
    func getMessagePartHeight() -> CGFloat {
        if let transactionsHeader = EvaDataController.sharedInstance.transactionResponse?.transactionsHeader {
            var height = 45
            height += Int(self.heightOfFooter(transactionsHeader.user_query_text.trimTrailingWhitespace(), font: EvaUtils.getFont(of: "Helvetica Neue", of: 17.0), width: self.view.frame.size.width - 59) + 33) // spacing
            height += Int(self.heightOfFooter(transactionsHeader.display_message, font: EvaUtils.getFont(of: "Helvetica Neue", of: 17.0), width: self.view.frame.size.width - 59) + 35) // spacing
            headerView.contentView.topViewHeightConstraint.constant = CGFloat(height)
            self.setHeaderThemeColor()
            return CGFloat(height) // spacing
        }
        return HEADER_HEIGHT_125
    }
    
    func setHeaderThemeColor() {
        let displayType = EvaDataController.sharedInstance.currentDisplayType
        self.tableView.separatorColor = UIColor.lightGray
    }
}


extension TransactionsResultViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard (0, 0) == (indexPath.section, indexPath.row) else { return }
        
        for view in cell.subviews where view != cell.contentView {
            view.backgroundColor = UIColor.white
            //view.removeFromSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Graph, Bar & Card
        if (EvaDataController.sharedInstance.currentDisplayType == .messageWithTransaction) {
            headerView.contentView.amountHeightConstraint.constant = CGFloat(0.0)
            headerView.contentView.topViewHeightConstraint.constant = CGFloat(self.getMessagePartHeight())
            headerView.contentView.amountView.isHidden = true
            return headerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.getMessagePartHeight() //HEADER_HEIGHT_125
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EvaDataController.sharedInstance.transactionResponse?.orders.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TransactionInfoCell"
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TransactionInfoCell {
            cell.selectionStyle = .none
            cell.updateCellValues(indexPath: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TABLECELL_HEIGHT)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // self.showTransactionDetailPopup(indexPath)
    }
    
    // MARK: UITableViewDelegate Methods - Edit style
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .normal, title: "More") { (rowAction, indexPath) in
            //TODO: edit the row at indexPath here
        }
        editAction.backgroundColor = UIColor.colorFromHex(hexString: "#50E3C2")
        
        return [editAction]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    
    // any offset changes
    /***************
     // TODO :if scrolling upto bottom then Scroll up if offset values goes 100 setting default Constraint
     // Need to check how to need that animation.
     ************/
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}

