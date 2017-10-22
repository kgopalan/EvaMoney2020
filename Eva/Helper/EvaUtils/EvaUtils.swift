//
//  EvaUtils.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import Foundation
import UIKit
import Speech


let DEVICE_USERID  = "USERID"
let DEVICE_TOUCHID  = "TOUCHID"
let DEVICE_EMAILID  = "EMAILID"

var RESET_PASSCODE_LENGTH = 4

var PASSCODE_LENGTH = 4
var PASSCODE_LENGTH_LOGIN = 1

var RANDOMNUMBER_LIMIT = Int(16)

// MARK: - Animanted lable constant
var animatedLblConstraintsSetiPhone5 = CGFloat(15.0)
var animatedLblConstraintsSetiPhone6 = CGFloat(30.0)
let animatedLblFontName  = "Helvetica Neue Light"
var animatedLblfontSizePhone5 = CGFloat(14.0)
var animatedLblfontSizeiPhone6 = CGFloat(18.0)

// Network Connectivity Issue Alert Message
let CONNECTIVITY_ISSUE_TITLE = "Internet Connection"
let CONNECTIVITY_ISSUE_BODY = "Yikes! We're having difficulty connecting to the internet, so please try again later."

//Recent Search
let NO_RECENT_SEARCHES = "Hey, you don't have any recent searches."
let NO_RESULT_FOR_SEARCH = "Sorry, there is no result for your query. Try something different."


// MARK: - Validation text
let EnterYourEmailID = "Please enter your email ID."
let EnterYourValidEmailID = "Please enter your valid email ID."
let EnterYourPassword = "Please enter your password."
let invalidCredentais = "Sorry, that credentials did not match our records, please try again.."



// MARK: - Webservice Response string
let SuccessResponse =  "success"

// MARK: - Transactions
let NoTransMessage = "Transactions not available for this account"

// MARK: - Recent search message
let RecentSeacrchWithOutName = "Hey, here are your recent searches"
let RecentSeacrchWithName = ", here are your recent searches"


enum TransitionMode: Int {
    case present, dismiss, pop
}

enum amountType: String {
    case cash = "cash"
    case credit = "credit"
}

enum DisplayType: String {
    case messageWithTransaction = "message_transaction"
    case message = "message"
    case messageWithChart = "message_bar"
    case messageWithPieChart = "message_piechart"
}


enum AnimationType: String {
    case none = "1"
    case push = "2"
    case pop = "3"
}

struct Amount {
    
    var cashValue = NSAttributedString()
    var creditValue = NSAttributedString()
    
    init(type: amountType, _cash: String = "", _credit: String = "") {
        switch type {
        case .cash:
            cashValue = self.getAttributedText(amount: _cash as NSString, color: self.getColor(r:72, g: 175, b: 173))
            return
        case .credit:
            creditValue = self.getAttributedText(amount: _credit as NSString, color: self.getColor(r:192, g: 83, b: 96))
            return
        }
    }
    
    fileprivate func getColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    fileprivate func getFont(of size: CGFloat) -> UIFont {
        return UIFont(name:"Avenir-Roman", size:size) ?? UIFont.systemFont(ofSize: size)
    }
    
    fileprivate func getAttributedText(amount: NSString, color: UIColor) -> NSAttributedString {
        //TODO:  set space b/w "$" and nummber
        //let currSymbol = "$"
        //let attrs1CashAmt = [NSFontAttributeName : getFont(of: 18), NSForegroundColorAttributeName :  color]
        let attrs2CashAmt = [NSAttributedStringKey.font : getFont(of: 25), NSAttributedStringKey.foregroundColor : color]
        // let attributedString1 = NSMutableAttributedString(string:currSymbol as String, attributes: attrs1CashAmt)
        let attributedString = NSMutableAttributedString(string: amount as String, attributes: attrs2CashAmt)
        attributedString.addAttribute(NSAttributedStringKey.kern, value: 0.8, range: NSMakeRange(0, (amount as String).characters.count))
        return attributedString
    }
    
}


enum VCNames: String {
    case mainMenu = "MainViewController"
    case transactionResult = "TransactionsResultViewController"
    case recentSearches = "RecentSearchesViewController"
    case settings = "SettingsViewController"
    case MessageTypeVC = "MessageTypeViewController"
    
