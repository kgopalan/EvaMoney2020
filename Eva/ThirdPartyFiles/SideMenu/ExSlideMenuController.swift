//
//  ExSlideMenuController.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit

class ExSlideMenuController: SlideMenuController {
    
    var footerview :UIView?
    
    override func isTagetViewController() -> Bool {
        if let vc = UIApplication.topViewController() {
            if vc is MainViewController ||
                vc is RecentSearchesViewController ||
                vc is SettingsViewController {
                return true
            }
        }
        return false
    }
    
    override func track(_ trackAction: TrackAction) {
        switch trackAction {
        case .leftTapOpen:
            print("TrackAction: left tap open.")
        case .leftTapClose:
            print("TrackAction: left tap close.")
        case .leftFlickOpen:
            print("TrackAction: left flick open.")
        case .leftFlickClose:
            print("TrackAction: left flick close.")
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
}

extension UIViewController {
    
    
    func slideMenuController() -> SlideMenuController? {
        
        
        var viewController: UIViewController? = self
        while viewController != nil {
            if viewController is SlideMenuController {
                return viewController as? SlideMenuController
            }
            viewController = viewController?.parent
        }
        return nil
    }
    
    // Single Tap to Text Search & Long Press to Voice Search
    
    // jsust for testing added.
    
    /*  func  addGestureRecoginizer() {
     let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MainViewController.showTextSearchVC(_:)))
     let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(MainViewController.showVoiceSearchVC(_:)))
     tapGesture.numberOfTapsRequired = 1
     longGesture.minimumPressDuration = 0.2;
     // Testing - addGestureRecognizer on microPhoneButton and test..
     self.view.addGestureRecognizer(tapGesture)
     self.view.addGestureRecognizer(longGesture)
     }*/
    
    
    public func addLeftBarButtonWithImage(_ buttonImage: UIImage) {
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.toggleLeft))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    func createMenuView() -> UIView? {
        
        let menuView=UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: menuVuewHeight))
        // menuView.layer.borderColor = UIColor.init(red: 41.0/255.0, green: 104.0/255.0, blue: 150.0/255.0, alpha: 1).cgColor
        // menuView.layer.borderWidth = 1.0
        menuView.backgroundColor = UIColor.clear
        self.view.addSubview(menuView)
        
        // TODO: Remove Hardcored width.height - once View animation is and UI Ready
        let menuSize = 47
        let leadTrailSpace = 16
        let menuButton:UIButton = UIButton(frame: CGRect(x: leadTrailSpace, y: 14, width: menuSize, height: menuSize))
        menuButton.setBackgroundImage(UIImage.init(named: "Menu"), for: .normal)
        menuButton.addTarget(self, action:#selector(self.menuButtonClicked), for: .touchUpInside)
        menuButton.tag = 1
        menuView.addSubview(menuButton)
        
        // TODO: Remove Hardcored width.height - once View animation is and UI Ready
        let buttonSize = 65
        let microPhoneButton:UIButton? = UIButton(frame: CGRect(x: Int((self.view.frame.width/2) - CGFloat(buttonSize/2)), y: 0, width: buttonSize, height: buttonSize))
        // microPhoneButton?.backgroundColor = .white
        microPhoneButton?.setBackgroundImage(UIImage.init(named: "SiriRecord"), for: .normal)
        
        microPhoneButton?.setTitle("", for: .normal)
        menuView.addSubview(microPhoneButton ?? UIButton())
        //microPhoneButton?.layer.cornerRadius = (CGFloat(buttonSize)/2)
        //microPhoneButton?.layer.borderWidth = 4.0
        microPhoneButton?.tag = 2
        //microPhoneButton?.layer.borderColor = UIColor.init(red: 41.0/255.0, green: 104.0/255.0, blue: 150.0/255.0, alpha: 1).cgColor
        self.addGestureRecoginizer(microPhoneButton: microPhoneButton ?? UIButton())
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let disclaimerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 18))
        disclaimerLabel.center = CGPoint(x: Int(self.view.frame.width/2), y: Int(microPhoneButton?.frame.size.height ?? 0) + 10)
        disclaimerLabel.font = UIFont(name:"HelveticaNeue", size:13.0)
        disclaimerLabel.textAlignment = .center
        disclaimerLabel.text = "Hold to speak"
        disclaimerLabel.textColor = UIColor.init(red: 60.0/255.0, green: 173.0/255.0, blue: 95.0/255.0, alpha: 1)
        disclaimerLabel.tag = 3
        menuView.addSubview(disclaimerLabel)
        disclaimerLabel.isUserInteractionEnabled = true
        
        let textSearchButton:UIButton = UIButton(frame: CGRect(x: Int(menuView.frame.size.width - CGFloat(menuSize + leadTrailSpace)), y: 14, width: menuSize , height: menuSize))
        textSearchButton.setBackgroundImage(UIImage.init(named: "Type"), for: .normal)
        // textSearchButton.addTarget(self, action:#selector(self.textSearchClicked), for: .touchUpInside)
        textSearchButton.tag = 4
        self.addTapGestureRecoginizer(textSearchButton: textSearchButton ?? UIButton())
        menuView.addSubview(textSearchButton)
        
        return menuView;
        
        
    }
    //Bubble remove
    // Single Tap to Text Search & Long Press to Voice Search
    func  addGestureRecoginizer(microPhoneButton: UIButton) {
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MainViewController.showTextSearchVC(_:)))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(MainViewController.showVoiceSearchVC(_:)))
        //tapGesture.numberOfTapsRequired = 1
        longGesture.minimumPressDuration = 0.2;
        // microPhoneButton.addGestureRecognizer(tapGesture)
        microPhoneButton.addGestureRecognizer(longGesture)
    }
    
    func  addTapGestureRecoginizer(textSearchButton: UIButton) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MainViewController.showTextSearchVC(_:)))
        tapGesture.numberOfTapsRequired = 1
        textSearchButton.addGestureRecognizer(tapGesture)
    }
    
    @objc public func menuButtonClicked() {
        slideMenuController()?.toggleLeft()
    }
    
    @objc public func toggleLeft() {
        slideMenuController()?.toggleLeft()
    }
    
    @objc public func openLeft() {
        slideMenuController()?.openLeft()
    }
    
    @objc public func closeLeft() {
        slideMenuController()?.closeLeft()
    }
    
    // Please specify if you want menu gesuture give priority to than targetScrollView
    public func addPriorityToMenuGesuture(_ targetScrollView: UIScrollView) {
        guard let slideController = slideMenuController(), let recognizers = slideController.view.gestureRecognizers else {
            return
        }
        for recognizer in recognizers where recognizer is UIPanGestureRecognizer {
            targetScrollView.panGestureRecognizer.require(toFail: recognizer)
        }
    }
}

