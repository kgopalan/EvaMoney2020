//
//  String.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
    var length: Int {
        return self.characters.count
    }
    
//    var htmlAttributedString: NSAttributedString? {
//
//        do {
//            return try NSAttributedString(data: data(using: .utf8)!, options: [NSAttributedString.DocumentReadingOptionKey.Type: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        return nil
//    }
}


var activityIndicatorView : UIView?
var alphaView: UIView?
var menuVuewHeight = CGFloat(87.0)
var speakerButton : UIButton?
var speakerBtnSize = CGFloat(40.0)
var speakerViewYPadding = CGFloat(520.0)
var speakerViewXPadding = CGFloat(50.0)


extension UIViewController {
    /*
     Display Alert
     */
    func presentAlertWithTitle(title: String, message : String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in print("Youve pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAlertWithTitle(title: String, message : String, vc: UIViewController?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in
            print("Youve pressed OK Button")
            if let controller = vc as? InitialViewController {
                controller.beginEditing()
            }
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func setNavigationBarItem() {
        
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.addLeftGestures()
    }
    
    func menuSubViewAddToVC() -> UIView {
        // TODO:: set menu height
        print("self.view.frame.width ===",self.view.frame.height)
        let menuView=UIView(frame:CGRect(x: 0, y: (self.view.frame.size.height - menuVuewHeight), width: self.view.frame.width, height: menuVuewHeight))
        menuView.tag = 1000
        menuView.addSubview(self.createMenuView()!)
        return menuView
        
    }
    
    func removeNavigationBarItem() {
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
    }
    
    @objc class func application() -> UIApplication {
        return UIApplication.shared
    }
    
    @objc class func appDelegate() -> AppDelegate {
        return application().delegate as! AppDelegate
    }
    
    /**
     Get the app main window
     */
    @objc class func mainWindow() -> UIWindow? {
        return appDelegate().window
    }
    
    
    /**
     Displays an Activity Indicator to show loading
     */
    func showActivityView(_ citify: Bool = false) {
        UIApplication.shared.statusBarView?.backgroundColor = .clear
        let appWindow = UIViewController.mainWindow()!
        activityIndicatorView = activityIndicatorView ?? self.createActivityView()
        alphaView = alphaView ?? self.createAlphaView(citify)
        
        if citify {
            alphaView?.citify()
            alphaView?.alpha = 1.0
        } else {
            alphaView?.unCitify()
            alphaView?.alpha = 0.2
        }
        
        appWindow.addSubview(alphaView ?? UIView())
        appWindow.addSubview(activityIndicatorView ?? UIView())
        appWindow.isUserInteractionEnabled = false
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, activityIndicatorView)
    }
    
    /**
     Hide the Activity Indicator
     */
    func hideActivityView() {
        DispatchQueue.main.async(execute: { () -> Void in
            let appWindow = UIViewController.mainWindow()!
            appWindow.isUserInteractionEnabled = true
            activityIndicatorView?.removeFromSuperview()
            alphaView?.removeFromSuperview()
        })
    }
    
    /**
     Creates the activity indicator view
     */
    func createActivityView() -> UIView {
        let appWindow = UIViewController.mainWindow()!
        let activityHolderWidthHeight : CGFloat = 80.0
        
        let activityView = UIView(frame: CGRect(x: 0, y: 0, width: activityHolderWidthHeight, height: activityHolderWidthHeight))
        activityView.center = appWindow.center
        activityView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        activityView.layer.cornerRadius = 8.0
        
        let activityIndicatorWidthHeight : CGFloat = 45
        let centerPoint = CGPoint(x: activityView.bounds.midX, y: activityView.bounds.midY)
        
        let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: activityIndicatorWidthHeight, height: activityIndicatorWidthHeight)
        activityIndicator.center = centerPoint
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.startAnimating()
        activityView.addSubview(activityIndicator)
        
        return activityView
    }
    
    
    func createAlphaView (_ citify: Bool = false) -> UIView {
        let alphaView = UIView(frame: UIScreen.main.bounds)
        alphaView.backgroundColor = UIColor.black
        alphaView.alpha = 0.2
        return alphaView
    }
    
}



extension UIApplication {
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
        if let slide = viewController as? SlideMenuController {
            return topViewController(slide.mainViewController)
        }
        return viewController
    }
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}


public extension UITableView {
    
    func registerCellClass(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        self.register(cellClass, forCellReuseIdentifier: identifier)
    }
}


extension UIView {
    class func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String.className(viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    
    class func loadNib() -> Self {
        return loadNib(self)
    }
    
    func citify() {
        
        if let sublayers = self.layer.sublayers {
            for sublayer in sublayers {
                if sublayer is CBMCitiGradientLayer {
                    return
                }
            }
        }
        
        let myGradientLayer = CBMCitiGradientLayer()
        myGradientLayer.frame = UIScreen.main.bounds //self.bounds
        
        let gradientStops = [0.0 as NSNumber, 0.2 as NSNumber, 0.75 as NSNumber, 1.0 as NSNumber]
        let startColor = UIColor(red: 0, green: 189.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        let secondColor = UIColor(red: 0, green: 179.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        let thirdColor = UIColor(red: 0, green: 102.0/255.0, blue: 179.0/255.0, alpha: 1.0)
        let finalColor = UIColor(red: 0, green: 71.0/255.0, blue: 133.0/255.0, alpha: 1.0)
        
        let gradientColors = [startColor.cgColor, secondColor.cgColor, thirdColor.cgColor, finalColor.cgColor]
        
        myGradientLayer.locations = gradientStops
        myGradientLayer.colors = gradientColors
        self.layer.insertSublayer(myGradientLayer, at: 0)
    }
    
    func unCitify() {
        if let sublayers = self.layer.sublayers {
            var citiLayer: CBMCitiGradientLayer? = nil
            for sublayer in sublayers {
                if let c = sublayer as? CBMCitiGradientLayer {
                    citiLayer = c
                    break
                }
            }
            citiLayer?.removeFromSuperlayer()
        }
    }
}

class CBMCitiGradientLayer : CAGradientLayer {
    
}
