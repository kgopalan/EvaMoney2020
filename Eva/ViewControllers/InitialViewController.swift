//
//  InitialViewController.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import LocalAuthentication

class InitialViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginEmailField: FloatingTextField?
    @IBOutlet weak var loginPasswordField: FloatingTextField?
    @IBOutlet weak var enableTouchIDLabel: UILabel?
    @IBOutlet weak var touchIDSwitch: UISwitch?
    @IBOutlet weak var loginButton: UIButton?
    @IBOutlet weak var loginView: UIView?
    @IBOutlet weak var lblLoginErrorMsg: UILabel?
    @IBOutlet weak var buttonTouchIDThumb = UIButton(type: UIButtonType.custom)
    
    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    var player: AVPlayer?
    var footerview :UIView?
    var addthumbImage = true
    var userID = ""
    let myNotification = Notification.Name(rawValue:"ReloadView")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.catchNotification), name: NSNotification.Name(rawValue: "ReloadView"), object: nil)
        self.initUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.statusBarView?.backgroundColor = .clear
        self.updateLoginUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playVideo()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initUI() {
        UIApplication.shared.statusBarStyle = .lightContent
        self.signOnMethod()
        self.showHideFooter(true)
        self.setupThemeColors()
    }

    
    func updateLoginUI() {
        lblLoginErrorMsg?.isHidden = true
        userID = EvaDataController.sharedInstance.currentUser.user_Id
        // Testing only user id "'
        if (userID != "") {
            self.showLoginView()
        }
    }
    
    func showLoginView() {
        loginView?.isHidden = false
        loginView?.alpha = 1.0
    }
    
    // showOnboarding - false when sign out and come back to login
    func signOnMethod() {
        if self.getTouchIDStatus() {
            self.showTouchIDLoginPopup()
        } else {
            buttonTouchIDThumb?.isEnabled = false
            buttonTouchIDThumb?.alpha = 0.5
            self.beginEditing()
        }
    }
    
    func getTouchIDStatus() -> Bool{
        let touchID = EvaDataController.sharedInstance.currentUser.touch_setting_enabled
        if (touchID.lowercased() == "true") {
            return true
        }
        return false
    }
        
    func setupThemeColors() {
        
        self.loginEmailField?.delegate = self
        self.loginPasswordField?.delegate = self
        
        self.loginEmailField?.text = EvaUtils.emailIDMasking(emailString: EvaDataController.sharedInstance.currentUser.email)
        self.loginPasswordField?.text = EvaDataController.sharedInstance.currentUser.password
        
        self.loginEmailField?.placeholder     = NSLocalizedString("", tableName: "FloatingTextField", comment: "title for person Email field")
        self.loginEmailField?.selectedTitle   = NSLocalizedString("Email", tableName: "FloatingTextField", comment: "selected title for person Email field")
        self.loginEmailField?.title           = NSLocalizedString("Email", tableName: "FloatingTextField", comment: "title for person Email field")
        self.applySkyscannerTheme(textField: self.loginEmailField ?? FloatingTextField())
        self.loginEmailField?.delegate = self
        self.loginEmailField?.tag = 4
        
        self.loginPasswordField?.placeholder     = NSLocalizedString("", tableName: "FloatingTextField", comment: "placeholder for person Password field")
        self.loginPasswordField?.selectedTitle   = NSLocalizedString("Password", tableName: "FloatingTextField", comment: "selected title for person Email field")
        self.loginPasswordField?.title           = NSLocalizedString("Password", tableName: "FloatingTextField", comment: "title for person Password field")
        self.applySkyscannerTheme(textField: self.loginPasswordField ?? FloatingTextField())
        self.loginPasswordField?.delegate = self
        self.loginPasswordField?.tag = 5
        
        UITextField.appearance().tintColor = UIColor.init(red: 0, green: 107.0/255.0, blue: 152.0/255.0, alpha: 1.0)
        
        loginButton?.layer.borderColor = UIColor.init(red: 60.0/255.0, green: 173.0/255.0, blue: 95.0/255.0, alpha: 1.0).cgColor
        loginButton?.layer.cornerRadius = 25.0
        loginButton?.layer.borderWidth = 1.0
        
    }
    
    func applySkyscannerTheme(textField: FloatingTextField) {
        
        textField.tintColor = UIColor.white
        textField.textColor = UIColor.white
        textField.lineColor = lightGreyColor
        
        textField.selectedTitleColor = lightGreyColor
        textField.selectedLineColor = lightGreyColor
        
        // Set custom fonts for the title, placeholder and textfield labels
        // textField.titleLabel.textColor = UIColor.colorFromHex(hexString: "#9B9B9B")
        textField.titleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 11)
        textField.placeholderFont = UIFont(name: "HelveticaNeue-Light", size: 11)
        textField.font = UIFont(name: "HelveticaNeue", size: 14)
    }
    
    
    
    
    @IBAction func btnLoginClicked(_ sender: Any)  {
        
        let username = self.loginEmailField?.text ?? ""
        let password = self.loginPasswordField?.text ?? ""
        if username != "" && password != "" {
            self.pushToMainVC()
        }
    }
    
    func validateSignInFields() -> Bool {
        
        // TODO : Validate DB email id and password match
        if (self.loginEmailField?.text == "") {
            lblLoginErrorMsg?.isHidden = false
            lblLoginErrorMsg?.text = EnterYourEmailID
            return false
        }
        let currentEmailID = self.loginEmailField?.text
        if(!(currentEmailID?.isValidEmail())!) {
            lblLoginErrorMsg?.isHidden = false
            lblLoginErrorMsg?.text = EnterYourValidEmailID
            
            return false
        }
        if (self.loginPasswordField?.text == "") {
            lblLoginErrorMsg?.isHidden = false
            lblLoginErrorMsg?.text = EnterYourPassword
            return false
        }
        
        return true
    }
    
    
    func showKeyboardValidateWithUser()  {
    }
    
    func hideKeyboadOnboardScreen()  {
    }
    func showKeyBoard() {
        NotificationCenter.default.setObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    }
    
    // *****
    // MARK: - Add image on Number keyboard
    // ******
    
    func addImageOnNumberKeyboard() {
        
        buttonTouchIDThumb?.setTitle("", for: UIControlState())
        buttonTouchIDThumb?.setTitleColor(UIColor.black, for: UIControlState())
        buttonTouchIDThumb?.frame = CGRect(x: 0, y: 163, width: 50, height: 50)
        buttonTouchIDThumb?.setImage(UIImage.init(named: "touch50"), for: .normal)
        buttonTouchIDThumb?.adjustsImageWhenHighlighted = false
        buttonTouchIDThumb?.addTarget(self, action: #selector(InitialViewController.thumbTouchIDClicked(_:)), for: UIControlEvents.touchUpInside)
        
    }
    /*
     Generate 16 Digits Random Number
     */
    func generateRandomDigits() -> String {
        var number = ""
        for i in 0..<RANDOMNUMBER_LIMIT {
            var randomNumber = arc4random_uniform(10)
            while randomNumber == 0 && i == 0 {
                randomNumber = arc4random_uniform(10)
            }
            number += "\(randomNumber)"
        }
        return number
    }
    
    @IBAction func touchIDStateChange(_ sender: Any) {
        if (touchIDSwitch?.isOn)! {
            print("touchIDSwitch ON")
        } else {
            print("touchIDSwitch OFF")
        }
    }
    
    
    
    func pushToMainVC() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
            if let navigator = navigationController {
                self.showHideFooter()
                self.getTotalBalanceFromDB()
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    
    func getTotalBalanceFromDB() {
        
        DispatchQueue.global(qos: .background).async {
            var output = ("", [String: Any]())
            print("total Balance")
            output = EvaUtils.fetchFromDB(queryType: .totalBalance, vc: self)
            EvaDataController.sharedInstance.currentBalances = Balances.Map(output.1)
        }
    }
    
    
    func showHideFooter(_ isHide: Bool = false) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if footerview == nil {
                footerview = appDelegate.slideMenuController?.view.viewWithTag(1000)
            }
            footerview?.isHidden = isHide
        }
    }
    
    
    @IBAction func thumbPressedTouchIdEnable(_ sender: Any) {
        self.loginEmailField?.resignFirstResponder()
        self.showTouchIDLoginPopup()
    }
    /*
     // *****
     // MARK: - Touch ID Logic here
     // ******
     */
    // - parameter sender: a reference to the button that has been touched
    func showTouchIDLoginPopup() {
        
        let userID = EvaDataController.sharedInstance.currentUser.user_Id
        if (userID == "") {
            return
        }
        
        if EvaDataController.sharedInstance.currentUser.touch_setting_enabled.lowercased() == "false" {
            buttonTouchIDThumb?.isEnabled = false
            buttonTouchIDThumb?.alpha = 0.5
            return
        }
        let authenticationContext = LAContext()
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Use your fingerprint to access the Eva app",
            reply: { [unowned self] (success, error) -> Void in
                if( success ) {
                    DispatchQueue.main.async { () -> Void in
                        self.pushToMainVC()
                    }
                }else {
                    // Check if there is an error
                    if let error = error {
                        _ = self.errorMessageForLAErrorCode(error._code)
                    }
                }
        })
    }
    
    /**
     This method will present an UIAlertViewController to inform the user that there was a problem with the TouchID sensor.
     - parameter error: the error message
     
     */
    func showAlertViewAfterEvaluatingPolicyWithMessage( _ message:String ){
        showAlertWithTitle("Error", message: message)
    }
    
    func showAlertWithTitle( _ title:String, message:String ) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            DispatchQueue.main.async { () -> Void in
                self.beginEditing()
            }
            // self.showKeyBoard()
        })
        alertVC.addAction(okAction)
        DispatchQueue.main.async { () -> Void in
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    /**
     This method will return an error message string for the provided error code.
     The method check the error code against all cases described in the `LAError` enum.
     If the error code can't be found, a default message is returned.
     
     - parameter errorCode: the error code
     - returns: the error message
     */
    func errorMessageForLAErrorCode( _ errorCode:Int ) -> String{
        
        var message = ""
        
        switch errorCode {
            
        case LAError.Code.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.Code.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.Code.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.Code.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.Code.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.Code.touchIDNotAvailable.rawValue, LAError.Code.touchIDNotEnrolled.rawValue, LAError.Code.touchIDLockout.rawValue:
            buttonTouchIDThumb?.isEnabled = false
            buttonTouchIDThumb?.alpha = 0.5
            let delayTime = DispatchTime.now() + 0.2
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self.beginEditing()
            }
            
        case LAError.Code.userCancel.rawValue, LAError.Code.userFallback.rawValue:
            let delayTime = DispatchTime.now() + 0.2
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self.beginEditing()
            }
        default:
            let delayTime = DispatchTime.now() + 0.2
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self.beginEditing()
            }
        }
        return message
    }
    
    
    // *****
    // MARK: - TextField Deledate methods
    // ******
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.viewResetAnimation()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.viewMoveUpScreen()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.viewMoveDownScreen()
        if textField == self.loginEmailField {
            if EvaUtils.isValidEmail(textField.text ?? "") == false {
                self.lblLoginErrorMsg?.isHidden = false
                self.lblLoginErrorMsg?.text = EnterYourValidEmailID
            }
        }
    }
    
    func viewMoveUpScreen()  {
        switch UIDevice().screenType {
        case  .iPhone5:
            self.animateViewMovingUpandDown(up: true, moveValue: 80)
            break
        default:
            break
        }
        
    }
    
    func viewMoveDownScreen()  {
        switch UIDevice().screenType {
        case  .iPhone5:
            self.animateViewMovingUpandDown(up: true, moveValue: -80)
            break
        default:
            break
        }
    }
    
    func viewResetAnimation()  {
        switch UIDevice().screenType {
        case  .iPhone5:
            self.animateViewMovingUpandDown(up: true, moveValue: 0)
            break
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text == self.loginEmailField?.text && self.loginEmailField?.text == EvaDataController.sharedInstance.currentUser.user_Id {
            textField.text = ""
        }
        self.hideErrorMsgLabel()
        return true
    }
    
    
    func beginEditing() {
        UIView.setAnimationsEnabled(false)
        self.showKeyboardValidateWithUser()
        UIView.setAnimationsEnabled(true)
    }
    
    func animateViewMovingUpandDown (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    
    /*
     Display Alert
     */
    func presentErrorAlertWithTitle(title: String, message : String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in
            DispatchQueue.main.async { () -> Void in
                self.beginEditing()
            }
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // *****
    // MARK: - Add Thumb image on Keyboard  action
    // ******
    
    @objc func keyboardWillShow(_ note : Notification) -> Void{
        
        UIView.animate(withDuration: (((note.userInfo! as NSDictionary).object(forKey: UIKeyboardAnimationCurveUserInfoKey) as AnyObject).doubleValue)!, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: 0)
        }, completion: { (complete) -> Void in
            print("Complete")
        })
        
    }
    
    @objc func thumbTouchIDClicked(_ sender : UIButton){
        DispatchQueue.main.async { () -> Void in
            self.loginEmailField?.resignFirstResponder()
            // Enable Touch ID again
            self.showTouchIDLoginPopup()
        }
    }
    
    
    private func hideErrorMsgLabel() {
        lblLoginErrorMsg?.isHidden = true
        lblLoginErrorMsg?.text = ""
    }
    
    @objc func catchNotification() {
        print("Catch notification")
        self.switchRootVC()
        self.initUI()
        //_ = Timer.scheduledTimer(timeInterval: 1.8, target: self, selector: #selector(switchRootVC), userInfo: nil, repeats: false)
    }
    
    func switchRootVC() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.nvc = UINavigationController(rootViewController: appDelegate.initialViewController ?? InitialViewController())
            appDelegate.leftViewController?.mainViewController = appDelegate.nvc
            
            appDelegate.slideMenuController = ExSlideMenuController(mainViewController:appDelegate.nvc ?? UINavigationController() , leftMenuViewController: appDelegate.leftViewController ?? UIViewController())
            appDelegate.slideMenuController?.delegate = appDelegate.mainViewController
            appDelegate.window?.rootViewController = appDelegate.slideMenuController
            footerview = nil
            self.showHideFooter(true)
        }
    }
    
    
    private func playVideo() {
        // Load the video from the app bundle.
        let videoURL: URL = Bundle.main.url(forResource: "SignUpPageVideo", withExtension: "mov")!
        
        player = AVPlayer(url: videoURL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.zPosition = -1
        
        playerLayer.frame = view.frame
        
        view.layer.addSublayer(playerLayer)
        
        player?.play()
        
        //Slow down video to play
        player?.rate = 0.7
        
        //loop video
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(InitialViewController.loopVideo),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: self.player?.currentItem)
        
    }
    
    @objc func loopVideo() {
        let duration : Int64 = 0
        let preferredTimeScale : Int32 = 1
        let seekTime : CMTime = CMTimeMake(duration, preferredTimeScale)
        player?.seek(to: seekTime)
        player?.play()
        //Slow down video to play
        player?.rate = 0.7
        
    }
    
}


extension NotificationCenter {
    func setObserver(_ observer: AnyObject, selector: Selector, name: NSNotification.Name, object: AnyObject?) {
        NotificationCenter.default.removeObserver(observer, name: name, object: object)
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
}



