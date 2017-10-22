//
//  SiriContentView.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit

class SiriContentView: UIView {
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var headerLabel: UILabel?
    
    @IBOutlet weak var firstInfoLabel: UILabel?
    @IBOutlet weak var secondInfoLabel: UILabel?
    @IBOutlet weak var thirdInfoLabel: UILabel?
    @IBOutlet weak var fourthInfoLabel: UILabel?
    @IBOutlet weak var fifthInfoLabel: UILabel?
    @IBOutlet weak var sixthInfoLabel: UILabel?
    
    @IBOutlet weak var firstLblTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondLblTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdLblTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var fourthLblTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var fifthLblTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var sixthLblTopConstraint: NSLayoutConstraint!
    
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    //Animation related
    var infoBasearray = [[UILabel]]()
    var infoLabelarray1 = [UILabel]()
    var infoLabelarray2 = [UILabel]()
    var infoLabelarray3 = [UILabel]()
    
    var baseCounter = 0
    var showCounter = 0
    var hideCounter = 0
    
    var infoLabelPositionarray = [240, 307, 353, 420, 466, 512]
    var showTimer = Timer()
    var hideTimer = Timer()
    var baseTimer = Timer()
    
    var isResetExecuted = false
    
    init?(frame: CGRect, message: String) {
        super.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setProperties() {
        
        isResetExecuted = false
        baseCounter = 0
        hideCounter = 0
                
        infoBasearray.removeAll()
        
        self.firstInfoLabel?.text = ""
        
        self.animatedLabelFrameAdjust()
        
        self.firstInfoLabel?.attributedText = EvaUtils.formatPoint18Text(text: "Hows the sales today?")
        self.secondInfoLabel?.attributedText = EvaUtils.formatPoint18Text(text: "Show me the revenue for the last six months")
        self.thirdInfoLabel?.attributedText = EvaUtils.formatPoint18Text(text: "Show me a breakup of sales by order type")
        self.fourthInfoLabel?.attributedText = EvaUtils.formatPoint18Text(text: "Show me a breakup of sales my payment type")
        self.fifthInfoLabel?.attributedText = EvaUtils.formatPoint18Text(text: "")
        self.sixthInfoLabel?.attributedText = EvaUtils.formatPoint18Text(text: "")
        
        
        infoLabelarray1 = [self.firstInfoLabel ?? UILabel(), self.secondInfoLabel ?? UILabel(), self.thirdInfoLabel ?? UILabel(), self.fourthInfoLabel ?? UILabel(), self.fifthInfoLabel ?? UILabel(), self.sixthInfoLabel ?? UILabel()];
        infoLabelarray2 = [self.firstInfoLabel ?? UILabel(), self.secondInfoLabel ?? UILabel(), self.thirdInfoLabel ?? UILabel(), self.fourthInfoLabel ?? UILabel(), self.fifthInfoLabel ?? UILabel(), self.sixthInfoLabel ?? UILabel()];
        infoLabelarray3 = [self.firstInfoLabel ?? UILabel(), self.secondInfoLabel ?? UILabel(), self.thirdInfoLabel ?? UILabel(), self.fourthInfoLabel ?? UILabel(), self.fifthInfoLabel ?? UILabel(), self.sixthInfoLabel ?? UILabel()];
        
        infoBasearray = [infoLabelarray1, infoLabelarray2, infoLabelarray3]
        
        self.animateBoard()
        baseTimer = Timer.scheduledTimer(timeInterval: 13.8, target: self, selector: #selector(animateBoard), userInfo: nil, repeats: true)
        
    }
    
    func setLayoutProperties() {
        
        self.invalidateAllTimer()
        
        self.setProperties()
    }
    
    
    func animatedLabelFrameAdjust()  {
        switch UIDevice().screenType {
        case .iPhone4, .iPhone5:
            // Code for iPhone 4 & iPhone 5
            firstLblTopConstraint.constant = animatedLblConstraintsSetiPhone5
            secondLblTopConstraint.constant = animatedLblConstraintsSetiPhone5
            thirdLblTopConstraint.constant = animatedLblConstraintsSetiPhone5
            fourthLblTopConstraint.constant = animatedLblConstraintsSetiPhone5
            fifthLblTopConstraint.constant = animatedLblConstraintsSetiPhone5
            sixthLblTopConstraint.constant = animatedLblConstraintsSetiPhone5
            break
        default:
            break
        }
    }
    //Animation related
    
    /*
     Trigger timer to animate the Thumbs up image
     */
    @objc func animateBoard() {
        self.invalidateTimer()
        if baseCounter >= infoBasearray.count {
            baseCounter = 0
        }
        let array = infoBasearray[baseCounter]
        
        var count = 0
        for label in array {
            label.isHidden = false
            label.alpha = 0.0
            count += 1
        }
        baseCounter += 1
        
        if !showTimer.isValid {
            showCounter = 0
            showTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(showAction(timer:)), userInfo: ["array" :array], repeats: true)
        }
        let delayInSeconds = 12.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            if !self.hideTimer.isValid {
                self.hideCounter = 0
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.hideAction(timer:)), userInfo: ["array" :array], repeats: true)
            }
        }
    }
    
    
    @objc func showAction(timer: Timer) {
        if !self.showTimer.isValid || isResetExecuted {
            return
        }
        if let userInfo = timer.userInfo as? Dictionary<String, AnyObject>, let infoLabelarray = (userInfo["array"] as? Array<UILabel>), infoLabelarray.count > 0 {
            if showCounter < infoLabelarray.count {
                let label = infoLabelarray[showCounter]
                self.showLabel(label : label, counter: showCounter)
                showCounter += 1
            }
            else {
                self.invalidateTimer()
            }
        }
    }
    
    func showLabel(label : UILabel, counter: Int) {
        if isResetExecuted { return }
        label.alpha = 1.0
        
        var labelFrame = label.frame
        //labelFrame.origin.y = self.frame.size.height + 100 - Bottom to Top
        labelFrame.origin.x = self.frame.size.width + 50 // - Left to Right
        label.frame = labelFrame
        label.alpha = 0.0
        UIView.animate(withDuration: 0.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            //labelFrame.origin.y = CGFloat(self.infoLabelPositionarray[counter]) - Bottom to Top
            labelFrame.origin.x = 26 // - Left to Right
            label.frame = labelFrame
            label.alpha = 1.0
            
        }, completion:{(finished : Bool)  in
            if (finished) {
                // Label shake animation added
                label.shake(duration: 1.0)
                // Check with pooms then desire
                //label.layer.shakeAnimationLabel(duration:  TimeInterval(2.0))
            }
        })
        
    }
    
    @objc func hideAction(timer: Timer) {
        if !self.hideTimer.isValid || isResetExecuted {
            return
        }
        if let userInfo = timer.userInfo as? Dictionary<String, AnyObject>, let infoLabelarray = (userInfo["array"] as? Array<UILabel>), infoLabelarray.count > 0 {
            if hideCounter < infoLabelarray.count {
                let label = infoLabelarray[hideCounter]
                self.hideLabel(label : label, counter: hideCounter)
                hideCounter += 1
            }
            else {
                self.invalidateTimer()
            }
        }
    }
    
    func hideLabel(label : UILabel, counter: Int) {
        if isResetExecuted { return }
        label.alpha = 1.0
        var labelFrame = label.frame
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            //labelFrame.origin.y = 150  - Bottom to Top
            labelFrame.origin.x = -450 // - Left to Right
            label.frame = labelFrame
            label.alpha = 0.0
        }, completion: nil)
    }
    
    
    /*
     Invalidate timer
     */
    func invalidateTimer() {
        isResetExecuted = false
        //        baseCounter = 0
        //        hideCounter = 0
        showTimer.invalidate()
        hideTimer.invalidate()
    }
    
    func invalidateAllTimer() {
        isResetExecuted = true
        for array in infoBasearray {
            for label in array {
                label.alpha = 0.0
            }
        }
        baseCounter = -1
        hideCounter = -1
        infoBasearray.removeAll()
        baseTimer.invalidate()
        showTimer.invalidate()
        hideTimer.invalidate()
    }
    
}

public extension UILabel {
    
    func shake(duration: CFTimeInterval) {
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        translation.values = [-6, 6, 0, 0]//-6,6,0
        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation]
        shakeGroup.duration = duration
        self.layer.add(shakeGroup, forKey: "shakeIt")
    }
    
    func shakeXPosition(count : Float? = nil,for duration : TimeInterval? = nil,withTranslation translation : Float? = nil) {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.repeatCount = count ?? 2
        animation.duration = (duration ?? 0.5)/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation ?? -5
        layer.add(animation, forKey: "shake")
    }
}


extension CALayer {
    
    func shakeAnimationLabel(duration: TimeInterval = TimeInterval(0.5)) {
        let animationKey = "shake"
        removeAnimation(forKey: animationKey)
        let kAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        kAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        kAnimation.duration = duration
        // Adjust the speed of label
        var needOffset = (frame.width * 0.06),
        values = [CGFloat]()
        
        let minOffset = needOffset * 0.1
        
        repeat {
            
            values.append(-needOffset)
            values.append(needOffset)
            needOffset *= 0.5
        } while needOffset > minOffset
        
        values.append(0)
        kAnimation.values = values
        add(kAnimation, forKey: animationKey)
    }
}


