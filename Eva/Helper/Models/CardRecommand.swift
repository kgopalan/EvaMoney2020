//
//  CardRecommand.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import Foundation


struct TransactionsHeader {
    
    // Header Property declration
    var display_screen_name: String = ""
    var display_type: String = ""
    var display_message: String = ""
    var display_value: String = ""
    var display_notes: String = ""
    var user_query_text: String = ""
    var voice_message: String = ""
    var order_value: Int = EMPTY_INT
    var discount_percent: Int = EMPTY_INT
    
    
    // Init Method Assigning
    init(display_screen_name: String = "", display_type: String = "", display_message: String = "", display_value:String = "", display_notes: String = "", user_query_text: String = "",  voice_message: String = "", order_value: Int = EMPTY_INT, discount_percent: Int = EMPTY_INT) {
        self.display_screen_name = display_screen_name;
        self.display_type = display_type;
        self.display_message = display_message;
        self.display_value = display_value;
        self.display_notes = display_notes
        self.user_query_text = user_query_text
        self.voice_message = voice_message
        self.order_value = order_value
        self.discount_percent = discount_percent
    }
}

extension TransactionsHeader: Mappable {
    
    static func empty() -> TransactionsHeader{
        return TransactionsHeader(display_screen_name: EMPTY_STRING, display_type: EMPTY_STRING, display_message: EMPTY_STRING, display_value: EMPTY_STRING, display_notes: EMPTY_STRING, user_query_text: EMPTY_STRING, voice_message: EMPTY_STRING, order_value:EMPTY_INT, discount_percent: EMPTY_INT)
    }
    
    static func Map(_ json: JSONObject) -> TransactionsHeader? {
        guard let d: JSONDictionary = Parse(json) else {
            return nil
        }
        
        let display_screen_name = (d <-  "display_screen_name") ?? EMPTY_STRING
        let display_type = (d <- "display_type") ?? EMPTY_STRING
        let display_message = (d <- "display_message") ?? EMPTY_STRING
        let display_value = (d <- "display_value") ?? EMPTY_STRING
        let display_notes = (d <- "display_notes") ?? EMPTY_STRING
        let user_query_text = (d <- "user_query_text") ?? EMPTY_STRING
        let voice_message = (d <- "voice_message") ?? EMPTY_STRING
        let order_value = (d <- "order_value") ?? EMPTY_INT
        let discount_percent = (d <- "discount_percent") ?? EMPTY_INT
        
        
        return TransactionsHeader(display_screen_name: display_screen_name, display_type: display_type, display_message: display_message, display_value: display_value, display_notes: display_notes, user_query_text: user_query_text, voice_message: voice_message, order_value: order_value, discount_percent: discount_percent)
    }
    
}


struct Transactions {
    var transactionsHeader: TransactionsHeader?
    var graphData: [GraphData] = []
    var orders: [Orders] = []
}


extension Transactions: Mappable{
    
    static func empty() -> Transactions {
        return Transactions(transactionsHeader: TransactionsHeader(), graphData: [], orders: [])
    }
    
    static func Map(_ json: JSONObject) -> Transactions? {
        guard let d: JSONDictionary = Parse(json) else {
            return nil
        }
        let transactionsHeader: TransactionsHeader = (d <-> "header") ?? TransactionsHeader()
        let graphData : [GraphData] = (d <-- "graph_data") ?? []
        let orders : [Orders] = (d <-- "orders") ?? []
        
        return Transactions(transactionsHeader: transactionsHeader, graphData: graphData, orders: orders)
    }
}

let EMPTY_FLOAT: Float = 0.0

struct Graph {
    var graphData: GraphData = GraphData()
}


extension Graph: Mappable {
    
    static func empty() -> Graph {
        return Graph(graphData: GraphData())
    }
    
    static func Map(_ json: JSONObject) -> Graph? {
        guard let d: JSONDictionary = Parse(json) else {
            return nil
        }
        let graphData : GraphData = (d <-> "graph_data") ?? GraphData()
        
        return Graph(graphData: graphData)
    }
}

struct GraphData {
    var value: Float = EMPTY_FLOAT
    var category: String = EMPTY_STRING
}

extension GraphData: Mappable {
    
    static func empty() -> GraphData {
        return GraphData(value: EMPTY_FLOAT, category: EMPTY_STRING)
    }
    
    static func Map(_ json: JSONObject) -> GraphData? {
        guard let d: JSONDictionary = Parse(json) else {
            return nil
        }
        
        let value = (d <-  "value") ?? EMPTY_FLOAT
        let category = (d <-  "category") ?? NULL_STRING
        
        return GraphData(value: value, category: category)
    }
    
}


