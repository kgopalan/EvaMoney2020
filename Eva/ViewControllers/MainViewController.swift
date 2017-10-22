//
//  MainViewController.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit
import Speech
import AVFoundation
import AWSPolly
import CloverConnector_Hackathon_2017

let HEADER_DEFAULT_TEXT = "How can I help you?"

class MainViewController: UIViewController, UIGestureRecognizerDelegate, StartTransactionDelegate {
    
    var cloverConnector350Reader : ICloverGoConnector?
    var cloverConnector450Reader : ICloverGoConnector?
    public var cloverConnectorListener:CloverGoConnectorListener?

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var siriVoiceView: UIView?
    @IBOutlet weak var siriManualView: UIView?
    @IBOutlet weak var siriVoiceSubView: UIView?
    @IBOutlet weak var siriManualSubView: UIView?
    
    @IBOutlet weak var siriManualTextView: UITextView?
    var siriPlaceholderLabel : UILabel?
    @IBOutlet weak var siriManualCancelButton: UIButton?
    @IBOutlet weak var siriManualGoButton: UIButton?
    
    @IBOutlet weak var textView: UITextView?
    @IBOutlet weak var siriSearchTextLabel: UILabel?
    @IBOutlet weak var audioView: SwiftSiriWaveformView?
    @IBOutlet weak var siriContentView: SiriContentView?
    
    
    @IBOutlet weak var pageControl: UIPageControl?
    @IBOutlet weak var containerView: UIView?
    
