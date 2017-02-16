//
//  AddMoneyViewModel.swift
//  Cippy
//
//  Created by apple on 19/12/16.
//  Copyright © 2016 vertace. All rights reserved.
//

import Foundation

class AddMoneyViewModel {

    var entityId: String
    var amount: Float
    var pgType: String
    var bankName: String
    init?(entityId: String, amount: Float, pgType: String, bankName: String){
        self.entityId = entityId
        self.amount = amount
        self.pgType = pgType
        self.bankName = bankName
    }
}