    struct storyboardObject {
        var storyboard: UIStoryboard
        init(){
            self.storyboard = UIStoryboard(name: "Main", bundle: nil)
        }
    }
    
    var controllerObject : UIViewController {
        switch self {
        case .mainMenu: return storyboardObject().storyboard.instantiateViewController(withIdentifier: VCNames.mainMenu.rawValue)
        case .transactionResult: return storyboardObject().storyboard.instantiateViewController(withIdentifier: VCNames.transactionResult.rawValue)
        case .recentSearches: return storyboardObject().storyboard.instantiateViewController(withIdentifier: VCNames.recentSearches.rawValue)
        case .settings: return storyboardObject().storyboard.instantiateViewController(withIdentifier: VCNames.settings.rawValue)
        case .MessageTypeVC: return storyboardObject().storyboard.instantiateViewController(withIdentifier: VCNames.MessageTypeVC.rawValue)
            
        }
    }
    
    var navObject : UINavigationController {
        switch self {
        case .mainMenu: return UINavigationController(rootViewController: VCNames.mainMenu.controllerObject)
        case .transactionResult: return UINavigationController(rootViewController: VCNames.transactionResult.controllerObject)
            
        case .recentSearches: return UINavigationController(rootViewController: VCNames.recentSearches.controllerObject)
        case .settings: return UINavigationController(rootViewController: VCNames.settings.controllerObject)
        case .MessageTypeVC: return UINavigationController(rootViewController: VCNames.MessageTypeVC.controllerObject)
            
        }
    }
    
}


public struct SlideMenuOptions {
    public static var leftViewWidth: CGFloat = 210.0
    public static var leftBezelWidth: CGFloat? = 16.0
    public static var contentViewScale: CGFloat = 0.91 //Lyft Animation changes
    public static var contentViewOpacity: CGFloat = 0.5
    public static var contentViewDrag: Bool = false
    public static var shadowOpacity: CGFloat = 0.0
    public static var shadowRadius: CGFloat = 0.0
    public static var shadowOffset: CGSize = CGSize(width: 0,height: 0)
    public static var panFromBezel: Bool = true
    public static var animationDuration: CGFloat = 0.4
    public static var animationOptions: UIViewAnimationOptions = []
    public static var hideStatusBar: Bool = true
    public static var pointOfNoReturnWidth: CGFloat = 44.0
    public static var simultaneousGestureRecognizers: Bool = true
    public static var opacityViewBackgroundColor: UIColor = UIColor.black
    public static var panGesturesEnabled: Bool = true
    public static var tapGesturesEnabled: Bool = true
}

struct LeftPanState {
    static var frameAtStartOfPan: CGRect = CGRect.zero
    static var startPointOfPan: CGPoint = CGPoint.zero
    static var wasOpenAtStartOfPan: Bool = false
    static var wasHiddenAtStartOfPan: Bool = false
    static var lastState : UIGestureRecognizerState = .ended
}

public enum SlideAction {
    case open
    case close
}

public enum TrackAction {
    case leftTapOpen
    case leftTapClose
    case leftFlickOpen
    case leftFlickClose
}


struct PanInfo {
    var action: SlideAction
    var shouldBounce: Bool
    var velocity: CGFloat
}

var menuCellHeight = 46


public let EMPTY_STRING = ""
public let NULL_STRING = "null"
public let EMPTY_INT = 0


enum QueryType: String {
    case voiceSearch = "voiceSearch"
    case textSearch = "textSearch"
    case recentSearch = "recentSearch"
    case totalBalance = "totalBalance"
}

struct EvaUtils {
    