    fileprivate let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))!
    fileprivate var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    fileprivate var recognitionTask: SFSpeechRecognitionTask?
    fileprivate let audioEngine = AVAudioEngine()
    
    @IBOutlet weak var headerLabel: UILabel?
    
    var footerview :UIView?
    var footerviewMicrophoneButton: UIButton?
    var isResetExecuted = false
    
    var height = CGFloat(0.02)
    var timer:Timer?
    var change:CGFloat = 0.01
    var count: Int = 0
    
    let siriBGColor = UIColor.white
    let SIRI_PLACEHOLDER = "Show me today's orders"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.updateHeaderLabel()
        self.connectClover450Reader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.statusBarView?.backgroundColor = .clear
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        siriContentView?.endEditing(false)
        siriContentView?.setLayoutProperties()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.audioPlayer.volume = 0
        }
        self.updateHeaderLabel()
        siriPlaceholderLabel?.isHidden = false
        self.resizeTextView(textView: self.siriManualTextView ?? UITextView())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        siriContentView?.endEditing(true)
        siriContentView?.invalidateAllTimer()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func connectClover450Reader() {
        
        FLAGS.isKeyedTransaction = false
        
        if(!FLAGS.is450ReaderInitialized)
        {
            if(((PARAMETERS.accessToken) != nil) && ((PARAMETERS.apiKey) != nil) && ((PARAMETERS.secret) != nil))
            {
                if(FLAGS.isOAuthMode)
                {
                    let config450Reader = CloverGoDeviceConfiguration.Builder(apiKey: PARAMETERS.apiKey, secret: PARAMETERS.secret, env: .live).accessToken(accessToken: PARAMETERS.accessToken).allowAutoConnect(allowAutoConnect: true).allowDuplicateTransaction(allowDuplicateTransaction: true).build()
                    cloverConnector450Reader = CloverGoConnector(config: config450Reader)
                }
                else
                {
                    let config450Reader : CloverGoDeviceConfiguration = CloverGoDeviceConfiguration.Builder(apiKey: PARAMETERS.apiKey, secret: PARAMETERS.secret, env: .live).accessToken(accessToken: PARAMETERS.accessToken).allowAutoConnect(allowAutoConnect: true).allowDuplicateTransaction(allowDuplicateTransaction: false).build()
                    cloverConnector450Reader = CloverGoConnector(config: config450Reader)
                }
                
                cloverConnectorListener = CloverGoConnectorListener(cloverConnector: cloverConnector450Reader!)
                (cloverConnector450Reader as? CloverGoConnector)?.addCloverGoConnectorListener(cloverConnectorListener: (cloverConnectorListener as? ICloverGoConnectorListener)!)
                (UIApplication.shared.delegate as! AppDelegate).cloverConnectorListener = cloverConnectorListener
                (UIApplication.shared.delegate as! AppDelegate).cloverConnector = cloverConnector450Reader
                cloverConnector450Reader?.initializeConnection()
            }
            else
            {
                let alert = UIAlertController(title: nil, message: "Missing parameters to initialize the SDK", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
           /* let alert = UIAlertController(title: nil, message: "Reader 450 is already initialized", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil) */
        }
        SHARED.delegateStartTransaction = self
    }
    
    //MARK: StartTransactionDelegate delegates
    
    func proceedAfterReaderReady(merchantInfo: MerchantInfo)
    {
        if merchantInfo.deviceInfo?.deviceModel == "RP350X"
        {
            FLAGS.is350ReaderInitialized = true
            checkReaderConnectedStatus()
        }
        if merchantInfo.deviceInfo?.deviceModel == "RP450X"
        {
            FLAGS.is450ReaderInitialized = true
            checkReaderConnectedStatus()
        }
        
    }
    
    func onSalePaymentSuccess(_ saleResponse: SaleResponse?) {
        
    }

    func readerDisconnected()
    {
        FLAGS.is350ReaderInitialized = false
        FLAGS.is450ReaderInitialized = false
        checkReaderConnectedStatus()
    }
    
    func checkReaderConnectedStatus()
    {
        if FLAGS.is350ReaderInitialized{
            print("Reader 350 connected ✅")
            print("Disconnect")
        }
        else{
            print("No 350 Reader connected")
            print("Connect")
        }
        if FLAGS.is450ReaderInitialized{
            print("Reader 450 connected ✅")
            print("Disconnect")
        }
        else{
            print("No 450 Reader connected")
            print("Connect")
        }
    }

    
    /**
     show/hidee fooder view
     */
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
    /**
     Initiate UI when loading .xibs
     */
    func initUI() {
        self.view.backgroundColor = UIColor.colorFromHex(hexString: "#1A1A2D")
        self.setSiriViewProperties()
        self.setManualViewProperties()
        // self.addGestureRecoginizer()
        self.initAudioView()
        self.getfooterview()
         self.setuoSiriContentView()
        //  self.categoryName()
        
        EvaDataController.sharedInstance.currentSearchType = .none
    }
    
    func updateHeaderLabel() {
        headerLabel?.text = HEADER_DEFAULT_TEXT
    }
    func setuoSiriContentView() {
        
        siriContentView?.firstInfoLabel?.isUserInteractionEnabled = true
        siriContentView?.secondInfoLabel?.isUserInteractionEnabled = true
        siriContentView?.thirdInfoLabel?.isUserInteractionEnabled = true
        siriContentView?.fourthInfoLabel?.isUserInteractionEnabled = true
        siriContentView?.fifthInfoLabel?.isUserInteractionEnabled = false
        siriContentView?.sixthInfoLabel?.isUserInteractionEnabled = false
        
        self.addTapGestureRecognizer(siriContentView?.firstInfoLabel ?? UILabel())
        self.addTapGestureRecognizer(siriContentView?.secondInfoLabel ?? UILabel())
        self.addTapGestureRecognizer(siriContentView?.thirdInfoLabel ?? UILabel())
        self.addTapGestureRecognizer(siriContentView?.fourthInfoLabel ?? UILabel())
        self.addTapGestureRecognizer(siriContentView?.fifthInfoLabel ?? UILabel())
        self.addTapGestureRecognizer(siriContentView?.sixthInfoLabel ?? UILabel())
        
    }
    
    func addTapGestureRecognizer(_ label: UILabel) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.flyingLabelTapped(_:)))
        tapGesture.delegate = self
        label.addGestureRecognizer(tapGesture)
    }
    
    /**
     Initiate Siri voice view properties
     */
    func setSiriViewProperties() {
        
        self.siriVoiceView?.alpha = 0.0
        self.siriVoiceSubView?.alpha = 0.0
        self.siriVoiceSubView?.backgroundColor = UIColor.clear
        self.siriManualView?.alpha = 0.0
        self.siriManualSubView?.alpha = 0.0
        UITextView.appearance().tintColor = UIColor.black // UIColor.init(red: 237.0/255.0, green: 70.0/255.0, blue: 102.0/255.0, alpha: 1.0)
    }
    
    /**
     Initiate Manual text search view properties
     */
    func setManualViewProperties() {
        
        // EvaDataController.sharedInstance.isThumbImageAddonKeyboad = false
        
        self.siriManualTextView?.font = EvaUtils.getFont(of: "Avenir", of: 22.0)
        self.siriManualCancelButton?.titleLabel?.font = EvaUtils.getFont(of: "Avenir", of: 16.0)
        self.siriManualGoButton?.titleLabel?.font = EvaUtils.getFont(of: "Avenir", of: 16.0)
        
        self.siriManualGoButton?.layer.cornerRadius = 17.0
        self.siriManualGoButton?.layer.borderWidth = 1.0
        self.siriManualCancelButton?.layer.cornerRadius = 17.0
        self.siriManualCancelButton?.layer.borderWidth = 1.0
        self.siriManualGoButton?.layer.borderColor = UIColor.init(red: 60.0/255.0, green: 173.0/255.0, blue: 95.0/255.0, alpha: 1).cgColor //UIColor.white.cgColor
        self.siriManualCancelButton?.layer.borderColor = UIColor.init(red: 60.0/255.0, green: 173.0/255.0, blue: 95.0/255.0, alpha: 1).cgColor //UIColor.white.cgColor
        
        self.siriManualTextView?.textContainerInset = UIEdgeInsetsMake(20, 0, 0, 0);
        self.siriPlaceholderText()
        self.resizeTextView(textView: self.siriManualTextView ?? UITextView())
    }
    
    func siriPlaceholderText() {
        siriPlaceholderLabel = UILabel()
        siriPlaceholderLabel?.text = SIRI_PLACEHOLDER
        siriPlaceholderLabel?.font = EvaUtils.getFont(of: "Avenir", of: 15.0)
        siriPlaceholderLabel?.sizeToFit()
        siriPlaceholderLabel?.preferredMaxLayoutWidth = self.siriManualTextView?.frame.size.width ?? self.view.frame.size.width
        siriPlaceholderLabel?.lineBreakMode = .byTruncatingTail
        self.siriManualTextView?.addSubview(siriPlaceholderLabel ?? UILabel())
        siriPlaceholderLabel?.frame.origin = CGPoint(x: 5, y: 26.0)
        siriPlaceholderLabel?.textColor = UIColor.lightGray//UIColor.init(white: 1.0, alpha: 0.5)
        siriPlaceholderLabel?.isHidden = false
    }
    /**
     Micro phone permission check here
     */
    func microPhonePermissionCheck() {
        
        AVCaptureDevice.requestAccess(for: AVMediaType.audio) { response in
            if response == true {
                print("MicroPhone access given")
            } else {
                self.showNotEnabledAlert(message: "Hey there, it appears that microphone access is disabled, please enable it so listen to voice responses from Eva.")
                //                self.presentAlertWithTitle(title: "Eva", message:"Your microphone permisson is denied.Please go to settings in Eva and enable it")
                print("MicroPhone not access given")
            }
        }
    }
    
    /**
     Initiate SFSpeech Recognizer properties for voice recording
     */
    
    func initSFSpeechRecognizer() {
        
        microphoneButton?.isEnabled = false
        footerviewMicrophoneButton?.isEnabled = false
        speechRecognizer.delegate = self
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            var isButtonEnabled = false
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                // Microphone permision check here
                // Todo: right now handled alert - replace to place holder text
                _ = self.microPhonePermissionCheck()
            case .denied:
                isButtonEnabled = true
                self.showNotEnabledAlert(message: "Oops, looks like the Speech Recognition setting is turned off. Please enable it on from Settings to ask Eva your questions.")
                //                self.presentAlertWithTitle(title: "Eva", message:"Your speech recognition permisson is denied.Please go to settings in Eva and enable speech recognition")
                print("User denied access to speech recognition")
            case .restricted:
                isButtonEnabled = true
                self.showNotEnabledAlert(message: "Speech recognition is restricted on this device")
                //                self.presentAlertWithTitle(title: "Eva", message:"Speech recognition is restricted on this device")
                print("Speech recognition restricted on this device")
            case .notDetermined:
                isButtonEnabled = true
                self.showNotEnabledAlert(message: "Speech recognition is notdetermined on this device")
                //                self.presentAlertWithTitle(title: "Eva", message:"Speech recognition is notdetermined on this device")
                print("Speech recognition not yet authorized")
            }
            OperationQueue.main.addOperation() {
                self.microphoneButton?.isEnabled = isButtonEnabled
                self.footerviewMicrophoneButton?.isEnabled = isButtonEnabled
            }
        }
    }
    
    
    func showNotEnabledAlert(message: String) {
        
        let alertController = UIAlertController (title: "Eva", message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    /**
     Initiate Siri Wave view properties
     */
    func initAudioView() {
        
        self.audioView?.density = 1.0
        self.audioView?.frequency = 1.5
        self.audioView?.amplitude = 0.0
        self.audioView?.idleAmplitude = 0.0
        self.audioView?.waveColor = UIColor.init(red: 60.0/255.0, green: 173.0/255.0, blue: 95.0/255.0, alpha: 1)
        self.audioView?.isHidden = true
    }
    
    /**
     Add Gesture Recoginizer for Single Tap to Text Search & Long Press to Voice Search
     */
    /* func  addGestureRecoginizer() {
     
     let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MainViewController.showTextSearchVC(_:)))
     let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(MainViewController.showVoiceSearchVC(_:)))
     tapGesture.numberOfTapsRequired = 1
     longGesture.minimumPressDuration = 0.2;
     microphoneButton.addGestureRecognizer(tapGesture)
     microphoneButton.addGestureRecognizer(longGesture)
     }*/
    
    /**
     Button Click event for Text's Search 'Cancel' button
     */
    @IBAction func textSearchCancelClicked(_ sender: Any) {
        self.siriManualTextView?.resignFirstResponder()
        self.showTextSearchVC(nil)
        // Bubble remove
        // self.animateTransitionForText(transitionMode: .dismiss)
        self.textSearchGoClicked(nil)
        
    }
    
    /**
     Button Click event for Text's Search 'GO' button
     */
    @IBAction func textSearchGoClicked(_ sender: Any?) {
        /**
         Checking Reachability validate the internet connection
         */
        if ReachabilityCheck.isConnectedToNetwork() == true {
            // print("Internet connection OK")
            if(self.siriManualTextView?.text == "") {
                return
            } else {
                EvaDataController.sharedInstance.showBackArrow = false
                self.hitDB(textView: self.siriManualTextView)
                DispatchQueue.main.async(execute: {
                    self.siriManualTextView?.resignFirstResponder()
                })
            }
            
        } else {
            // print("Internet connection FAILED")
            presentAlertWithTitle(title: CONNECTIVITY_ISSUE_TITLE, message: CONNECTIVITY_ISSUE_BODY)
        }
        
        
    }
    
}


extension MainViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
}


