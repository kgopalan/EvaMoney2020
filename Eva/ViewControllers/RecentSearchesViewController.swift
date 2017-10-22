//
//  RecentSearchesViewController.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit

class RecentSearchesViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var firstInfoLabel: UILabel?
    @IBOutlet weak var secondInfoLabel: UILabel?
    @IBOutlet weak var thirdInfoLabel: UILabel?
    @IBOutlet weak var fourthInfoLabel: UILabel?
    @IBOutlet weak var fifthInfoLabel: UILabel?
    
    @IBOutlet weak var headerLabel: UILabel?
    @IBOutlet weak var headerLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var firstLblTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondLblTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdLblTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var fourthLblTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var fifthLblTopConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        UIApplication.shared.statusBarView?.backgroundColor = .clear
        self.navigationController?.navigationBar.isHidden = true
        self.setRecentSearchText()
        self.animatedLabelDeviceFrameAdoption()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animatedLabelDeviceFrameAdoption()  {
        switch UIDevice().screenType {
        case .iPhone4, .iPhone5:
            // Code for iPhone 4 & iPhone 5
            firstLblTopConstraint.constant = 40.0
            secondLblTopConstraint.constant = animatedLblConstraintsSetiPhone5
            thirdLblTopConstraint.constant = animatedLblConstraintsSetiPhone5
            fourthLblTopConstraint.constant = animatedLblConstraintsSetiPhone5
            fifthLblTopConstraint.constant = animatedLblConstraintsSetiPhone5
            
            firstInfoLabel?.font = EvaUtils.getFont(of: animatedLblFontName, of: animatedLblfontSizePhone5)
            secondInfoLabel?.font = EvaUtils.getFont(of: animatedLblFontName, of: animatedLblfontSizePhone5)
            thirdInfoLabel?.font = EvaUtils.getFont(of: animatedLblFontName, of: animatedLblfontSizePhone5)
            fourthInfoLabel?.font = EvaUtils.getFont(of: animatedLblFontName, of: animatedLblfontSizePhone5)
            fifthInfoLabel?.font = EvaUtils.getFont(of: animatedLblFontName, of: animatedLblfontSizePhone5)
            break
        case .iPhone6:
            // Code for iPhone 6 & iPhone 7
            firstLblTopConstraint.constant = animatedLblConstraintsSetiPhone6
            secondLblTopConstraint.constant = animatedLblConstraintsSetiPhone6
            thirdLblTopConstraint.constant = animatedLblConstraintsSetiPhone6
            fourthLblTopConstraint.constant = animatedLblConstraintsSetiPhone6
            fifthLblTopConstraint.constant = animatedLblConstraintsSetiPhone6
            
            firstInfoLabel?.font = EvaUtils.getFont(of: animatedLblFontName, of: animatedLblfontSizeiPhone6)
            secondInfoLabel?.font = EvaUtils.getFont(of: animatedLblFontName, of: animatedLblfontSizeiPhone6)
            thirdInfoLabel?.font = EvaUtils.getFont(of: animatedLblFontName, of: animatedLblfontSizeiPhone6)
            fourthInfoLabel?.font = EvaUtils.getFont(of: animatedLblFontName, of: animatedLblfontSizeiPhone6)
            fifthInfoLabel?.font = EvaUtils.getFont(of:animatedLblFontName, of: animatedLblfontSizeiPhone6)
            break
        case .iPhone6Plus:
            // Code for iPhone 6 Plus & iPhone 7 Plus
            firstLblTopConstraint.constant = animatedLblConstraintsSetiPhone6
            secondLblTopConstraint.constant = animatedLblConstraintsSetiPhone6
            thirdLblTopConstraint.constant = animatedLblConstraintsSetiPhone6
            fourthLblTopConstraint.constant = animatedLblConstraintsSetiPhone6
            fifthLblTopConstraint.constant = animatedLblConstraintsSetiPhone6
            firstInfoLabel?.font = EvaUtils.getFont(of:animatedLblFontName, of: animatedLblfontSizeiPhone6)
            secondInfoLabel?.font = EvaUtils.getFont(of: animatedLblFontName, of: animatedLblfontSizeiPhone6)
            thirdInfoLabel?.font = EvaUtils.getFont(of: animatedLblFontName, of: animatedLblfontSizeiPhone6)
            fourthInfoLabel?.font = EvaUtils.getFont(of: animatedLblFontName, of: animatedLblfontSizeiPhone6)
            fifthInfoLabel?.font = EvaUtils.getFont(of:animatedLblFontName, of: animatedLblfontSizeiPhone6)
            break
        default:
            break
        }
    }
    func setRecentSearchText() {
        
        let recentsearches = EvaDataController.sharedInstance.recentSearchResponse?.recentSearches ?? []
        
        //Set empty first
        self.firstInfoLabel?.attributedText = EvaUtils.formatPoint8Text(text: "")
        self.secondInfoLabel?.attributedText = EvaUtils.formatPoint8Text(text: "")
        self.thirdInfoLabel?.attributedText = EvaUtils.formatPoint8Text(text: "")
        self.fourthInfoLabel?.attributedText = EvaUtils.formatPoint8Text(text: "")
        self.fifthInfoLabel?.attributedText = EvaUtils.formatPoint8Text(text: "")
        
        if recentsearches.count == 0 {
            headerLabelTopConstraint.constant = (self.view.frame.size.height/2.0) - ((headerLabel?.frame.size.height ?? 0)/2)
            headerLabel?.text? = NO_RECENT_SEARCHES
            return
        }
        
        headerLabelTopConstraint.constant = 83.0 // as per storyboard
        
        //Set original text
        if recentsearches.count > 0 {
            let recentsearch = recentsearches[0]
            self.firstInfoLabel?.attributedText = EvaUtils.formatPoint8Text(text: recentsearch.query_text)
        }
        
        if recentsearches.count > 1 {
            let recentsearch = recentsearches[1]
            self.secondInfoLabel?.attributedText = EvaUtils.formatPoint8Text(text: recentsearch.query_text)
        }
        
        if recentsearches.count > 2 {
            let recentsearch = recentsearches[2]
            self.thirdInfoLabel?.attributedText = EvaUtils.formatPoint8Text(text: recentsearch.query_text)
        }
        
        if recentsearches.count > 3 {
            let recentsearch = recentsearches[3]
            self.fourthInfoLabel?.attributedText = EvaUtils.formatPoint8Text(text: recentsearch.query_text)
        }
        
        if recentsearches.count > 4 {
            let recentsearch = recentsearches[4]
            self.fifthInfoLabel?.attributedText = EvaUtils.formatPoint8Text(text: recentsearch.query_text)
        }
        
        if(EvaDataController.sharedInstance.currentUser.user_nickname == "") {
            headerLabel?.text? = RecentSeacrchWithOutName
        } else {
            headerLabel?.text? = String(format: "%@%@%@", "Hey ",EvaDataController.sharedInstance.currentUser.user_nickname,RecentSeacrchWithName)
        }
        
        // Add Tap gesture
        self.addTapGesture(label: firstInfoLabel ?? UILabel())
        self.addTapGesture(label: secondInfoLabel ?? UILabel())
        self.addTapGesture(label: thirdInfoLabel ?? UILabel())
        self.addTapGesture(label: fourthInfoLabel ?? UILabel())
        self.addTapGesture(label: fifthInfoLabel ?? UILabel())
        
    }
    
    func addTapGesture(label: UILabel) {
        let leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        leftTapGesture.delegate = self
        label.addGestureRecognizer(leftTapGesture)
        
        label.isUserInteractionEnabled = true
    }
    
    @objc func labelTapped(_ recognizer : UIGestureRecognizer) {
        if let  tappedlabel = recognizer.view as? UILabel {
            self.hitDB(tappedlabel.text ?? "")
        }
    }
    
    func hitDB(_ query: String?) {
        
        var queryString = query ?? EMPTY_STRING
        var output = ("", [String: Any]())
        
        self.showActivityView()
        let delayTime = DispatchTime.now() + .milliseconds(1)//+ Double(0.001)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            print("recent search")
            queryString = queryString.replacingOccurrences(of:"\'", with: "", options:.literal, range: nil)
            output = EvaUtils.fetchFromDB(queryString: queryString, queryType: .voiceSearch, vc: self)
            self.hideActivityView()
            self.pushToTransactionDetails(responseString: output.1)
            
            DispatchQueue.main.async(execute: {
                if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
                    appdelegate.convertInputToVoice(queryString: output.0)
                    
                }
            })
        }
    }
    
    
    func pushToTransactionDetails(responseString: [String: Any]?) {
        guard let response = responseString else {
            presentAlertWithTitle(title: CONNECTIVITY_ISSUE_TITLE, message: CONNECTIVITY_ISSUE_BODY)
            return
        }
        print(response)
        EvaDataController.sharedInstance.transactionResponse = Transactions.Map(response)
        
        if EvaDataController.sharedInstance.transactionResponse?.transactionsHeader?.display_type == "" {
            presentAlertWithTitle(title: "", message: NO_RESULT_FOR_SEARCH)
            return
        }
        EvaUtils.findDisplayType()
        
        EvaDataController.sharedInstance.showBackArrow = true
        
        let displayType: DisplayType? = EvaDataController.sharedInstance.currentDisplayType
        switch displayType ?? .message {
        case .messageWithTransaction:
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransactionsResultViewController") as? TransactionsResultViewController {
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
            
        case .message, .messageWithChart, .messageWithPieChart:
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MessageTypeViewController") as? MessageTypeViewController {
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }
    }
}