    static func getDBDetails() -> String {
        
        let host1 = "evadev.cc4fekhqmv5a.us-west-2.rds.amazonaws.com"
        let port1 = "5432"
        let user1 = "evadev"
        let password1 = "Daretodream2017"
        let dbname1 = "evamoney2020" 
        
        let connURL = "host="+host1+" port="+port1+" user="+user1+" password="+password1+" dbname="+dbname1+" sslmode=disable";
        return connURL
    }
    static func fetchFromDB(queryString : String = "", accountID : String = "", queryType: QueryType = .textSearch, vc: UIViewController?) -> (String, [String: Any]) {
        
        // send data to C API function "mainConn"
        var responseString = ""
        
        if ReachabilityCheck.isConnectedToNetwork() == true {
            // Change string to Character Array
            let query: [CChar]? = EvaUtils.convertStringToCharacters(parameter: queryString) //"show me transactions from yesterday for $23" //queryString
            let accID: [CChar]? = EvaUtils.convertStringToCharacters(parameter: accountID)
            let userId: [CChar]? = EvaUtils.convertStringToCharacters(parameter: "1")//EvaDataController.sharedInstance.currentUser.user_Id)
            let connURL = getDBDetails()
            
            let conninfo: [CChar]? = EvaUtils.convertStringToCharacters(parameter: connURL)
            
            switch queryType {
            case .voiceSearch:
                if let str = queryDBWithVoiceSearch(UnsafeMutablePointer<Int8>(mutating: conninfo ?? []), UnsafeMutablePointer<Int8>(mutating: query ?? []), UnsafeMutablePointer<Int8>(mutating: userId ?? [])), str.hashValue > 10 {
                    responseString = String(cString: str)
                }
            case .textSearch:
                if let str = queryDBWithTextSearch(UnsafeMutablePointer<Int8>(mutating: conninfo ?? []),UnsafeMutablePointer<Int8>(mutating: query ?? []), UnsafeMutablePointer<Int8>(mutating: userId ?? [])), str.hashValue > 10 {
                    responseString = String(cString: str)
                }
            case .recentSearch:
                if let str = queryDBforRecentSearch(UnsafeMutablePointer<Int8>(mutating: conninfo ?? []),UnsafeMutablePointer<Int8>(mutating: userId ?? [])), str.hashValue > 10 {
                    responseString = String(cString: str)
                }
            case .totalBalance:
                if let str = getTotalBalance(UnsafeMutablePointer<Int8>(mutating: conninfo ?? []),UnsafeMutablePointer<Int8>(mutating: userId ?? [])), str.hashValue > 10 {
                    responseString = String(cString: str)
                }
            default:
                break
            }
        } else {
             print("Internet connection FAILED")
            if vc is InitialViewController {
                vc?.presentAlertWithTitle(title: CONNECTIVITY_ISSUE_TITLE, message: CONNECTIVITY_ISSUE_BODY, vc: vc)
            } else {
                vc?.presentAlertWithTitle(title: CONNECTIVITY_ISSUE_TITLE, message: CONNECTIVITY_ISSUE_BODY)
            }
        }
        
        print("responseString ======= \(responseString)")
        var displayMessage = ""
        var responseDict = [String: Any]()
        if responseString == "error" {
            return (displayMessage, responseDict)
        }
        if let dictionary = EvaUtils.convertToDictionary(value: responseString) {
            displayMessage = EvaUtils.parseVoiceString(responseDict: dictionary)
            responseDict = dictionary
        }
        
        return (displayMessage, responseDict) //EvaUtils.parseResponse(responseString: reponseString)
    }
    
    static func parseVoiceString(responseDict: Dictionary<String , Any>?) -> String {
        
        var displayMessage = ""
        if let valueDict = responseDict?["header"] as? Dictionary<String, String> {
            if let _displayMessage = valueDict["voice_message"] {
                displayMessage = _displayMessage
            }
        }
        return displayMessage
    }
    
    
    static func getWaveHeight(count: Int) -> (height: CGFloat, count: Int) {
        
        var height: CGFloat = 0.0
        var updatedCount: Int = count
        let typeOfWaves = 4
        updatedCount += 1
        if updatedCount%typeOfWaves == 0 {
            height = 0.9
        }
        else if updatedCount%typeOfWaves == 1 {
            height = 0.3
        }
        else if updatedCount%typeOfWaves == 2 {
            height = 0.6
        }
        else if updatedCount%typeOfWaves == 3 {
            height = 0.2
        }
        return (height, updatedCount)
    }
    