extension MainViewController {
    
    /**
     Show/Hide Text search view on Tap Gesture Recoginizer
     */
    @objc func showTextSearchVC(_ recognizer : UIGestureRecognizer?) {
        print("Tap happend")
        
        if self.siriManualView?.alpha == 0.0 {
            self.view.endEditing(true)
            self.siriVoiceView?.alpha = 0.0
            self.siriVoiceSubView?.alpha = 0.0
            UIView.animate(withDuration: 0.1, animations: {
                self.siriManualView?.alpha = 0.5
                self.siriManualSubView?.alpha = 0.5
            }, completion: { (finished: Bool) in
                self.siriManualTextView?.text = EMPTY_STRING
                self.siriManualTextView?.becomeFirstResponder()
                self.siriManualView?.alpha = 1.0
                self.siriManualSubView?.alpha = 1.0
            })
            
        } else if self.siriManualView?.alpha == 1.0 {
            self.view.endEditing(false)
            self.siriVoiceView?.alpha = 0.0
            self.siriVoiceSubView?.alpha = 0.0
            UIView.animate(withDuration: 0.1, animations: {
                self.siriManualView?.alpha = 0.2
                self.siriManualSubView?.alpha = 0.2
            }, completion: { (finished: Bool) in
                self.siriManualView?.alpha = 0.0
                self.siriManualSubView?.alpha = 0.0
            })
        }
    }
    
