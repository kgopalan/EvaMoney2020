//
//  MerchantInfoViewController.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit

class MerchantInfoViewController: UIViewController,UITextFieldDelegate {
    var footerview :UIView?
    @IBOutlet weak var nicknameField: UITextField?
    @IBOutlet weak var displayTextLabel: UILabel?
    @IBOutlet weak var errorMessageLabel: UILabel?
    @IBOutlet weak var btnSave: UIButton?
    
    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    var selectedOption: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSave?.layer.cornerRadius = 26.0
        btnSave?.layer.borderWidth = 1.0
        btnSave?.layer.borderColor = UIColor.init(red: 60.0/255.0, green: 173.0/255.0, blue: 95.0/255.0, alpha: 1.0).cgColor
        
        nicknameField?.setBottomBorder()
        self.showHideFooter(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray]
        
        if selectedOption == 0 {
            self.navigationItem.title = "Change Name"
            displayTextLabel?.text = "Update your name:"
            nicknameField?.text = EvaDataController.sharedInstance.currentUser.user_nickname
            nicknameField?.isSecureTextEntry = false
            
        } else if selectedOption == 1 {
            self.navigationItem.title = "Change Email"
            displayTextLabel?.text = "Update your email:"
            nicknameField?.text = EvaDataController.sharedInstance.currentUser.email
            nicknameField?.isSecureTextEntry = false
            
        } else if selectedOption == 2 {
            self.navigationItem.title = "Change Password"
            let userPassword = EvaDataController.sharedInstance.currentUser.password
            displayTextLabel?.text = "Update your password:"
            nicknameField?.isSecureTextEntry = true
            nicknameField?.text = userPassword
        }
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor =  UIColor(red: 60.0/255.0, green: 173.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.topItem?.title = "Settings"
        self.errorMessageLabel?.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.updateUI()
        self.showHideFooter(false)
    }
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        self.saveTapped()
    }
    
    func saveTapped() {
        self.updateUI()
        //
    }
    
    func updateUI() {
        let value = nicknameField?.text ?? ""
        let currentEmailID = nicknameField?.text
        if selectedOption == 0 {
            if (value == "") {
                self.errorMessageLabel?.text = "Please enter your name"
                self.errorMessageLabel?.isHidden = false
                return
            } else {
                if value != EvaDataController.sharedInstance.currentUser.user_nickname {
                    EvaDataController.sharedInstance.currentUser.user_nickname = nicknameField?.text ?? EvaDataController.sharedInstance.currentUser.user_nickname
                    self.errorMessageLabel?.isHidden = true
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
        } else if selectedOption == 1 {
            
            if (value == "") {
                self.errorMessageLabel?.text = "Please enter your email"
                self.errorMessageLabel?.isHidden = false
                return
            } else if (!(currentEmailID?.isValidEmail())!) {
                self.errorMessageLabel?.text = "Please enter your valid email"
                self.errorMessageLabel?.isHidden = false
                return
            }
            else {
                if value != EvaDataController.sharedInstance.currentUser.email {
                    EvaDataController.sharedInstance.currentUser.email = nicknameField?.text ?? EvaDataController.sharedInstance.currentUser.email
                    self.errorMessageLabel?.isHidden = true
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
        } else if selectedOption == 2 {
            if (value == "") {
                self.errorMessageLabel?.text = "Please enter your password"
                self.errorMessageLabel?.isHidden = false
                return
            }else {
                if value != EvaDataController.sharedInstance.currentUser.password {
                    EvaDataController.sharedInstance.currentUser.password = nicknameField?.text ?? EvaDataController.sharedInstance.currentUser.password
                    self.errorMessageLabel?.isHidden = true
                    _ = self.navigationController?.popViewController(animated: true)
                    
                }
                
            }
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        print("make a nick name update service call")
        
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            for aViewController in viewControllers {
                if aViewController is SettingsViewController {
                    self.navigationController!.popToViewController(aViewController, animated: true)
                }
            }
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.errorMessageLabel?.isHidden = true
        if selectedOption == 2 {
            self.nicknameField?.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
