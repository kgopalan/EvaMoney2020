//
//  AppDelegate.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit
import CloverConnector_Hackathon_2017
import AWSPolly
import Speech

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var cloverConnector:ICloverGoConnector?
    public var cloverConnectorListener:CloverGoConnectorListener?

    /*
     * Application Main Window Variable Instance
     */
    var window: UIWindow?
    
    /*
     * Application Navigation Variable Instance
     */
    var nvc: UINavigationController?
    
    /*
     * Slide Menu View Controller Variable Instance
     */
    var slideMenuController: ExSlideMenuController?
    
    /*
     * Login initial View Controller Variable Instance
     */
    var initialViewController: InitialViewController?
    
    /*
     * Application main View Controller Variable Instance
     */
    var mainViewController: MainViewController?
    
    /*
     * Left View Controller Variable Instance
     */
    var leftViewController: LeftViewController?
    
    //AWS Polly
    /*
     * Login screen video player Variable Instance
     */
    var audioPlayer = AVPlayer()
    
    /*
     * AWS Polly VoiceId Instance
     */
    var selectedVoice: AWSPollyVoiceId?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        self.setNavigationBar()
        
        /*
         * login Screen Initialisation
         */
        initialViewController = storyboard.instantiateViewController(withIdentifier: "InitialViewController") as? InitialViewController
        
        /*
         * Application Main View Controller Initialisation
         */
        mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
        
        /*
         * Application Left Menu View Controller Initialisation
         */
        leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as? LeftViewController
        
        /*
         * Application Navigation Controller Initialisation
         */
        nvc = UINavigationController(rootViewController: initialViewController ?? InitialViewController())
        leftViewController?.mainViewController = nvc
        
        /*
         * Set Slide Menu Controller as rootViewController
         */
        slideMenuController = ExSlideMenuController(mainViewController:nvc ?? UINavigationController() , leftMenuViewController: leftViewController ?? UIViewController())
        slideMenuController?.automaticallyAdjustsScrollViewInsets = true
        slideMenuController?.delegate = mainViewController
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
        
        /*
         * Initialize Background Tasks
         */
        self.initBackgroundTasks()
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    fileprivate func setNavigationBar() {
        //Navigation bar is not required
        UIApplication.shared.statusBarStyle = .default
        UINavigationBar.appearance().tintColor = UIColor(hex: "689F38")
        nvc?.navigationBar.isHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    /**
     Init Background Tasks for initial setups.
     
     - parameter key: nil.
     - returns: nil.
     */
    
    fileprivate func initBackgroundTasks() {
        
        DispatchQueue.main.async(execute: {
            self.initAWSPolly()
        })
        self.initializeMerchant()
    }
    
    
    /**
     Init AWS Polly API and get the list of available voice.
     
     - parameter key: nil.
     - returns: nil.
     */
    
    func initAWSPolly() {
        
        let audioSession = AVAudioSession.sharedInstance()  //2
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with:[AVAudioSessionCategoryOptions.allowBluetooth, .allowBluetoothA2DP])
            
            do { try audioSession.setActive(true)
                print("setActive")
            } catch {
                print(error)
            }
            
            if EvaUtils.isHeadphonesPluggedIn() == false {
                try audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
            } else {
                try audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.none)
            }
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        let task = AWSPolly.default().describeVoices(AWSPollyDescribeVoicesInput())
        task.continueOnSuccessWith { (awsTask: AWSTask<AWSPollyDescribeVoicesOutput>?) -> Any? in
            guard let resultOutput = awsTask?.result, let _ = resultOutput.voices else {
                return nil
            }
            self.selectedVoice = AWSPollyVoiceId.joanna
            return nil
        }
    }
    
    
    /**
     AWS Polly API converts the input query string into selected voice over content.
     
     - parameter key: query string.
     - returns: selected voice over content.
     */
    func convertInputToVoice(queryString: String) {
        if EvaDataController.sharedInstance.currentUser.voice_response.lowercased() != "true" {
            return
        }
        
        let input = AWSPollySynthesizeSpeechURLBuilderRequest()
        input.text = queryString
        input.outputFormat = AWSPollyOutputFormat.mp3
        input.voiceId = AWSPollyVoiceId.joanna
        let builder = AWSPollySynthesizeSpeechURLBuilder.default().getPreSignedURL(input)
        builder.continueOnSuccessWith { (awsTask: AWSTask<NSURL>) -> Any? in
            let url = awsTask.result!
            self.audioPlayer.replaceCurrentItem(with: AVPlayerItem(url: url as URL))
            self.audioPlayer.volume = 1
            self.audioPlayer.play()
            return nil
        }
    }
    

    func initializeMerchant() {
        let user: User? = User.empty()
        EvaDataController.sharedInstance.currentUser = user?.userInfo ?? UserInfo.empty()
        EvaDataController.sharedInstance.currentUser.user_Id = "1"
        EvaDataController.sharedInstance.currentUser.user_nickname = "Krishnan"
        EvaDataController.sharedInstance.currentUser.email = "hackathon0427@sharklasers.com"
        EvaDataController.sharedInstance.currentUser.password = "Money2020"
        EvaDataController.sharedInstance.currentUser.touch_setting_enabled = "true"
        EvaDataController.sharedInstance.currentUser.voice_response = "true"
    }

}