    /**
     Show/Hide Voice search view on Long Press Gesture Recoginizer
     */
    @objc func showVoiceSearchVC(_ recognizer : UIGestureRecognizer) {
        print("Long press check")
        
        // SpeechRecognizer permission allow check here
        // Todo: right now handled alert - replace to place holder text
        self.initSFSpeechRecognizer()
        
        if self.siriVoiceView?.alpha == 0.0 && (recognizer.state == UIGestureRecognizerState.began || recognizer.state == UIGestureRecognizerState.changed || recognizer.state == UIGestureRecognizerState.ended) {
            
            self.siriManualView?.alpha = 0.0
            self.siriManualSubView?.alpha = 0.0
            self.microphoneStatusChanged(isStart: true)
            UIView.animate(withDuration: 0.1, animations: {
                self.siriVoiceView?.alpha = 0.5
                self.siriVoiceSubView?.alpha = 0.5
            }, completion: { (finished: Bool) in
                self.siriVoiceView?.alpha = 1.0
                self.siriVoiceSubView?.alpha = 1.0
            })
            
        } else if self.siriVoiceView?.alpha ?? CGFloat(0.0) > CGFloat(0.0) && (recognizer.state == UIGestureRecognizerState.ended || recognizer.state == UIGestureRecognizerState.possible) {
            
            self.siriManualView?.alpha = 0.0
            self.siriManualSubView?.alpha = 0.0
            self.siriVoiceSubView?.alpha = 0.0
            self.microphoneStatusChanged(isStart: false)
            UIView.animate(withDuration: 0.1, animations: {
                self.siriVoiceView?.alpha = 0.2
                self.siriVoiceSubView?.alpha = 0.2
            }, completion: { (_) in
                self.siriVoiceView?.alpha = 0.0
                self.siriVoiceSubView?.alpha = 0.0
            })
        }
        
    }
    
