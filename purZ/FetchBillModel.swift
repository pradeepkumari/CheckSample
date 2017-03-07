//
//  FetchBillModel.swift
//  Purz
//
//  Created by Vertace on 01/03/17.
//  Copyright © 2017 vertace. All rights reserved.
//

import Foundation
class FetchBillModel  {
    
    
    
    var entityId: String
    var dateTime: String
    var billerId: String
    var authenticator1: String
    var authenticator2: String
    var authenticator3: String
    var transactionId: String
    
    init?(entityId: String, dateTime: String, billerId: String, authenticator1: String, authenticator2: String, authenticator3: String, transactionId: String){
        self.entityId = entityId
        self.dateTime = dateTime
        self.billerId = billerId
        self.authenticator1 = authenticator1
        self.authenticator2 = authenticator2
        self.authenticator3 = authenticator3
        self.transactionId = transactionId
    }
    
}


