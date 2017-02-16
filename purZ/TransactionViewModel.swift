//
//  TransactionViewModel.swift
//  Cippy
//
//  Created by apple on 30/11/16.
//  Copyright © 2016 vertace. All rights reserved.
//

import Foundation

class TransactionViewModel {

    var amount: String
    var balance: String
    var otherPartyName: String
    init?(amount: String, balance: String, otherPartyName: String){
        self.amount = amount
        self.balance = balance
        self.otherPartyName = otherPartyName
    }
    
}

class ApprovalViewModel{
    var fundRequestNumber: String
    var status: String
    var yapcode: String
    init?(fundRequestNumber: String, status: String, yapcode: String){
        self.fundRequestNumber = fundRequestNumber
        self.status = status
        self.yapcode = yapcode
    }
}
