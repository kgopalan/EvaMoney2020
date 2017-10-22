//
//  CloverGoConnectorListener.swift
//  Sample
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import Foundation
import CloverConnector_Hackathon_2017

public class CloverGoConnectorListener: ICloverGoConnectorListener {
    
    weak var cloverConnector:ICloverGoConnector?
    
    public init(cloverConnector:ICloverGoConnector){
        self.cloverConnector = cloverConnector;
    }

    public func onSaleResponse(_ response: SaleResponse) {
        print("onSaleResponse \(response)")
    }
    
    public func onAuthResponse(_ authResponse: AuthResponse) {
        
    }
    
    public func onPreAuthResponse(_ preAuthResponse: PreAuthResponse) {
        
    }
    
    public func onCapturePreAuthResponse(_ capturePreAuthResponse: CapturePreAuthResponse) {
        
    }
    
    public func onTipAdjustAuthResponse(_ tipAdjustAuthResponse: TipAdjustAuthResponse) {
        
    }
    
    public func onVoidPaymentResponse(_ voidPaymentResponse: VoidPaymentResponse) {
        
    }
    
    public func onRefundPaymentResponse(_ refundPaymentResponse: RefundPaymentResponse) {
        
    }
    
    public func onManualRefundResponse(_ manualRefundResponse: ManualRefundResponse) {
        
    }
    
    public func onCloseoutResponse(_ closeoutResponse: CloseoutResponse) {
        
    }
    
    public func onVerifySignatureRequest(_ signatureVerifyRequest: VerifySignatureRequest) {
        
    }
    
    public func onVaultCardResponse(_ vaultCardResponse: VaultCardResponse) {
        
    }
    
    public func onDeviceActivityStart(_ deviceEvent: CloverDeviceEvent) {
        
    }
    
    public func onDeviceActivityEnd(_ deviceEvent: CloverDeviceEvent) {
        
    }
    
    public func onDeviceError(_ deviceErrorEvent: CloverDeviceErrorEvent) {
        print("onDeviceError \(deviceErrorEvent)")
    }
    
    public func onDeviceConnected() {
        
        print("onDeviceConnected")
        
    }
    
    public func onDeviceReady(_ merchantInfo: MerchantInfo) {
        print("onDeviceReady \(merchantInfo)")
        DispatchQueue.main.async {
            SHARED.delegateStartTransaction?.proceedAfterReaderReady(merchantInfo: merchantInfo)
        }
    }
    
    public func onDeviceDisconnected() {
        
    }
    
    public func onConfirmPaymentRequest(_ request: ConfirmPaymentRequest) {
        
    }
    
    public func onTipAdded(_ message: TipAddedMessage) {
        
    }
    
    public func onPrintManualRefundReceipt(_ printManualRefundReceiptMessage: PrintManualRefundReceiptMessage) {
        
    }
    
    public func onPrintManualRefundDeclineReceipt(_ printManualRefundDeclineReceiptMessage: PrintManualRefundDeclineReceiptMessage) {
        
    }
    
    public func onPrintPaymentReceipt(_ printPaymentReceiptMessage: PrintPaymentReceiptMessage) {
        
    }
    
    public func onPrintPaymentDeclineReceipt(_ printPaymentDeclineReceiptMessage: PrintPaymentDeclineReceiptMessage) {
        
    }
    
    public func onPrintPaymentMerchantCopyReceipt(_ printPaymentMerchantCopyReceiptMessage: PrintPaymentMerchantCopyReceiptMessage) {
        
    }
    
    public func onPrintRefundPaymentReceipt(_ printRefundPaymentReceiptMessage: PrintRefundPaymentReceiptMessage) {
        
    }
    
    public func onRetrievePrintersResponse(_ retrievePrintersResponse: RetrievePrintersResponse) {
        
    }
    
    public func onPrintJobStatusResponse(_ printJobStatusResponse: PrintJobStatusResponse) {
        
    }
    
    public func onRetrievePendingPaymentsResponse(_ retrievePendingPaymentResponse: RetrievePendingPaymentsResponse) {
        
    }
    
    public func onReadCardDataResponse(_ readCardDataResponse: ReadCardDataResponse) {
        
    }
    
    public func onCustomActivityResponse(_ customActivityResponse: CustomActivityResponse) {
        
    }
    
    public func onResetDeviceResponse(_ response: ResetDeviceResponse) {
        
    }
    
    public func onMessageFromActivity(_ response: MessageFromActivity) {
        
    }
    
    public func onRetrievePaymentResponse(_ response: RetrievePaymentResponse) {
        
    }
    
    public func onRetrieveDeviceStatusResponse(_ _response: RetrieveDeviceStatusResponse) {
        
    }

    
    public func onAidMatch(cardApplicationIdentifiers:[CLVModels.Payments.CardApplicationIdentifier]) -> Void {
        
    }
    
    public func onDevicesDiscovered(devices:[CLVModels.Device.GoDeviceInfo]) ->Void {
        print("Discovered Readers...")
        if devices.count == 0 {
            return
        }
        let choiceAlert = UIAlertController(title: "Choose your reader", message: "Please select one of the reader", preferredStyle: .actionSheet)
        for device in devices {
            let action = UIAlertAction(title: device.name, style: .default, handler: {
                (action:UIAlertAction) in
                ((UIApplication.shared.delegate as! AppDelegate).cloverConnector as? CloverGoConnector)?.connectToBluetoothDevice(deviceInfo: device)
                
            })
            choiceAlert.addAction(action)
        }
        choiceAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (action:UIAlertAction) in
            
        }))
        
        var topController = UIApplication.shared.keyWindow!.rootViewController! as UIViewController
        while ((topController.presentedViewController) != nil) {
            topController = topController.presentedViewController!
        }
        
        if let popoverController = choiceAlert.popoverPresentationController {
            popoverController.sourceView = topController.view
            popoverController.sourceRect = CGRect(x: topController.view.bounds.midX, y: topController.view.bounds.midY, width: 0, height: 0)
        }
        
        topController.present(choiceAlert, animated:true, completion:nil)
        
    }
    
    
    public func onTransactionProgress(event: CLVModels.Payments.GoTransactionEvent) -> Void {
        print("\(event.getDescription())")
        
        switch event
        {
        case .EMV_CARD_INSERTED,.CARD_SWIPED,.CARD_TAPPED:
            print("Processing Transaction")
            break
            
        case .EMV_CARD_REMOVED:
            print("Card removed")
            break
            
        case .EMV_CARD_DIP_FAILED:
            print("Emv card dip failed.\nPlease reinsert card")
            break
            
        case .EMV_CARD_SWIPED_ERROR:
            print("Emv card swiped error")
            break
            
        case .EMV_DIP_FAILED_PROCEED_WITH_SWIPE:
            print("Emv card dip failed.\n\nPlease try swipe.")
            break
            
        case .SWIPE_FAILED:
            print("Swipe failed")
            break
            
        case .CONTACTLESS_FAILED_TRY_AGAIN:
            print("Contactless failed\nTry again")
            break
            
        case .SWIPE_DIP_OR_TAP_CARD:
            print("Please \n\nINSERT / SWIPE / TAP \n\na card")
            break
        case .REMOVE_CARD:
            print("Please Remove Card from Reader")
            
        default:
            break;
        }
    }
    
    
    public func onSignatureRequired() -> Void {
        
    }
    
    public func onSendReceipt() -> Void {
        DispatchQueue.main.async {
            SHARED.delegateStartTransaction?.onSalePaymentSuccess(nil)
        }
    }

}
