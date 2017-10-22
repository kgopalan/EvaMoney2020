//
//  SettingsViewController.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel?
    @IBOutlet weak var imageArrow: UIImageView?
    @IBOutlet weak var lableNickName: UILabel?
    @IBOutlet weak var switchScore: UISwitch?
    
}

class SettingsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableViewSettings: UITableView?
    var sectionName = ["GENERAL SETTINGS"]
    var itemsName = [["Name", "Email", "Change Password","Touch ID Authentication", "Enable Eva Voice Response"]]
    
    @IBOutlet weak var touchIDSwitch: UISwitch?
    
    var footerview :UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSettings?.delegate = self
        tableViewSettings?.dataSource = self
    }
    
    func initUI() {
        // Show bottom menu
        self.showHideFooter(false)
    }
    
    //Passcode Removal changes ends here
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.statusBarStyle = .default
        self.initUI()
        tableViewSettings?.contentOffset = CGPoint.init(x: 0, y: 0)
        tableViewSettings?.reloadData()
        //Removed made with text

        UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.setStatusBarColor), userInfo: nil, repeats: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func setStatusBarColor() {
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
    }
    
    @IBAction func touchIDStateChange(_ sender: UIButton) {
        sender.isSelected  = !sender.isSelected
        EvaDataController.sharedInstance.currentUser.touch_setting_enabled = sender.isSelected ? "true" : "false"
        tableViewSettings?.reloadData()
    }
    
    @IBAction func speakerStateChange(_ sender: UIButton) {
        sender.isSelected  = !sender.isSelected
        EvaDataController.sharedInstance.currentUser.voice_response = sender.isSelected ? "true" : "false"
        tableViewSettings?.reloadData()
    }
    
    
    func updateImage(_ sender: UIButton) {
        if sender.isSelected {
            sender.setImage(UIImage(named: "Check"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "unCheck"), for: .normal)
        }
    }
    func showHideFooter(_ isHide: Bool = false) {
        if footerview == nil {
            footerview = self.slideMenuController()?.view.viewWithTag(1000)
        }
        UIView.animate(withDuration: 0.15, animations: {
            self.footerview?.alpha = 0.5
        }, completion: { (_) in
            self.footerview?.alpha = 1.0
            self.footerview?.isHidden = isHide
        })
    }
    
    // MARK : Table View Delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionName.count
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsName[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTableCell", for: indexPath) as? SettingsTableViewCell {
            let user = EvaDataController.sharedInstance.currentUser
            if (indexPath.section == 0) {
                cell.switchScore?.isHidden = true
                if(indexPath.row == 0) {
                    cell.lableNickName?.isHidden = false
                    cell.lableNickName?.text = EvaDataController.sharedInstance.currentUser.user_nickname
                } else if(indexPath.row == 1) {
                    cell.lableNickName?.isHidden = false
                    cell.lableNickName?.text = EvaDataController.sharedInstance.currentUser.email
                } else {
                    cell.lableNickName?.isHidden = true
                    if(indexPath.row == 2) {
                        cell.imageArrow?.isHidden = false
                    }
                    if(indexPath.row == 3) {
                        let isOn = (user.touch_setting_enabled.lowercased() == "true") ? true : false
                        cell.switchScore?.isOn = isOn
                        cell.switchScore?.isSelected = isOn
                        cell.switchScore?.addTarget(self, action: #selector(touchIDStateChange(_:)), for: .valueChanged)
                        cell.switchScore?.isHidden = false
                        cell.imageArrow?.isHidden = true
                    }
                    if(indexPath.row == 4) {
                        let isOn = (EvaDataController.sharedInstance.currentUser.voice_response.lowercased() == "true") ? true : false
                        cell.switchScore?.isOn = isOn
                        cell.switchScore?.isSelected = isOn
                        cell.switchScore?.addTarget(self, action: #selector(speakerStateChange(_:)), for: .valueChanged)
                        cell.switchScore?.isHidden = false
                        cell.imageArrow?.isHidden = true
                    }
                }
                
            } else {
                cell.switchScore?.isHidden = true
                cell.lableNickName?.isHidden = true
            }
            cell.labelName?.text = itemsName[indexPath.section][indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 84.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionName[section]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 20.0))
        returnedView.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.size.width, height: 15))
        label.font = UIFont(name:"HelveticaNeue", size:13.0)
        label.textAlignment = .left
        label.textColor = UIColor.init(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = self.sectionName[section]
        returnedView.addSubview(label)
        
        return returnedView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    
    func tableView( _ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.section).")
        
        print("You tapped cell number \(indexPath.row).")
        
        if (indexPath.section == 0) {
            if(indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
                if let nickNameVC = self.storyboard?.instantiateViewController(withIdentifier: "MerchantInfoViewController") as? MerchantInfoViewController {
                    nickNameVC.selectedOption = indexPath.row
                    self.navigationController?.pushViewController(nickNameVC, animated: true)
                }
            }
        }
    }

}