    static func convertToDictionary(value: String) -> [String: Any]? {
        if let data = value.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static func getValue(_ value: [Any],forKey key : String) -> String? {
        
        if let valueDict = value.first as? Dictionary<String , String> {
            return valueDict[key] ?? ""
        }
        return nil
    }
    
    
    static func convertStringToCharacters(parameter : String?) -> [CChar]? {
        return parameter?.cString(using: String.Encoding.utf8)
    }
    
    static func parseResponse(responseString: String) -> (String, String) {
        
        var outputString = ""
        var intent = ""
        
        if let responseDict = EvaUtils.convertToDictionary(value: responseString) {
            let tuple = self.parseResponseHeaders(responseDict: responseDict)
            outputString = tuple.0
            outputString += self.parseResponseDetails(responseDict: responseDict)
            intent = tuple.1
        }
        
        return (outputString, intent)
    }
    
    static func parseResponseHeaders(responseDict: Dictionary<String , Any>?) -> (String, String) {
        
        var outputString = ""
        var intent = ""
        
        if let valueDict = responseDict?["header"] as? Dictionary<String, String> {
            
            if let screenName = valueDict["screen_name"] {
                outputString += "screen_name : " + screenName
            }
            
            if let intentname = valueDict["intent"] {
                outputString += "\nintent : " + intentname
                intent = intentname
            }
            
            if let fromdate = valueDict["from_date"] {
                outputString += "\nfrom_date : " + fromdate
            }
            
            if let to_date = valueDict["to_date"] {
                outputString += "\nto_date : " + to_date
            }
            
            if let amount = valueDict["amount"] {
                outputString += "\namount : " + amount
            }
        }
        return (outputString, intent)
    }
    
    static func parseResponseDetails(responseDict: Dictionary<String , Any>?) -> String {
        
        var outputString = ""
        
        if let detailsArray = responseDict?["details"] as? Array<Any> {
            
            for currentDetail in detailsArray {
                
                if let valueDict = currentDetail as? Dictionary<String, Any> {
                    
                    if let screenName = valueDict["created_date"] as? String {
                        outputString += "\ncreated_date : " + screenName
                    }
                    
                    if let intentname = valueDict["intent_name"] as? String {
                        outputString += "\nintent_name : " + intentname
                    }
                    
                    if let fromdate = valueDict["intent_id"] as? String {
                        outputString += "\nintent_id : " + fromdate
                    }
                    
                    if let to_date = valueDict["intent_desc"] as? String {
                        outputString += "\nintent_desc : " + to_date
                    }
                    
                    if let amount = valueDict["intent_type"] as? String {
                        outputString += "\nintent_type : " + amount
                    }
                }
            }
        }
        return outputString
    }
    
    /**
     
     Method to check vaild mail ID
     
     - parameter String: which pass mailID
     
     */
    
    static func isValidEmail(_ mailID:String) -> Bool
    {
        
        let EMAIL_REGEX = "[A-Z0-9a-z.*_%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        if !checkEmailStringForDot(mailID) {
            return false
        }
        else{
            let emailTest = NSPredicate(format:"SELF MATCHES %@", EMAIL_REGEX)
            return emailTest.evaluate(with: mailID)
        }
        
        return false
    }
    
    
    
    static func checkEmailStringForDot(_ email : String) -> Bool {
        
        var isValidEmail : Bool = false;
        var emailArray = email.components(separatedBy: ".")
        
        if (emailArray.count >= 2) {
            isValidEmail = true;
            
            for i in 0..<emailArray.count {
                let emailString : String = emailArray[i]
                
                if (emailString.characters.count < 1 || (emailString as NSString).range(of: " ").location != NSNotFound) {
                    isValidEmail = false
                }
            }
        }
        
        if ((email as NSString).range(of: ".@").location != NSNotFound) {
            isValidEmail = false
        }
        return isValidEmail
    }
    
    
    static func getFont(of name: String,of size: CGFloat) -> UIFont {
        return UIFont(name:name, size:size) ?? UIFont.systemFont(ofSize: size)
    }
    
    
    public static func findDisplayType() {
        
        let displayType = EvaDataController.sharedInstance.transactionResponse?.transactionsHeader?.display_type ?? ""
        switch displayType {
        case DisplayType.messageWithTransaction.rawValue:
            EvaDataController.sharedInstance.currentDisplayType = .messageWithTransaction
        case DisplayType.message.rawValue:
            EvaDataController.sharedInstance.currentDisplayType = .message
        case DisplayType.messageWithChart.rawValue:
            EvaDataController.sharedInstance.currentDisplayType = .messageWithChart
        case DisplayType.messageWithPieChart.rawValue:
            EvaDataController.sharedInstance.currentDisplayType = .messageWithPieChart
        default:
            print("default case")
        }
    }
    
    
    public static func stringFromHtml(string: String) -> NSAttributedString? {
        if let data = string.data(using: String.Encoding.unicode, allowLossyConversion: true) {
            let attrStr = try? NSMutableAttributedString(data: data, options: [ .documentType: NSAttributedString.DocumentType.html],documentAttributes: nil)
            attrStr?.addAttribute(NSAttributedStringKey.font, value: UIFont(name:"HelveticaNeue-Medium", size:17.0) ?? UIFont.systemFont(ofSize: 17.0), range: attrStr?.string.fullrange() ?? NSMakeRange(0, 0))
            //Add spacing 1.0
            attrStr?.addAttribute(NSAttributedStringKey.kern, value: 1.0, range: attrStr?.string.fullrange() ?? NSMakeRange(0, 0))
            return attrStr
        }
        return nil
    }
    
