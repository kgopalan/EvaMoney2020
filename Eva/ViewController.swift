//
//  ViewController.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit
import CloverConnector_Hackathon_2017

class ViewController: UIViewController, StartTransactionDelegate {

    var cloverConnector350Reader : ICloverGoConnector?
    var cloverConnector450Reader : ICloverGoConnector?
    public var cloverConnectorListener:CloverGoConnectorListener?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doSaleTransaction(sender: AnyObject) {
        let totalInInt = Int(5)
        let saleReq = SaleRequest(amount:totalInInt, externalId:"\(arc4random())")
        (UIApplication.shared.delegate as! AppDelegate).cloverConnector?.sale(saleReq)
    }
    
    
    @IBAction func action_connect450Button(sender: AnyObject) {
        
        FLAGS.isKeyedTransaction = false
        
        if(!FLAGS.is450ReaderInitialized)
        {
            if(((PARAMETERS.accessToken) != nil) && ((PARAMETERS.apiKey) != nil) && ((PARAMETERS.secret) != nil))
            {
                if(FLAGS.isOAuthMode)
                {
                    let config450Reader = CloverGoDeviceConfiguration.Builder(apiKey: PARAMETERS.apiKey, secret: PARAMETERS.secret, env: .live).accessToken(accessToken: PARAMETERS.accessToken).allowAutoConnect(allowAutoConnect: true).allowDuplicateTransaction(allowDuplicateTransaction: true).build()
                    cloverConnector450Reader = CloverGoConnector(config: config450Reader)
                }
                else
                {
                    let config450Reader : CloverGoDeviceConfiguration = CloverGoDeviceConfiguration.Builder(apiKey: PARAMETERS.apiKey, secret: PARAMETERS.secret, env: .live).accessToken(accessToken: PARAMETERS.accessToken).allowAutoConnect(allowAutoConnect: true).allowDuplicateTransaction(allowDuplicateTransaction: false).build()
                    cloverConnector450Reader = CloverGoConnector(config: config450Reader)
                }
                
                cloverConnectorListener = CloverGoConnectorListener(cloverConnector: cloverConnector450Reader!)
                (cloverConnector450Reader as? CloverGoConnector)?.addCloverGoConnectorListener(cloverConnectorListener: (cloverConnectorListener as? ICloverGoConnectorListener)!)
                (UIApplication.shared.delegate as! AppDelegate).cloverConnectorListener = cloverConnectorListener
                (UIApplication.shared.delegate as! AppDelegate).cloverConnector = cloverConnector450Reader
                cloverConnector450Reader?.initializeConnection()
            }
            else
            {
                let alert = UIAlertController(title: nil, message: "Missing parameters to initialize the SDK", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            let alert = UIAlertController(title: nil, message: "Reader 450 is already initialized", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        SHARED.delegateStartTransaction = self
    }
    
    //MARK: StartTransactionDelegate delegates
    
    func proceedAfterReaderReady(merchantInfo: MerchantInfo)
    {
        if merchantInfo.deviceInfo?.deviceModel == "RP350X"
        {
            FLAGS.is350ReaderInitialized = true
            checkReaderConnectedStatus()
        }
        if merchantInfo.deviceInfo?.deviceModel == "RP450X"
        {
            FLAGS.is450ReaderInitialized = true
            checkReaderConnectedStatus()
        }
        
    }
    
    func readerDisconnected()
    {
        FLAGS.is350ReaderInitialized = false
        FLAGS.is450ReaderInitialized = false
        checkReaderConnectedStatus()
    }
    
    func checkReaderConnectedStatus()
    {
        if FLAGS.is350ReaderInitialized{
            print("Reader 350 connected ✅")
            print("Disconnect")
        }
        else{
            print("No 350 Reader connected")
            print("Connect")
        }
        if FLAGS.is450ReaderInitialized{
            print("Reader 450 connected ✅")
            print("Disconnect")
        }
        else{
            print("No 450 Reader connected")
            print("Connect")
        }
    }

    func onSalePaymentSuccess(_ saleResponse: SaleResponse?) {
        
    }

}