    func animateVoiceSubview(startingPoint: CGPoint, originalCenter: CGPoint, isForward: Bool) {
        
        if isResetExecuted == true {
            return
        }
        if isForward {
            self.showHideVoiceSubview(isHidden: false)
            UIView.animate(withDuration: 0.3, animations: {
                self.siriVoiceSubView?.alpha = 1.0
            }, completion: { (finished: Bool) in
                if (finished && self.isResetExecuted == false) {
                    self.siriVoiceSubView?.alpha = 1.0
                    EvaDataController.sharedInstance.currentSearchType = .voice
                }
            })
        }
        else {
            UIView.animate(withDuration: 0.2, animations: {
                self.siriVoiceSubView?.alpha = 0.5
            }, completion: { (finished: Bool) in
                if (finished && self.isResetExecuted == false) {
                    self.siriVoiceSubView?.alpha = 0
                    EvaDataController.sharedInstance.currentSearchType = .none
                }
            })
        }
    }
    
    
    func animateTextSubview(startingPoint: CGPoint, originalCenter: CGPoint, isForward: Bool) {
        
        if isForward {
            UIView.animate(withDuration: 0.3, animations: {
                self.siriManualSubView?.alpha = 1.0
            }, completion: { (finished: Bool) in
                if (finished && self.isResetExecuted == false) {
                    self.siriManualSubView?.alpha = 1.0
                    self.siriManualTextView?.text = EMPTY_STRING
                    self.siriManualTextView?.becomeFirstResponder()
                    EvaDataController.sharedInstance.currentSearchType = .text
                }
            })
        }
        else {
            UIView.animate(withDuration: 0.2, animations: {
                self.siriManualSubView?.alpha = 0.5
            }, completion: { (finished: Bool) in
                if (finished && self.isResetExecuted == false) {
                    self.siriManualSubView?.alpha = 0
                    EvaDataController.sharedInstance.currentSearchType = .none
                }
            })
        }
    }
    
