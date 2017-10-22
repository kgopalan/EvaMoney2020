//
//  ViewController.swift
//  Sample
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import Foundation
import CloverConnector_Hackathon_2017

protocol StartTransactionDelegate{
    func proceedAfterReaderReady(merchantInfo: MerchantInfo)
    func readerDisconnected()
    func onSalePaymentSuccess(_ saleResponse: SaleResponse?)
}

struct PARAMETERS {
    static var accessToken: String = "94d623af-a638-c86d-220a-6b4e2cc121d5"
    static var apiKey: String = "mexbZJX5D3fa5kje1dZmrJVKOyAF9w8F"
    static var secret: String = "6hak16ff8e76r4565ab988f5d986a911e36f0f2347e3fv3eb719478c98e89io0"
}

struct FLAGS {
    static var isCloverGoMode = false
    static var isOAuthMode = false
    static var is350ReaderInitialized = false
    static var is450ReaderInitialized = false
    static var isKeyedTransaction = false
}

struct SHARED {
    static let workingQueue = DispatchQueue.init(label: "my_queue")
    static var delegateStartTransaction:StartTransactionDelegate? = nil
}
