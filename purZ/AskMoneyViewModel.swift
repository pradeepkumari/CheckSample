//
//  AskMoneyViewModel.swift
//  Cippy
//
//  Created by apple on 23/11/16.
//  Copyright © 2016 vertace. All rights reserved.
//

import Foundation

class AskMoneyViewModel {

    var amount: String
    var description: String
    var toEntityId: String
    var businessId: String
    var productId: String
    var transactionType: String
    var transactionOrigin: String
    init?(amount: String, description: String, toEntityId: String, businessId: String, productId: String, transactionType: String, transactionOrigin: String){
        self.amount = amount
        self.description = description
        self.toEntityId = toEntityId
        self.businessId = businessId
        self.productId = productId
        self.transactionType = transactionType
        self.transactionOrigin = transactionOrigin
    }
   
}
class CheckRegistrationViewModel{
    var business: String
    var businessId: String
    init?(business: String, businessId: String){
        self.business = business
        self.businessId = businessId
    }
}

class DummyRegisterViewModel{
    var contactNo: String
    var firstName: String
    var lastName: String
    var business: String
    init?(contactNo: String, firstName: String, lastName: String, business: String){
        self.contactNo = contactNo
        self.firstName = firstName
        self.lastName = lastName
        self.business = business
    }
}


class SendMoneyViewModel{
    var amount: String
    var description: String
    var fromEntityId: String
    var businessId: String
    var businessType: String
    var productId: String
    var yapcode: String
    var transactionType: String
    var transactionOrigin: String
    init?(amount: String, description: String, fromEntityId: String, businessId: String, businessType: String, productId: String, yapcode: String, transactionType: String, transactionOrigin: String){
        self.amount = amount
        self.description = description
        self.fromEntityId = fromEntityId
        self.businessId = businessId
        self.businessType = businessType
        self.productId = productId
        self.yapcode = yapcode
        self.transactionType = transactionType
        self.transactionOrigin = transactionOrigin
    }
}