    public static func formatUserQuery(query: String) -> NSAttributedString? {
        let formattedString = "“" + query + "”"
        let attributedString = NSMutableAttributedString(string: formattedString)
        //Add spacing 1.0
        attributedString.addAttribute(NSAttributedStringKey.kern, value: 1.0, range: NSMakeRange(0, formattedString.characters.count))
        return attributedString
    }
    
    public static func stringFromHtmlWithQuotation(string: String) -> NSAttributedString? {
        let formattedString = "“" + string + "”"
        if let data = formattedString.data(using: String.Encoding.unicode, allowLossyConversion: true) {
            let attrStr = try? NSMutableAttributedString(data: data, options: [ .documentType: NSAttributedString.DocumentType.html],documentAttributes: nil)
            attrStr?.addAttribute(NSAttributedStringKey.font, value: UIFont(name:"Helvetica Neue", size:17.0) ?? UIFont.systemFont(ofSize: 17.0), range: attrStr?.string.fullrange() ?? NSMakeRange(0, 0))
            //Add spacing 1.0
            attrStr?.addAttribute(NSAttributedStringKey.kern, value: 1.0, range: attrStr?.string.fullrange() ?? NSMakeRange(0, 0))
            return attrStr
        }
        return nil
    }
    
    public static func formatAmount(amount: String) -> NSAttributedString? {
        let attributedString = NSMutableAttributedString(string: amount)
        //Add spacing 1.0
        attributedString.addAttribute(NSAttributedStringKey.kern, value: 1.0, range: NSMakeRange(0, amount.characters.count))
        return attributedString
    }
    
    public static func formatPoint8Text(text: String) -> NSAttributedString? {
        let attributedString = NSMutableAttributedString(string: text)
        //Add spacing 0.8
        attributedString.addAttribute(NSAttributedStringKey.kern, value: 0.8, range: NSMakeRange(0, text.characters.count))
        return attributedString
    }
    
    public static func format1Text(text: String) -> NSAttributedString? {
        let attributedString = NSMutableAttributedString(string: text)
        //Add spacing 0.8
        attributedString.addAttribute(NSAttributedStringKey.kern, value: 1.0, range: NSMakeRange(0, text.characters.count))
        return attributedString
    }
    