struct Orders {
    var order_id: Int = EMPTY_INT
    var currency: String = EMPTY_STRING
    var title: String = EMPTY_STRING
    var order_date_as_display: String = EMPTY_STRING
    var note: String = EMPTY_STRING
    var orderType: String = EMPTY_STRING
    var total: Int = EMPTY_INT
    var display_total: String = EMPTY_STRING
    var paymentType: String = EMPTY_STRING
    var employee_name: String = EMPTY_STRING
    
}

extension Orders: Mappable {
    
    static func empty() -> Orders {
        return Orders(order_id: EMPTY_INT, currency: EMPTY_STRING, title: EMPTY_STRING, order_date_as_display: EMPTY_STRING, note: EMPTY_STRING, orderType: EMPTY_STRING, total: EMPTY_INT, display_total: EMPTY_STRING, paymentType: EMPTY_STRING, employee_name: EMPTY_STRING)
    }
    
    static func Map(_ json: JSONObject) -> Orders? {
        guard let d: JSONDictionary = Parse(json) else {
            return nil
        }
        
        let order_id = (d <-  "order_id") ?? EMPTY_INT
        let currency = (d <-  "currency") ?? NULL_STRING
        let title = (d <-  "title") ?? NULL_STRING
        let order_date_as_display = (d <-  "order_date_as_display") ?? NULL_STRING
        let note = (d <-  "note") ?? NULL_STRING
        let orderType = (d <-  "ordertype") ?? NULL_STRING
        let total = (d <-  "total") ?? EMPTY_INT
        let display_total = (d <-  "display_total") ?? NULL_STRING
        let paymentType = (d <-  "paymenttype") ?? NULL_STRING
        let employee_name = (d <-  "employee_name") ?? NULL_STRING
        
        return Orders(order_id: order_id, currency: currency, title: title, order_date_as_display: order_date_as_display, note: note, orderType: orderType, total: total, display_total: display_total, paymentType: paymentType, employee_name: employee_name)
    }
    
}


struct Bar {
    var barData: BarData = BarData()
}


extension Bar: Mappable {
    
    static func empty() -> Bar {
        return Bar(barData: BarData())
    }
    
    static func Map(_ json: JSONObject) -> Bar? {
        guard let d: JSONDictionary = Parse(json) else {
            return nil
        }
        let barData : BarData = (d <-> "bar_data") ?? BarData()
        
        return Bar(barData: barData)
    }
}

struct BarData {
    var value: Float = EMPTY_FLOAT
    var category: String = ""
}

extension BarData: Mappable {
    
    static func empty() -> BarData {
        return BarData(value: EMPTY_FLOAT, category: EMPTY_STRING)
    }
    
    static func Map(_ json: JSONObject) -> BarData? {
        guard let d: JSONDictionary = Parse(json) else {
            return nil
        }
        
        let value = (d <-  "value") ?? EMPTY_FLOAT
        let category = (d <-  "category") ?? NULL_STRING
        
        return BarData(value: value, category: category)
    }
    
}


struct RecentSearchs {
    var recentSearches: [RecentSearch] = []
}


extension RecentSearchs: Mappable {
    
    static func empty() -> RecentSearchs {
        return RecentSearchs(recentSearches: [])
    }
    
    static func Map(_ json: JSONObject) -> RecentSearchs? {
        guard let d: JSONDictionary = Parse(json) else {
            return nil
        }
        let recentSearches : [RecentSearch] = (d <-- "recent_searches") ?? []
        
        return RecentSearchs(recentSearches: recentSearches)
    }
}

struct RecentSearch {
    var query_text: String = ""
}

extension RecentSearch: Mappable {
    
    static func empty() -> RecentSearch {
        return RecentSearch(query_text: EMPTY_STRING)
    }
    
    static func Map(_ json: JSONObject) -> RecentSearch? {
        guard let d: JSONDictionary = Parse(json) else {
            return nil
        }
        
        let query_text = (d <-  "query_text") ?? EMPTY_STRING
        
        return RecentSearch(query_text: query_text)
    }
    
}



struct Balances {
    var balance: Balance = Balance()
}


extension Balances: Mappable {
    
    static func empty() -> Balances {
        return Balances(balance: Balance())
    }
    
    static func Map(_ json: JSONObject) -> Balances? {
        guard let d: JSONDictionary = Parse(json) else {
            return nil
        }
        let balance : Balance = (d <-> "balance") ?? Balance()
        
        return Balances(balance: balance)
    }
}

