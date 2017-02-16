//
//  RechargeViewModel.swift
//  Cippy
//
//  Created by apple on 25/11/16.
//  Copyright © 2016 vertace. All rights reserved.
//

import Foundation

class RechargeViewModel {

    var amount: String
    var operatorCode: String
    var comment: String
    var number: String
    var yapcode: String
    var fromEntityId: String
    var productId: String
    var transactionOrigin: String
    var business: String
    var toEntityId: String
    var businessEntityId: String
    var externalTransactionId: String
    var description: String
    var special: Bool
    var transactionType: String
    init?(amount: String, operatorCode: String, comment: String, number: String, yapcode: String, fromEntityId: String, productId: String, transactionOrigin: String, business: String, toEntityId: String, businessEntityId: String, externalTransactionId: String, description: String, special: Bool, transactionType: String){
        self.amount = amount
        self.operatorCode = operatorCode
        self.comment = comment
        self.number = number
        self.yapcode = yapcode
        self.fromEntityId = fromEntityId
        self.productId = productId
        self.transactionOrigin = transactionOrigin
        self.business = business
        self.toEntityId = toEntityId
        self.businessEntityId = businessEntityId
        self.externalTransactionId = externalTransactionId
        self.description = description
        self.special = special
        self.transactionType = transactionType
    }
}



class PayAtStoreViewModel{
    var amount: String
    var description: String
    var fromEntityId: String
    var toEntityId: String
    var productId: String
    var yapcode: String
    var transactionType: String
    var transactionOrigin: String
    var businessId: String
    var business: String
    var businessType: String
    var qrData: String
    var merchantData: String
    init?(amount: String, description: String, fromEntityId: String, toEntityId: String, productId: String, yapcode: String, transactionType: String, transactionOrigin: String, businessId: String, business: String, businessType: String, qrData: String, merchantData: String){
        self.amount = amount
        self.description = description
        self.fromEntityId = fromEntityId
        self.toEntityId = toEntityId
        self.productId = productId
        self.yapcode = yapcode
        self.transactionType = transactionType
        self.transactionOrigin = transactionOrigin
        self.businessId = businessId
        self.business = business
        self.businessType = businessType
        self.qrData = qrData
        self.merchantData = merchantData
    }
}

class QRScanModel{
 
    var Card_No: String
    var MerchantName: String
    var MCC: String
    var CityName: String
    var CountryCode: String
    var IndianRupeeCode: String
    var TransAmount: String
    var DefaultValue: String
    var TerminalID: String
    
    init?(Card_No: String, MerchantName: String, MCC: String, CityName: String, CountryCode: String, IndianRupeeCode: String, TransAmount: String, DefaultValue: String, TerminalID: String){
        self.Card_No = Card_No
        self.MerchantName = MerchantName
        self.MCC = MCC
        self.CityName = CityName
        self.CountryCode = CountryCode
        self.IndianRupeeCode = IndianRupeeCode
        self.TransAmount = TransAmount
        self.DefaultValue = DefaultValue
        self.TerminalID = TerminalID
        
    }
}


class ProfileViewModel{
    
    var specialDate: String
    var entityId: String
    var address: String
    var address2: String
    var city: String
    var state: String
    var pincode: String
    var description: String
    
    init?(specialDate: String, entityId: String, address: String, address2: String, city: String, state: String, pincode: String, description: String){
        self.specialDate = specialDate
        self.entityId = entityId
        self.address = address
        self.address2 = address2
        self.city = city
        self.state = state
        self.pincode = pincode
        self.description = description
    }
}






