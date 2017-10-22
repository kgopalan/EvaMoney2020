//
//  LeftViewController.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit

enum LeftMenu: Int {
    case recentSearches
    case settings
}


protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    
    var menus = ["Recent Searches","Settings"]
    var mainViewController: UIViewController?

    var recentSearchesViewController: UIViewController?
    var settingsViewController: UIViewController?
    
    var menuTopItems: MenuTopItems!
    var isFeedBack = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    //MARK:- Viewcontroller Life cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.menuTopItems.reloadUI()
        self.menuTopItems.getTotalBalanceFromDB()
        self.tableView?.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.menuTopItems.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 264)
        self.view.layoutIfNeeded()
    }
    
    
    func initUI() {
        self.view.backgroundColor = UIColor.white
        // self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        // TableView Scrolling Disabled
        self.tableView?.alwaysBounceVertical = false;
        self.recentSearchesViewController = VCNames.recentSearches.navObject
        self.settingsViewController = VCNames.settings.navObject
        
        self.tableView?.registerCellClass(BaseTableViewCell.self)
        self.menuTopItems = MenuTopItems.loadNib()
        self.view.addSubview(self.menuTopItems)
        
    }
    
    func changeViewController(_ menu: LeftMenu) {
        self.slideMenuController()?.popToMainViewController()
        switch menu {
        case .recentSearches:
            DispatchQueue.main.async(execute: {
                self.showActivityView()
                let delayTime = DispatchTime.now() + .milliseconds(1)//+ Double(0.001)
                DispatchQueue.main.asyncAfter(deadline: delayTime) {
                    let output = EvaUtils.fetchFromDB(queryType: QueryType.recentSearch, vc: self)
                    self.hideActivityView()
                    self.hitDBForRecentSearch(responseDict: output.1)
                }
            })
            break
            
        case .settings: self.slideMenuController()?.changeMainViewController(self.settingsViewController ?? UIViewController(), close: true)
            
        }
    }
        
    func hitDBForRecentSearch(responseDict: [String: Any]?) {
        guard let response = responseDict else {
            self.slideMenuController()?.closeLeft()
            presentAlertWithTitle(title: CONNECTIVITY_ISSUE_TITLE, message: CONNECTIVITY_ISSUE_BODY)
            return
        }
        print(response)
        EvaDataController.sharedInstance.recentSearchResponse = RecentSearchs.Map(response)
        print(EvaDataController.sharedInstance.recentSearchResponse?.recentSearches ?? RecentSearchs.empty())
        self.slideMenuController()?.changeMainViewController(self.recentSearchesViewController ?? UIViewController(), close: true)
    }
    
    
}


//MARK:- UITableViewDelegate Methods

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .recentSearches, .settings:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}


//MARK:- UITableViewDataSource Methods

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .recentSearches, .settings:
                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setMenuWith(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}