    /**
     Required by UIViewControllerAnimatedTransitioning
     */
    public func animateTransitionForVoice(transitionMode: TransitionMode = .present, recognizer : UIGestureRecognizer = UIGestureRecognizer()) {
        
        let startingPoint = microphoneButton.center
        
        if transitionMode == .present {
            isResetExecuted = false
            let originalCenter = self.view.center
            let originalSize = self.view.frame.size
            let frame = frameForBubble(originalCenter, size: originalSize, start: startingPoint)
            self.microphoneButton.isEnabled = false
            self.footerviewMicrophoneButton?.isEnabled = false
            
            self.siriVoiceView?.frame = frame
            siriVoiceView?.center = startingPoint
            siriVoiceView?.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            siriVoiceView?.backgroundColor = siriBGColor
            self.siriVoiceView?.alpha = 1
            siriVoiceView?.layer.cornerRadius = frame.size.height / 2
            let when = DispatchTime.now() + 0.3 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.animateVoiceSubview(startingPoint: startingPoint,originalCenter: originalCenter, isForward: true)
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                self.siriVoiceView?.transform = CGAffineTransform.identity
                self.siriVoiceView?.frame = frame
                self.siriVoiceView?.center = originalCenter
            }, completion: { (finished: Bool) in
                if (finished && self.isResetExecuted == false) {
                    self.siriVoiceView?.frame = self.view.frame
                    self.siriVoiceView?.layer.cornerRadius = 0.0
                    self.microphoneButton.isEnabled = true
                    self.footerviewMicrophoneButton?.isEnabled = true
                    print("UIGestureRecognizerState.began fresh microphoneTapped start \(finished)")
                    self.microphoneTapped(recognizer)
                }
            })
            return
        } else if transitionMode == .dismiss {
            let originalCenter = microphoneButton.center
            let originalSize = microphoneButton.frame.size
            let frame = frameForBubble(originalCenter, size: originalSize, start: startingPoint)
            
            self.microphoneButton.isEnabled = false
            self.footerviewMicrophoneButton?.isEnabled = false
            
            siriVoiceView?.frame = frame
            siriVoiceView?.layer.cornerRadius = frame.size.height / 2
            siriVoiceView?.center = startingPoint
            self.animateVoiceSubview(startingPoint: startingPoint, originalCenter: originalCenter, isForward: false)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.siriVoiceView?.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                self.siriVoiceView?.center = startingPoint
            }, completion: { (finished: Bool) in
                if (finished && self.isResetExecuted == false) {
                    self.siriVoiceView?.transform = CGAffineTransform.identity
                    self.siriVoiceView?.alpha = 0
                    self.siriVoiceSubView?.alpha = 0
                    self.siriVoiceView?.center = originalCenter
                    self.siriVoiceView?.frame = self.microphoneButton.frame
                    self.microphoneButton.isEnabled = true
                    self.footerviewMicrophoneButton?.isEnabled = true
                    print("UIGestureRecognizerState.began fresh microphoneTapped dismiss \(finished)")
                }
            })
        }
    }
    
    func resetManualVoice() {
        print("resetManualVoice called")
        isResetExecuted = true
        self.siriVoiceView?.transform = CGAffineTransform.identity
        let originalCenter = microphoneButton.center
        self.siriVoiceView?.alpha = 0
        self.siriVoiceView?.center = originalCenter
        self.siriVoiceView?.frame = self.microphoneButton.frame
        self.microphoneButton.isEnabled = true
        self.footerviewMicrophoneButton?.isEnabled = true
        self.siriVoiceSubView?.alpha = 0
        self.showHideVoiceSubview(isHidden: true)
    }
    
    func showHideVoiceSubview(isHidden: Bool) {
        //        let array = self.siriVoiceSubView?.subviews ?? []
        //        for view in array {
        //            view.isHidden = isHidden
        //        }
    }
    public func animateTransitionForText(transitionMode: TransitionMode = .present) {
        
        
        let startingPoint = microphoneButton.center
        
        if transitionMode == .present {
            isResetExecuted = false
            let originalCenter = self.view.center
            let originalSize = self.view.frame.size
            let frame = frameForBubble(originalCenter, size: originalSize, start: startingPoint)
            
            if self.siriManualView?.alpha == 0.0 {
                self.siriManualView?.frame = frame
                siriManualView?.layer.cornerRadius = frame.size.height / 2
                siriManualView?.center = startingPoint
                self.siriManualTextView?.text = EMPTY_STRING
                siriManualView?.backgroundColor = siriBGColor
                siriManualView?.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                self.siriManualView?.alpha = 1
                self.microphoneButton.isEnabled = false
                self.footerviewMicrophoneButton?.isEnabled = false
                
                let when = DispatchTime.now() + 0.3 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.animateTextSubview(startingPoint: startingPoint,originalCenter: originalCenter, isForward: true)
                }
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.siriManualView?.transform = CGAffineTransform.identity
                    self.siriManualView?.frame = frame
                    self.siriManualView?.center = originalCenter
                }, completion: { (finished: Bool) in
                    if finished {
                        self.microphoneButton.isEnabled = true
                        self.footerviewMicrophoneButton?.isEnabled = true
                        self.siriManualView?.frame = self.view.frame
                        self.siriManualView?.layer.cornerRadius = 0.0
                    }
                })
                return
            }
        } else if transitionMode == .dismiss {
            let originalCenter = microphoneButton.center
            let originalSize = microphoneButton.frame.size
            let frame = frameForBubble(originalCenter, size: originalSize, start: startingPoint)
            
            siriManualView?.frame = frame
            siriManualView?.layer.cornerRadius = frame.size.height / 2
            siriManualView?.center = startingPoint
            self.microphoneButton.isEnabled = false
            self.footerviewMicrophoneButton?.isEnabled = false
            self.animateTextSubview(startingPoint: startingPoint, originalCenter: originalCenter, isForward: false)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.siriManualView?.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                self.siriManualView?.center = startingPoint
                
            }, completion: { (finished: Bool) in
                if finished {
                    self.siriManualView?.transform = CGAffineTransform.identity
                    self.siriManualView?.alpha = 0
                    self.siriManualView?.center = originalCenter
                    self.siriManualView?.frame = self.microphoneButton.frame
                    self.microphoneButton.isEnabled = true
                    self.footerviewMicrophoneButton?.isEnabled = true
                }
            })
        }
    }
    
    func resetManualText() {
        self.siriManualView?.transform = CGAffineTransform.identity
        let originalCenter = microphoneButton.center
        self.siriManualView?.alpha = 0
        self.siriManualView?.center = originalCenter
        self.siriManualView?.frame = self.microphoneButton.frame
        self.microphoneButton.isEnabled = true
        self.footerviewMicrophoneButton?.isEnabled = true
        self.siriManualSubView?.alpha = 0
    }
    
    func frameForBubble(_ originalCenter: CGPoint, size originalSize: CGSize, start: CGPoint) -> CGRect {
        
        let lengthX = fmax(start.x, originalSize.width - start.x)
        let lengthY = fmax(start.y, originalSize.height - start.y)
        let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
        let size = CGSize(width: offset, height: offset)
        return CGRect(origin: CGPoint.zero, size: size)
    }
    
    
    func microphoneTapped(_ recognizer : UIGestureRecognizer) {
        print("Inside Microphone Block \(recognizer.state.rawValue)")
        //        if isResetExecuted == true {
        //            isResetExecuted = false
        //            return
        //        }
        if recognizer.state == UIGestureRecognizerState.ended {
            if audioEngine.isRunning { audioEngine.stop(); recognitionRequest?.endAudio() }
            microphoneButton?.setTitle("Start Recording", for: .normal)
            print("Microphone  StopRecording")
            
            if let runningTimer = timer, runningTimer.isValid {
                self.audioView?.isHidden = true
                runningTimer.invalidate()
            }
            // self.hitDB(textView: self.textView, queryType: QueryType.voiceSearch)
        } else if recognizer.state == UIGestureRecognizerState.began  {
            startRecording()
            print("Microphone startRecording")
            if let runningTimer = timer, runningTimer.isValid { runningTimer.invalidate() }
            timer = Timer.scheduledTimer(timeInterval: 0.009, target: self, selector: #selector(MainViewController.refreshAudioView(_:)), userInfo: nil, repeats: true)
            microphoneButton?.setTitle("Stop Recording", for: .normal)
            self.audioView?.isHidden = false
            height = 0.3
            self.audioView?.amplitude = 0.0
        } else if recognizer.state == UIGestureRecognizerState.changed || recognizer.state == UIGestureRecognizerState.possible {
            // self.microphoneChanged()
        }
    }
    
    func microphoneStatusChanged(isStart: Bool) {
        //stop
        if isStart == false {
            if audioEngine.isRunning { audioEngine.stop(); recognitionRequest?.endAudio() }
            microphoneButton?.setTitle("Start Recording", for: .normal)
            print("UIGestureRecognizerState.began fresh microphoneTapped  StopRecording")
            
            // Siri Crash Fix - TODO : test it on device
            audioEngine.inputNode.removeTap(onBus: 0)
            
            if let runningTimer = timer, runningTimer.isValid {
                self.audioView?.isHidden = true
                runningTimer.invalidate()
            }
        } else  {
            startRecording()
            print("UIGestureRecognizerState.began fresh microphoneTapped startRecording")
            if let runningTimer = timer, runningTimer.isValid { runningTimer.invalidate() }
            timer = Timer.scheduledTimer(timeInterval: 0.009, target: self, selector: #selector(MainViewController.refreshAudioView(_:)), userInfo: nil, repeats: true)
            microphoneButton?.setTitle("Stop Recording", for: .normal)
            self.audioView?.isHidden = false
            height = 0.3
            self.audioView?.amplitude = 0.0
        }
    }
    
    @objc internal func refreshAudioView(_:Timer) {
        if self.audioView?.amplitude ?? 0.0 <= self.audioView?.idleAmplitude ?? 0.0 || self.audioView?.amplitude ?? 0.0 > height {
            self.change *= -1.0
        }
        // Simply set the amplitude to whatever you need and the view will update itself.
        self.audioView?.amplitude += self.change
        
        if self.audioView?.amplitude == 0.0 {
            let tuple = EvaUtils.getWaveHeight(count: count)
            height = tuple.0
            count = tuple.1
        }
    }
    
    
    func startRecording() {
        
        if recognitionTask != nil {  //1
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()  //3
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        } //5
        
        recognitionRequest.shouldReportPartialResults = true  //6
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in  //7
            
            var isFinal = false  //8
            
            if result != nil {
                self.textView?.text = result?.bestTranscription.formattedString  //9
                self.textView?.isHidden = true
                self.siriSearchTextLabel?.isHidden = false
                self.siriSearchTextLabel?.text = self.textView?.text
                isFinal = (result?.isFinal)!
                if isFinal {
                    EvaDataController.sharedInstance.showBackArrow = false
                    self.hitDB(textView: self.textView, queryType: QueryType.voiceSearch)
                }
            }
            
            if error != nil || isFinal {  //10
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                // print("audioEngine end \(self.height).")
                self.microphoneButton?.isEnabled = true
                self.footerviewMicrophoneButton?.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)  //11
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()  //12
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        height = 0.2
        self.textView?.isHidden = false
        self.siriSearchTextLabel?.isHidden = true
        textView?.text = "Say something, I am listening"
        
    }
    
    @objc func flyingLabelTapped(_ recognizer : UIGestureRecognizer) {
        
        if let tappedlabel = recognizer.view as? UILabel {
            print("tappedlabel==",tappedlabel)
            
            self.textView?.isHidden = true
            let _textView = UITextView()
            _textView.text = tappedlabel.text
            EvaDataController.sharedInstance.showBackArrow = true
            self.hitDB(textView: _textView, queryType: QueryType.voiceSearch)
        }
    }
    
    func hitDB(textView: UITextView?, queryType: QueryType = .textSearch) {
        
        var output = ("", [String: Any]())
        var queryString = textView?.text ?? EMPTY_STRING
        self.showActivityView()
        
        let delayTime = DispatchTime.now() + .milliseconds(2)//+ Double(0.001)
        DispatchQueue.main.asyncAfter(deadline: delayTime)
        {
            print(queryString)
            queryString = queryString.replacingOccurrences(of:"\'", with: "", options:.literal, range: nil)
            output = EvaUtils.fetchFromDB(queryString: queryString, queryType: queryType, vc: self)
            textView?.text = ""
            self.hideActivityView()
            self.pushToTransactionDetails(responseString: output.1)
            
            // Polly Voice should come only for Siri search
            if queryType == .voiceSearch {
                DispatchQueue.main.async(execute: {
                    if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
                        appdelegate.convertInputToVoice(queryString: output.0)
                        
                    }
                })
            }
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
        
        let displayType: DisplayType? = EvaDataController.sharedInstance.currentDisplayType
        switch displayType ?? .messageWithChart {
        case .messageWithTransaction:
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransactionsResultViewController") as? TransactionsResultViewController {
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                } else if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.nvc?.pushViewController(viewController, animated: true)
                }
            }
            
        case .message, .messageWithChart, .messageWithPieChart:
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MessageTypeViewController") as? MessageTypeViewController {
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                } else if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.nvc?.pushViewController(viewController, animated: true)
                }
            }
        }
            
        let order_value : Int? = EvaDataController.sharedInstance.transactionResponse?.transactionsHeader?.order_value
        let discount_percent : Int? = EvaDataController.sharedInstance.transactionResponse?.transactionsHeader?.discount_percent
        if let order = order_value, let discount = discount_percent, order > 0  {
            WebserviceManager.sharedManager.createOrders(order_value: order, discount_percent: discount)
        }
    }
    
    public func reset() {
        if EvaDataController.sharedInstance.currentSearchType == .text {
            self.resetManualText()
        } else if EvaDataController.sharedInstance.currentSearchType == .voice {
            self.resetManualVoice()
        } else {
            self.resetManualText()
            self.resetManualVoice()
        }
    }
}


