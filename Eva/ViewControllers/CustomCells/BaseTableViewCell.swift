//
//  BaseTableViewCell.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    let TEXTLABEL_FONT = CGFloat(18.0)
    
    class var identifier: String { return String.className(self) }
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    open override func awakeFromNib() {
    }
    
    open func setup() {
    }
    
    open class func height() -> CGFloat {
        return CGFloat(menuCellHeight)
    }
    
    open func setMenuWith(_ name: Any?) {
        self.backgroundColor = UIColor.white // UIColor(hex: "F1F8E9")
        self.textLabel?.font = UIFont(name:"HelveticaNeue-Light", size:TEXTLABEL_FONT) ?? UIFont.systemFont(ofSize: TEXTLABEL_FONT) // Default Font
        self.textLabel?.textColor = UIColor.black
        self.textLabel?.isUserInteractionEnabled = true
        if let _name = name as? String {
            self.textLabel?.attributedText = EvaUtils.format1Text(text: _name)
        }
    }
    
    
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.alpha = highlighted == true ?  0.5 : 1.0
    }
    
    // ignore the default handling
    override open func setSelected(_ selected: Bool, animated: Bool) {
    }
    
}
