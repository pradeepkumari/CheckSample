//
//  rechargeorPayBill.swift
//  Purz
//
//  Created by Vertace on 23/02/17.
//  Copyright © 2017 vertace. All rights reserved.
//

import Foundation

class ModelViewforRecharge  {
    
    
    
    var IsPostpaid: String
    var amount: String
    var business: String
    var businessEntityId: String
    var comment: String
    var description: String
    var externalTransactionId: String
    var fromEntityId: String
    
    var mobile: String
    var productId: String
    var provider: String
    var serviceType: String
    var sessionId: String
    var special: Bool
    var toEntityId: String
    var transactionOrigin: String
    var transactionType: String
    var yapcode: String

    
    
    init?(IsPostpaid: String, amount: String, business: String, businessEntityId: String, comment: String, description: String, externalTransactionId: String, fromEntityId: String, mobile: String, productId: String, provider: String, serviceType: String, sessionId: String, special: Bool, toEntityId: String, transactionOrigin: String, transactionType: String, yapcode: String){
        self.IsPostpaid = IsPostpaid
        self.amount = amount
        self.business = business
        self.businessEntityId = businessEntityId
        self.comment = comment
        self.description = description
        self.externalTransactionId = externalTransactionId
        self.fromEntityId = fromEntityId
        self.mobile = mobile
        self.productId = productId
        self.provider = provider
        self.serviceType = serviceType
        self.sessionId = sessionId
        self.special = special
        self.toEntityId = toEntityId
        self.transactionOrigin = transactionOrigin
        self.transactionType = transactionType
        self.yapcode = yapcode


    }
    
}


