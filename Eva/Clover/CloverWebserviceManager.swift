//
//  CloverWebserviceManager.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import Foundation

let BASEURL = "https://apisandbox.dev.clover.com/v3/merchants/"
let MERCHANTID = "X23WYMH4YWQY4"
let ACCESSTOKEN = "2e32717e-7aa3-b2e2-1959-3530d75d6c02"

class WebserviceManager {
    
    static let sharedManager = WebserviceManager()
    
    func getMerchantAddressRequest() {
        
        let urlString = BASEURL + MERCHANTID + "/address?access_token=" + ACCESSTOKEN
        
        if let url = NSURL(string: urlString) as URL? {
            
            let request = NSMutableURLRequest(url: url) // Here, kLogin contains the Login API.
            
            let session = URLSession.shared
            
            request.httpMethod = "GET"
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                var _: NSError?
                print(strData ?? "")
            })
            
            task.resume()
        }
    }
    
    func getSingleMerchantRequest() {
        
        let urlString = BASEURL + MERCHANTID + "?access_token=" + ACCESSTOKEN
        
        if let url = NSURL(string: urlString) as URL? {
            
            let request = NSMutableURLRequest(url: url) // Here, kLogin contains the Login API.
            
            let session = URLSession.shared
            
            request.httpMethod = "GET"
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                var _: NSError?
                print(strData ?? "")
            })
            
            task.resume()
        }
    }
    
    func getMerchantOrdertypesRequest() {
        
        let urlString = BASEURL + MERCHANTID + "/orders?access_token=" + ACCESSTOKEN
        
        if let url = NSURL(string: urlString) as URL? {
            
            let request = NSMutableURLRequest(url: url) // Here, kLogin contains the Login API.
            
            let session = URLSession.shared
            
            request.httpMethod = "GET"
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                var _: NSError?
                print(strData ?? "")
            })
            
            task.resume()
        }
    }
    
    
    func createOrders(order_value: Int, discount_percent: Int) {
        
        let Url = String(format: BASEURL + MERCHANTID + "/orders?access_token=" + ACCESSTOKEN)
        
        guard let serviceUrl = URL(string: Url) else { return }
        
        let orderType = ["id": "EYWPQCG2CK802","labelKey": "phone_booking"] as [String : Any]
        
        let parameterDictionary = ["taxRemoved" : false, "total": order_value, "note" : "dinner", "title" : "", "state": "open", "orderType" : orderType] as [String : Any]
        
        print("parameterDictionary ===",parameterDictionary )
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            print("response ===",response ?? "")
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                        print(json)
                        if let id = json["id"] as? String {
                            print(id)
                            if discount_percent != 0 {
                                self.createDiscount(orderId: id, discount_percent: discount_percent)
                            }
                        }
                    }
                }catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    
    func addLineItems() {
        
        let Url = String(format: BASEURL + MERCHANTID + "/orders/Q42M8C1GE9PQA/line_items?access_token=" + ACCESSTOKEN)
        
        guard let serviceUrl = URL(string: Url) else { return }
        
        let id = ["id" : "C2J7WJVPNHEZ8"] as [String : Any]
        
        let parameterDictionary = ["price" : 1800, "item" : id] as [String : Any]
        
        print("parameterDictionary ===",parameterDictionary )
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            print("response ===",response ?? "")
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    
    func createDiscount(orderId: String, discount_percent: Int) {
        
        let Url = String(format: BASEURL + MERCHANTID + "/orders/" + orderId + "/discounts?access_token=" + ACCESSTOKEN)
        
        guard let serviceUrl = URL(string: Url) else { return }
        
        let parameterDictionary = ["name" : "Percentage Discount", "percentage" : discount_percent] as [String : Any]
        
        print("parameterDictionary ===",parameterDictionary )
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            print("response ===",response ?? "")
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    //    func createDiscount() {
    //
    //        let Url = String(format: "https://apisandbox.dev.clover.com/v3/merchants/X23WYMH4YWQY4/orders/Q42M8C1GE9PQA/line_items/T67D8H843GHAG/discounts?access_token=2e32717e-7aa3-b2e2-1959-3530d75d6c02")
    //
    //        guard let serviceUrl = URL(string: Url) else { return }
    //
    //        let parameterDictionary = ["name" : "Percentage Discount", "percentage" : 25] as [String : Any]
    //
    //        print("parameterDictionary ===",parameterDictionary )
    //
    //        var request = URLRequest(url: serviceUrl)
    //        request.httpMethod = "POST"
    //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //        request.addValue("application/json", forHTTPHeaderField: "Accept")
    //
    //        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
    //            return
    //        }
    //        request.httpBody = httpBody
    //
    //        let session = URLSession.shared
    //        session.dataTask(with: request) { (data, response, error) in
    //            print("response ===",response ?? "")
    //            if let response = response {
    //                print(response)
    //            }
    //            if let data = data {
    //                do {
    //                    let json = try JSONSerialization.jsonObject(with: data, options: [])
    //                    print(json)
    //                }catch {
    //                    print(error)
    //                }
    //            }
    //            }.resume()
    //    }
    
}