    public static func formatPoint18Text(text: String) -> NSAttributedString? {
        let attributedString = NSMutableAttributedString(string: text)
        
        switch UIDevice().screenType {
        case .iPhone4, .iPhone5:
            // Code for iPhone 4 & iPhone 5
            attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont(name:"Helvetica Neue", size:14.0) ?? UIFont.systemFont(ofSize: 14.0), range: attributedString.string.fullrange() )
            break
        case .iPhone6:
            // Code for iPhone 6 & iPhone 7
            attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont(name:"Helvetica Neue", size:17.0) ?? UIFont.systemFont(ofSize: 17.0), range: attributedString.string.fullrange() )
            break
        case .iPhone6Plus:
            // Code for iPhone 6 Plus & iPhone 7 Plus
            attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont(name:"Helvetica Neue", size:17.0) ?? UIFont.systemFont(ofSize: 17.0), range: attributedString.string.fullrange() )
            break
        default:
            let bounds = UIScreen.main.bounds
            let width = bounds.size.width
            if width > 320.0 {
                attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont(name:"Helvetica Neue", size:17.0) ?? UIFont.systemFont(ofSize: 17.0), range: attributedString.string.fullrange() )
            } else {
                attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont(name:"Helvetica Neue", size:14.0) ?? UIFont.systemFont(ofSize: 14.0), range: attributedString.string.fullrange() )
            }
            break
        }
        
        attributedString.addAttribute(NSAttributedStringKey.kern, value: 0.8, range: NSMakeRange(0, text.characters.count))
        return attributedString
    }
    
    
    public static func isHeadphonesPluggedIn() -> Bool {
        let availableOutputs = AVAudioSession.sharedInstance().currentRoute.outputs
        for portDescription in availableOutputs {
            if portDescription.portType == AVAudioSessionPortHeadphones {
                return true
            }
        }
        return false
    }
    
    //MARK: - Func to mask email address
    static func emailIDMasking(emailString: String) -> (String) {
        if emailString.characters.count == 0 {
            return emailString
        }
        
        let email:String = emailString
        var endIndex:Int = 0
        
        if let idx = email.characters.index(of: "@") {
            
            let indexOfCharacter = email.characters.distance(from: email.startIndex, to: idx)
            if indexOfCharacter == -1 {
                return email
            }
            if indexOfCharacter<=2 {
                endIndex=email.characters.count-indexOfCharacter
            } else {
                endIndex=email.characters.count-indexOfCharacter+1
            }
            
            let subString = email.substring(with: email.characters.index(email.startIndex, offsetBy: 1)..<email.characters.index(email.endIndex, offsetBy: -endIndex))
            // Swift 2.0 changes
            let maskedSubString = subString.characters.map{
                $0 == $0 ? "*" : "*"//•
            }
            let maskedChar = maskedSubString.joined(separator: "")
            
            let textResult = email.substring(to: email.characters.index(email.startIndex, offsetBy: 1)) + maskedChar + email.substring(from: email.characters.index(email.endIndex, offsetBy: -endIndex))
            return textResult
        }
        return emailString
    }
    

}

extension String {
    
    func CGFloatValue() -> CGFloat {
        guard let doubleValue = Double(self) else {
            return 0.0
        }
        return CGFloat(doubleValue)
    }
    
    func trimTrailingWhitespace() -> String {
        if let trailingWs = self.range(of: "\\s+$", options: .regularExpression) {
            return self.replacingCharacters(in: trailingWs, with: "")
        } else {
            return self
        }
    }
    
    func addBRtag() -> String {
        return self.replacingOccurrences(of: "<br>", with: "<br><br>")
    }
    
    func fullrange() -> NSRange {
        return NSMakeRange(0, self.length + self.countEmojiCharacter())
    }
    
    func countEmojiCharacter() -> Int {
        
        func isEmoji(s:NSString) -> Bool {
            
            let high:Int = Int(s.character(at: 0))
            if 0xD800 <= high && high <= 0xDBFF {
                let low:Int = Int(s.character(at: 1))
                let codepoint: Int = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000
                return (0x1D000 <= codepoint && codepoint <= 0x1F9FF)
            }
            else {
                return (0x2100 <= high && high <= 0x27BF)
            }
        }
        
        let nsString = self as NSString
        var length = 0
        
        nsString.enumerateSubstrings(in: NSMakeRange(0, nsString.length), options: NSString.EnumerationOptions.byComposedCharacterSequences) { (subString, substringRange, enclosingRange, stop) -> Void in
            let string = (subString ?? "") as NSString
            if isEmoji(s: string) {
                length += 1
            }
        }
        
        return length
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}


public extension UIDevice {
    
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    enum ScreenType: String {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case Unknown
    }
    var screenType: ScreenType {
        guard iPhone else { return .Unknown}
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhone5
        case 1334:
            return .iPhone6
        case 2208:
            return .iPhone6Plus
        default:
            return .Unknown
        }
    }
    
}


extension String {
    public func index(of char: Character) -> Int? {
        if let idx = characters.index(of: char) {
            return characters.distance(from: startIndex, to: idx)
        }
        return nil
    }
}

