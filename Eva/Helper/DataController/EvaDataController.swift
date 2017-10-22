//
//  EvaDataController.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import Foundation
import UIKit


/*
 * Allowed type of search details
 */

enum searchType: String {
    case voice = "voice"
    case text = "text"
    case none = "none"
}


class EvaDataController: NSObject {
    
    /*
     * Eva singleton Shared Instance object
     */
    static var sharedInstance = EvaDataController()
    
    /*
     * Current output display type variable
     */
    var currentDisplayType: DisplayType?
    
    /*
     * Transactions details response
     */
    var transactionResponse: Transactions?
    
    /*
     * Transactions Balances details
     */
    var currentBalances: Balances?
    
    /*
     * Recent Search Response details
     */
    var recentSearchResponse: RecentSearchs?
        
    var findSpeakerBtnStatus : String = ""
    
    var currentUser = UserInfo.empty()
    
    var selectedAccountIndex : Int = 0
    
    var currentSearchType: searchType? = .none
    
    var showBackArrow: Bool?
    
}
