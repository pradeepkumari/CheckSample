//
//  SplitbillViewModel.swift
//  Cippy
//
//  Created by apple on 10/01/17.
//  Copyright © 2017 vertace. All rights reserved.
//

import Foundation

class SplitbillViewModel{
    var result: Array<SplitModelItems>
    init?(result: Array<SplitModelItems>){
        self.result = result
    }
}



class SplitModelItems{
    var toEntityId: String
    var name: String
    var businessId: String
    var productId: String
    var description: String
    var transactionType: String
    var transactionOrigin: String
    var amount: String
    var IsEdited: Bool
    init?(toEntityId: String, name: String, businessId: String, productId: String, description: String, transactionType: String, transactionOrigin: String, amount: String, IsEdited: Bool){
        
        self.toEntityId = toEntityId
        self.name = name
        self.businessId = businessId
        self.productId = productId
        self.description = description
        self.transactionType = transactionType
        self.transactionOrigin = transactionOrigin
        self.amount = amount
        self.IsEdited = IsEdited
    }
}