struct Balance {
    var sales_today: String = ""
    var sales_thismonth: String = ""
    var merchant_name: String = ""
}

extension Balance: Mappable {
    
    static func empty() -> Balance {
        return Balance(sales_today: EMPTY_STRING, sales_thismonth: EMPTY_STRING, merchant_name: EMPTY_STRING)
    }
    
    static func Map(_ json: JSONObject) -> Balance? {
        guard let d: JSONDictionary = Parse(json) else {
            return nil
        }
        
        let sales_today = (d <-  "sales_today") ?? EMPTY_STRING
        let sales_thismonth = (d <-  "sales_thismonth") ?? EMPTY_STRING
        let merchant_name = (d <-  "merchant_name") ?? EMPTY_STRING
        
        return Balance(sales_today: sales_today, sales_thismonth: sales_thismonth, merchant_name: merchant_name)
    }
    
}



struct User {
    var userInfo: UserInfo = UserInfo()
}


extension User: Mappable {
    
    static func empty() -> User {
        return User(userInfo: UserInfo())
    }
    
    static func Map(_ json: JSONObject) -> User? {
        guard let d: JSONDictionary = Parse(json) else {
            return nil
        }
        
        var user = UserInfo()
        
        //User settings
        if let _ = d["user_setting"] as? Dictionary<String, String> {
            user = (d <-> "user_setting") ?? UserInfo()
        }
        
        // Login
        if let _ = d["authentication_info"] as? Dictionary<String, String> {
            user = (d <-> "authentication_info") ?? UserInfo()
        }
        
        //Validate passcode
        if let _ = d["user_info"] as? Dictionary<String, String> {
            user = (d <-> "user_info") ?? UserInfo()
        }
        
        //Create user
        if let _ = d["created_user_info"] as? Dictionary<String, String> {
            user = (d <-> "created_user_info") ?? UserInfo()
        }
        
        return User(userInfo: user)
    }
}

struct UserInfo {
    var connected_accounts: String = "false"
    var user_Id: String = ""
    var email: String = ""
    var password: String = ""
    var user_nickname: String = ""
    var touch_setting_enabled: String = ""
    var voice_passcode_enabled: String = ""
    var goal_credit_score_improve_flag: String = ""
    var goal_maximize_rewards_flag: String = ""
    
    var voice_response: String = ""
}

extension UserInfo: Mappable {
    
    static func empty() -> UserInfo {
        return UserInfo(connected_accounts: EMPTY_STRING, user_Id: EMPTY_STRING, email: EMPTY_STRING, password: EMPTY_STRING, user_nickname: EMPTY_STRING, touch_setting_enabled: EMPTY_STRING, voice_passcode_enabled: EMPTY_STRING, goal_credit_score_improve_flag: EMPTY_STRING, goal_maximize_rewards_flag: EMPTY_STRING, voice_response: EMPTY_STRING)
    }
    
    static func Map(_ json: JSONObject) -> UserInfo? {
        guard let d: JSONDictionary = Parse(json) else {
            return nil
        }
        
        let connected_accounts = (d <-  "connected_accounts") ?? EMPTY_STRING
        let user_nickname = (d <-  "name") ?? EMPTY_STRING
        let email = (d <-  "user_email") ?? EMPTY_STRING
        let touch_setting_enabled = (d <-  "touch_setting_enabled") ?? NULL_STRING
        let voice_passcode_enabled = (d <-  "voice_passcode_enabled") ?? EMPTY_STRING
        let goal_credit_score_improve_flag = (d <-  "goal_credit_score_improve_flag") ?? NULL_STRING
        let goal_maximize_rewards_flag = (d <-  "goal_maximize_rewards_flag") ?? NULL_STRING
        
        //New Signup changes
        let user_Id = (d <-  "user_id") ?? EMPTY_STRING
        var voice_response = (d <-  "voice_response") ?? EMPTY_STRING
        //Default it to false
        if voice_response == "" {
            voice_response = "false"
        }
        let password = EvaDataController.sharedInstance.currentUser.password
        
        return UserInfo(connected_accounts: connected_accounts, user_Id: user_Id, email: email, password: password, user_nickname: user_nickname, touch_setting_enabled: touch_setting_enabled, voice_passcode_enabled: voice_passcode_enabled, goal_credit_score_improve_flag: goal_credit_score_improve_flag, goal_maximize_rewards_flag: goal_maximize_rewards_flag, voice_response: voice_response)
    }
    
}