extension MainViewController: SFSpeechRecognizerDelegate {
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            microphoneButton?.isEnabled = true
            self.footerviewMicrophoneButton?.isEnabled = true
        } else {
            microphoneButton?.isEnabled = false
            self.footerviewMicrophoneButton?.isEnabled = false
        }
    }
}

extension MainViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            EvaDataController.sharedInstance.showBackArrow = false
            // Textview validation added
            if(self.siriManualTextView?.text == "") {
                return false
            } else {
                self.hitDB(textView: self.siriManualTextView)
                DispatchQueue.main.async(execute: {
                    textView.resignFirstResponder();
                })
                
            }
            return false
        }
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = EMPTY_STRING
    }
    
    func textViewDidChange(_ textView: UITextView){
        
        siriPlaceholderLabel?.isHidden = !textView.text.isEmpty
        self.resizeTextView(textView: textView)
        // textView.frame = newFrame;
    }
    
    func resizeTextView(textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        if newFrame.size.height > 200.0 {
            return
        }
        newFrame.size.height += 10.0
        
        UIView.animate(withDuration: 0.5, animations: {
            if newFrame.height > textView.frame.size.height {
                newFrame.origin.y = newFrame.origin.y + (textView.frame.size.height - newFrame.height)
            }
            else if newFrame.height < textView.frame.size.height {
                newFrame.origin.y = newFrame.origin.y + (textView.frame.size.height - newFrame.height)
            }
            
            textView.frame = newFrame;
        }, completion: { (_) in
        })
    }
    
    
    func getfooterview() {
        if footerview == nil {
            footerview = self.slideMenuController()?.view.viewWithTag(1000)
            if let microphoneBtn = footerview?.viewWithTag(2) as? UIButton {
                footerviewMicrophoneButton = microphoneBtn
            }
        }
    }
    
}

