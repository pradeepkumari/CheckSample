//
//  SignupViewModel.swift
//  Cippy
//
//  Created by apple on 17/11/16.
//  Copyright © 2016 vertace. All rights reserved.
//

import Foundation

class SignupViewModel {

    var contactNo: String
    var otp: String
    var firstName: String
    var lastName: String
    var emailAddress: String
    var yapCode: String
    var business: String
    var appVersion: String
    var deviceType: String
    var specialDate: String
    var appId: String
    init?(contactNo: String, otp: String, firstName: String, lastName: String, emailAddress: String, yapCode: String, business: String, appVersion: String, deviceType: String, specialDate: String, appId: String){
        self.contactNo = contactNo
        self.otp = otp
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.yapCode = yapCode
        self.business = business
        self.appVersion = appVersion
        self.deviceType = deviceType
        self.specialDate = specialDate
        self.appId = appId
    }
}

class UpdateSignupViewModel {
    
    var contactNo: String
    var otp: String
    var firstName: String
    var lastName: String
    var emailAddress: String
    var yapCode: String
    var business: String
    var appVersion: String
    var deviceType: String
    var specialDate: String
    var entityId: String
    var appGuid: String
    init?(contactNo: String, otp: String, firstName: String, lastName: String, emailAddress: String, yapCode: String, business: String, appVersion: String, deviceType: String, specialDate: String, entityId: String, appGuid: String){
        self.contactNo = contactNo
        self.otp = otp
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.yapCode = yapCode
        self.business = business
        self.appVersion = appVersion
        self.deviceType = deviceType
        self.specialDate = specialDate
        self.entityId = entityId
        self.appGuid = appGuid
    }
}

class ForgotViewModel{
    var customerId: String
    var yapcode: String
    var otp: String
    init?(customerId: String, yapcode: String, otp: String){
        self.customerId = customerId
        self.yapcode  = yapcode
        self.otp = otp
    }
}

class SigninViewModel{
    var yapcode: String
    var businessId: String
    var business: String
    var mobileNumber: String
    var passcode: String
    var appGuid: String
    init?(yapcode: String, businessId: String, business: String, mobileNumber: String, passcode: String, appGuid: String){
        self.yapcode = yapcode
        self.business = business
        self.businessId = businessId
        self.mobileNumber = mobileNumber
        self.passcode = passcode
        self.appGuid = appGuid
    }
}

class DOBViewModel{
    var entityId: String
    var specialDate: String
    init?(entityId: String, specialDate: String){
        self.entityId = entityId
        self.specialDate = specialDate
    }
}
class ChangeViewModel{
    var customerId: String
    var oldYapcode: String
    var newYapcode: String
    init?(customerId: String, oldYapcode: String, newYapcode: String){
        self.customerId = customerId
        self.oldYapcode  = oldYapcode
        self.newYapcode = newYapcode
    }
}



