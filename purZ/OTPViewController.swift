//
//  OTPViewController.swift
//  Cippy
//
//  Created by apple on 16/11/16.
//  Copyright © 2016 vertace. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var otptextfield: UITextField!
    @IBOutlet weak var verifybtn: UIButton!
    @IBOutlet weak var resentotpbtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var logoimage: UIImageView!
    @IBOutlet weak var backgroundlbl: UILabel!
    
    @IBOutlet weak var logobacklbl: UILabel!
    
    @IBOutlet weak var verifybacklbl: UILabel!
    @IBOutlet weak var resendbacklbl: UILabel!
    
    var pre_operatorCode = [String]()
    var pre_operatorName = [String]()
    var pre_operatorId = [String]()
    var pre_operatorType = [String]()
    var pre_special = [Bool]()
    
    var post_operatorCode = [String]()
    var post_operatorName = [String]()
    var post_operatorId = [String]()
    var post_operatorType = [String]()
    var post_special = [Bool]()
    
    var dth_operatorCode = [String]()
    var dth_operatorName = [String]()
    var dth_operatorId = [String]()
    var dth_operatorType = [String]()
    var dth_special = [Bool]()
    
    
    var characterCountLimit = 6
    var fromsignin = false
    var fromsendmoney = false
    var fromrecharge = false
    var fromprofile = false
    var fromnotification = false
    var yapcode = ""
    var businessid = ""
    var remark = ""
    var amount = ""
    var recharge_amount = ""
    var recharge_operatorcode = ""
    var recharge_number = ""
    var recharge_switchvalue = ""
    var recharge_special = false
    var recharge_radio = 0
    var providername = ""
    var radioview = false
    var dth = false
    var dthprovidername = ""
    var fundno = ""
    var status = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = true
        resentotpbtn.titleLabel!.lineBreakMode = .ByWordWrapping
        resentotpbtn.titleLabel!.textAlignment = .Center;        resentotpbtn.setTitle("Resend\nOTP", forState: .Normal)
        backgroundlbl.layer.cornerRadius = backgroundlbl.frame.width/2
        backgroundlbl.layer.borderWidth = 8.0
       backgroundlbl.layer.borderColor = UIColor(red:230/255.0, green:175/255.0, blue:7/255.0, alpha:1.0).CGColor;        backgroundlbl.layer.masksToBounds = true
          logobacklbl.layer.cornerRadius = logobacklbl.frame.width/2
         logobacklbl.layer.masksToBounds = true
          verifybacklbl.layer.cornerRadius = verifybacklbl.frame.width/2
        verifybacklbl.layer.masksToBounds = true

         resendbacklbl.layer.cornerRadius = resendbacklbl.frame.width/2
        resendbacklbl.layer.masksToBounds = true

        logoimage.layer.cornerRadius =  logoimage.frame.size.height/2
        logoimage.clipsToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
        verifybtn.layer.cornerRadius = verifybtn.frame.size.height/2
        verifybtn.layer.masksToBounds = true
        resentotpbtn.layer.cornerRadius = resentotpbtn.frame.size.height/2
        resentotpbtn.layer.masksToBounds = true

        settextfield()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        otptextfield.delegate = self
        self.navigationController?.navigationBarHidden = true
        
    }
    
    func settextfield(){
        otptextfield.attributedPlaceholder = NSAttributedString(string:"OTP",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        let bottomLine = CALayer()
        bottomLine.frame = CGRectMake(0.0, otptextfield.frame.height - 1 , otptextfield.frame.width, 1.0)
        bottomLine.backgroundColor = UIColor.whiteColor().CGColor
        otptextfield.borderStyle = UITextBorderStyle.None
        otptextfield.layer.addSublayer(bottomLine)
        
    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
    func textField(textFieldToChange: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if(textFieldToChange == otptextfield){
            characterCountLimit = 6
        }
        if((textFieldToChange.placeholder == "New Password") || (textFieldToChange.placeholder == "Retype Password")){
            characterCountLimit = 4
        }
        let startingLength = textFieldToChange.text?.characters.count ?? 0
        let lengthToAdd = string.characters.count
        let lengthToReplace = range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
        return newLength <= characterCountLimit
    }
    
    @IBAction func backBtnAction(sender: AnyObject) {
        if(fromsignin){
            self.performSegueWithIdentifier("otp_signin", sender: self)
        }
        else if(fromsendmoney){
            self.performSegueWithIdentifier("otp_to_send", sender: self)
        }
        else if(fromrecharge){
            self.performSegueWithIdentifier("otp_to_recharge", sender: self)
        }
        else if(frompay){
            self.performSegueWithIdentifier("backtopay", sender: self)
        }
        else if(fromprofile){
            self.performSegueWithIdentifier("otp_profile", sender: self)
        }
        else if(fromnotification){
            self.performSegueWithIdentifier("otp_back_notification", sender: self)
        }
        else{
            self.performSegueWithIdentifier("from_otp", sender: self)
        }
    }
    
    func callalert(){
        self.presentViewController(Alert().alert("Sorry! Seems you forgot to fill some field..We need you to fill them and try again!", message: ""),animated: true,completion: nil)
    }
    func callalertforpasscode(){
        self.presentViewController(Alert().alert("Password doesn't match", message: ""),animated: true,completion: nil)
    }
    func callForgotpasswordAPI(){
        let forgotviewmodel = ForgotViewModel.init(customerId: Appconstant.customerid, yapcode: yapcode, otp: Appconstant.otp)!
        let serializedjson  = JSONSerializer.toJson(forgotviewmodel)
        print(serializedjson)
        sendrequesttoserverForForgotPasscode(Appconstant.BASE_URL+Appconstant.URL_FORGOT_PASSCODE, values: serializedjson)
    }
    
    func sendrequesttoserverForForgotPasscode(url : String, values: String)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        
        
        request.addValue("Basic YWRtaW46YWRtaW4=", forHTTPHeaderField: "Authorization")
        request.addValue(Appconstant.TENANT, forHTTPHeaderField: "TENANT")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = values.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    print(error)
                    self.activityIndicator.stopAnimating()
                    if Reachability.isConnectedToNetwork() == true {
                    } else {
                        print("Internet connection FAILED")
                        self.presentViewController(Alert().alert("Internet is being a bummer.. Please check net connections and try again!", message: ""),animated: true,completion: nil)
                        
                    }
                    return
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                    dispatch_async(dispatch_get_main_queue()) {
                        self.activityIndicator.stopAnimating()
                    }
                    dispatch_async(dispatch_get_main_queue()) {
                        self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                        
                    }
                }
                else{
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("responseString = \(responseString)")
                    let json = JSON(data: data!)
                    self.activityIndicator.stopAnimating()
                    let item = json["result"]
                    
                    if(item["success"].stringValue == "true"){
                        
                        Appconstant.pwd = self.yapcode
                        DBHelper().purzDB()
                        let databaseURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent("purz.db")
                        let databasePath = databaseURL.absoluteString
                        let purzDB = FMDatabase(path: databasePath as String)
                        if purzDB.open() {
                            
                            
                            let insertSQL = "UPDATE PROFILE_INFO SET YAP_CODE = '"+Appconstant.pwd+"' WHERE CUSTOMER_ID=" + Appconstant.customerid
                            
                            let result = purzDB.executeUpdate(insertSQL,
                                withArgumentsInArray: nil)
                            if !result {
                                //   status.text = "Failed to add contact"
                                print("Error: \(purzDB.lastErrorMessage())")
                                dispatch_async(dispatch_get_main_queue()) {
                                    self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                                    
                                }
                            }
                        }
                        purzDB.close()
                        
                        if(self.fromsignin){
                            dispatch_async(dispatch_get_main_queue()) {
                                self.sendrequesttoserverForGetCustomerDetail(Appconstant.BASE_URL+Appconstant.URL_FETCH_CUSTOMER_DETAILS_BY_MOBILENO+Appconstant.mobileno)
                            }
                        }
                        else {
                            dispatch_async(dispatch_get_main_queue()) {
                                var alertController:UIAlertController?
                                alertController?.view.tintColor = UIColor.blackColor()
                                alertController = UIAlertController(title: "Yay! You have successfully changed your password.",
                                    message: "",
                                    preferredStyle: .Alert)
                                
                                let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
                                    if(self!.fromsendmoney){
                                        self?.performSegueWithIdentifier("otp_sendmoney", sender: self)
                                    }
                                    else if(self!.fromrecharge){
                                        self!.performSegueWithIdentifier("otp_recharge", sender: self)
                                    }
                                    else if(self!.frompay){
                                        self!.performSegueWithIdentifier("otp_pay", sender: self)
                                    }
                                    else if(self!.fromprofile){
                                        self!.performSegueWithIdentifier("otp_home", sender: self)
                                    }
                                    else if(self!.fromnotification){
                                        self!.performSegueWithIdentifier("otp_notification", sender: self)
                                    }
                                    //                                        let sendmoneymodel = SendMoneyViewModel.init(amount: self!.amount, description: self!.remark, fromEntityId: Appconstant.customerid, businessId: self!.businessid, businessType: "EQWALLET", productId: "GENERAL", yapcode: Appconstant.pwd, transactionType: "C2C", transactionOrigin: "MOBILE")!
                                    //                                        let serializedjson  = JSONSerializer.toJson(sendmoneymodel)
                                    //                                        print(serializedjson)
                                    //                                        self?.activityIndicator.startAnimating()
                                    //                                        self!.sendrequesttoserverForSendMoney(Appconstant.BASE_URL+Appconstant.URL_PAY_MERCHANT, values: serializedjson)
                                    
                                    
                                    })
                                
                                alertController?.addAction(action)
                                self.presentViewController(alertController!, animated: true, completion: nil)
                                
                            }
                        }
                        
                    }
                        
                    else{
                        dispatch_async(dispatch_get_main_queue()) {
                            self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                            
                        }
                    }
                }
        }
        
        task.resume()
        
    }
    
    func sendrequesttoserverForSendMoney(url : String, values: String)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        
        
        request.addValue("Basic YWRtaW46YWRtaW4=", forHTTPHeaderField: "Authorization")
        request.addValue(Appconstant.TENANT, forHTTPHeaderField: "TENANT")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = values.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    print(error)
                    self.activityIndicator.stopAnimating()
                    if Reachability.isConnectedToNetwork() == true {
                    } else {
                        print("Internet connection FAILED")
                        self.presentViewController(Alert().alert("Internet is being a bummer.. Please check net connections and try again!", message: ""),animated: true,completion: nil)
                        
                    }
                    return
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                    dispatch_async(dispatch_get_main_queue()) {
                        self.activityIndicator.stopAnimating()
                    }
                }
                else{
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("responseString = \(responseString)")
                    let json = JSON(data: data!)
                    self.activityIndicator.stopAnimating()
                    let item = json["result"]
                    if(item["txId"].stringValue != ""){
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            var alertController:UIAlertController?
                            alertController?.view.tintColor = UIColor.blackColor()
                            alertController = UIAlertController(title: "Payment",
                                message: "Yey! Money send.",
                                preferredStyle: .Alert)
                            
                            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
                                self!.performSegueWithIdentifier("otp_home", sender: self)
                                
                                })
                            
                            alertController?.addAction(action)
                            self.presentViewController(alertController!, animated: true, completion: nil)
                        }
                    }
                    else{
                        dispatch_async(dispatch_get_main_queue()) {
                            self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                        }
                    }
                }
        }
        
        task.resume()
        
    }
    
    
    
    func sendrequesttoserverForGetCustomerDetail(url : String)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "GET"
        
        
        request.addValue("Basic YWRtaW46YWRtaW4=", forHTTPHeaderField: "Authorization")
        request.addValue(Appconstant.TENANT, forHTTPHeaderField: "TENANT")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    if Reachability.isConnectedToNetwork() == true {
                    } else {
                        print("Internet connection FAILED")
                        self.presentViewController(Alert().alert("Internet is being a bummer.. Please check net connections and try again!", message: ""),animated: true,completion: nil)
                        
                    }
                    return
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                    dispatch_async(dispatch_get_main_queue()) {
                        self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                    }
                }
                else{
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("responseString = \(responseString)")
                    let json = JSON(data: data!)
                    
                    let item = json["result"]
                    if(item["customerId"].stringValue != ""){
                        DBHelper().purzDB()
                        let databaseURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent("purz.db")
                        let databasePath = databaseURL.absoluteString
                        let purzDB = FMDatabase(path: databasePath as String)
                        if purzDB.open() {
                            let email = "empty"
                            let customertype = "WOC"
                            var question = "null"
                            var answer = "null"
                            if((item["description"].stringValue.rangeOfString(":")) != nil){
                                let description = item["description"].stringValue.componentsSeparatedByString(":")
                                question = description[0]
                                answer = description[1]
                            }
                            if(item["firstName"].stringValue == item["lastName"].stringValue){
                                Appconstant.customername = item["firstName"].stringValue
                            }
                            else{
                                Appconstant.customername = item["firstName"].stringValue + " " + item["lastName"].stringValue
                            }
                            
                            let insert = "INSERT INTO PROFILE_INFO (CUSTOMER_ID,YAP_CODE,CUSTOMER_NAME,MOBILE_NUMBER,EMAIL,CUSTOMER_TYPE) VALUES ('\(item["customerId"].stringValue)','"+Appconstant.pwd+"','"+Appconstant.customername+"','\(Appconstant.mobileno)','\(email)','\(customertype)')"
                            let result = purzDB.executeUpdate(insert,
                                withArgumentsInArray: nil)
                            
                            let insertsql = "INSERT INTO CUSTOMERDETAIL (CUSTOMER_ID,DATE_OF_BIRTH,CUSTOMER_BANK,IMAGE_PATH,ADDRESS_LINE_1,ADDRESS_LINE_2,CITY,STATE,PIN,SECURITY_QUESTION,SECURITY_ANSWER) VALUES ('\(Appconstant.customerid)','\(item["dob"].stringValue)','\("DCB")','\("empty")','\(item["address"].stringValue)','\(item["address2"].stringValue)','\(item["city"].stringValue)','\("Tamil nadu")','\(item["pincode"].stringValue)','\(question)','\(answer)')"
                            let result2 = purzDB.executeUpdate(insertsql,
                                withArgumentsInArray: nil)
                            
                            if !result && !result2{
                                //   status.text = "Failed to add contact"
                                print("Error: \(purzDB.lastErrorMessage())")
                                dispatch_async(dispatch_get_main_queue()) {
                                    self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                                    
                                }
                            }
                            else{
                                dispatch_async(dispatch_get_main_queue()) {
                                    self.performSegueWithIdentifier("otp_home", sender: self)
                                }
                            }
                        }
                    }
                    else{
                        dispatch_async(dispatch_get_main_queue()) {
                            self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                            
                        }
                    }
                }
        }
        
        task.resume()
        
    }
    
    
    
    @IBAction func verifyBtnAction(sender: AnyObject) {
        self.view.endEditing(true)
        if(self.otptextfield.text!.isEmpty){
            self.presentViewController(Alert().alert("Sorry! Seems you forgot to fill some field..We need you to fill them and try again!", message: ""),animated: true,completion: nil)
        }
        else if(self.otptextfield.text! != Appconstant.otp){
            self.presentViewController(Alert().alert(" OTP not a valid. Please retry", message: ""),animated: true,completion: nil)
        }
        else if(fromsignin){
            proceedfunction()
        }
        else if(fromsendmoney){
            proceedfunction()
        }
        else if(fromrecharge){
            proceedfunction()
        }
        else if frompay{
            proceedfunction()
        }
        else if fromprofile{
            proceedfunction()
        }
        else if fromnotification{
            proceedfunction()
        }
        else{
            if(Appconstant.newcustomer){
                
                let contactnumber = "+91" + Appconstant.mobileno
                let signupviewmodel = SignupViewModel.init(contactNo: contactnumber, otp: Appconstant.otp, firstName: Appconstant.firstname, lastName: Appconstant.lastname, emailAddress: Appconstant.email, yapCode: Appconstant.pwd, business: "EQWALLET", appVersion: "1.0", deviceType: "IOS", specialDate: "", appId: Appconstant.gcmid)!
                let serializedjson  = JSONSerializer.toJson(signupviewmodel)
                print(serializedjson)
                activityIndicator.stopAnimating()
                sendrequesttoserverForSignup(Appconstant.BASE_URL+Appconstant.URL_REGISTER, values: serializedjson)
                
            }
            else if(Appconstant.dummycustomer){
                self.activityIndicator.startAnimating()
                sendrequesttoserverForFetchCustomerDetails(Appconstant.BASE_URL+Appconstant.URL_FETCH_CUSTOMER_DETAILS_BY_MOBILENO+Appconstant.mobileno)
            }
        }
    }
    func proceedfunction(){
        if(self.otptextfield.text!.isEmpty){
            self.presentViewController(Alert().alert("Sorry! Seems you forgot to fill some field..We need you to fill them and try again!", message: ""),animated: true,completion: nil)
        }
        else if(self.otptextfield.text! != Appconstant.otp){
            self.presentViewController(Alert().alert(" OTP not a valid. Please retry", message: ""),animated: true,completion: nil)
        }
        else{
            var alertController:UIAlertController?
            alertController?.view.tintColor = UIColor.blackColor()
            alertController = UIAlertController(title: "Password",
                message: "",
                preferredStyle: .Alert)
            alertController!.addTextFieldWithConfigurationHandler(
                {(textField: UITextField!) in
                    
                    textField.placeholder = "New Password"
                    textField.delegate = self
                    textField.secureTextEntry  = true
                    textField.keyboardType = UIKeyboardType.NumberPad
                    
            })
            alertController!.addTextFieldWithConfigurationHandler(
                {(textField: UITextField!) in
                    
                    textField.placeholder = "Retype Password"
                    textField.delegate = self
                    textField.secureTextEntry  = true
                    textField.keyboardType = UIKeyboardType.NumberPad
                    
            })
            let action = UIAlertAction(title: "Proceed", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
                if let textFields = alertController?.textFields{
                    let theTextFields = textFields as [UITextField]
                    let newpasswordTxtField = theTextFields[0].text!
                    let retypepasswordTxtField = theTextFields[1].text!
                    if(newpasswordTxtField.isEmpty || retypepasswordTxtField.isEmpty){
                        self!.callalert()
                    }
                    else if(newpasswordTxtField != retypepasswordTxtField){
                        self!.callalertforpasscode()
                    }
                    else{
                        if(self!.fromsignin || self!.fromsendmoney || self!.fromrecharge || self!.frompay || self!.fromprofile || self!.fromnotification){
                            self!.yapcode = newpasswordTxtField
                            self!.activityIndicator.startAnimating()
                            self!.callForgotpasswordAPI()
                        }
                    }
                    
                }
                })
            let action1 = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
                
                })
            
            alertController?.addAction(action)
            alertController?.addAction(action1)
            self.presentViewController(alertController!, animated: true, completion: nil)
        }
    }
    
    
    
    
    func sendrequesttoserverForFetchCustomerDetails(url : String)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "GET"
        
        request.addValue("Basic YWRtaW46YWRtaW4=", forHTTPHeaderField: "Authorization")
        request.addValue(Appconstant.TENANT, forHTTPHeaderField: "TENANT")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    self.activityIndicator.stopAnimating()
                    if Reachability.isConnectedToNetwork() == true {
                    } else {
                        print("Internet connection FAILED")
                        self.presentViewController(Alert().alert("Internet is being a bummer.. Please check net connections and try again!", message: ""),animated: true,completion: nil)
                        
                    }
                    return
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                    dispatch_async(dispatch_get_main_queue()) {
                        self.activityIndicator.stopAnimating()
                    }
                    dispatch_async(dispatch_get_main_queue()) {
                        self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                    }
                }
                
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("responseString = \(responseString)")
                let json = JSON(data: data!)
                
                let item = json["result"]
                Appconstant.customerid = item["customerId"].stringValue
                print(item["customerId"].stringValue)
                dispatch_async(dispatch_get_main_queue()) {
                    
                    let contactnumber = "+91" + Appconstant.mobileno
                    let updatesignupviewmodel = UpdateSignupViewModel.init(contactNo: contactnumber, otp: Appconstant.otp, firstName: Appconstant.firstname, lastName: Appconstant.lastname, emailAddress: Appconstant.email, yapCode: Appconstant.pwd, business: "EQWALLET", appVersion: "1.0", deviceType: "IOS", specialDate: "", entityId: Appconstant.customerid, appGuid: Appconstant.gcmid)!
                    let serializedjson  = JSONSerializer.toJson(updatesignupviewmodel)
                    print(serializedjson)
                    self.sendrequesttoserverForUpdateSignup(Appconstant.BASE_URL+Appconstant.URL_UPDATE_ENTITY, values: serializedjson)
                }
        }
        
        task.resume()
        
    }
    
    func sendrequesttoserverForUpdateSignup(url : String, values: String)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        
        
        request.addValue("Basic YWRtaW46YWRtaW4=", forHTTPHeaderField: "Authorization")
        request.addValue(Appconstant.TENANT, forHTTPHeaderField: "TENANT")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = values.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    print(error)
                    self.activityIndicator.stopAnimating()
                    if Reachability.isConnectedToNetwork() == true {
                    } else {
                        print("Internet connection FAILED")
                        self.presentViewController(Alert().alert("Internet is being a bummer.. Please check net connections and try again!", message: ""),animated: true,completion: nil)
                        
                    }
                    return
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                    dispatch_async(dispatch_get_main_queue()) {
                        self.activityIndicator.stopAnimating()
                    }
                }
                else{
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("responseString = \(responseString)")
                    let json = JSON(data: data!)
                    self.activityIndicator.stopAnimating()
                    if(json["result"].stringValue == "true"){
                        DBHelper().purzDB()
                        let databaseURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent("purz.db")
                        let databasePath = databaseURL.absoluteString
                        let purzDB = FMDatabase(path: databasePath as String)
                        if purzDB.open() {
                            if(Appconstant.firstname == Appconstant.lastname){
                                //                                let customername = Appconstant.firstname
                                Appconstant.customername = Appconstant.firstname
                            }
                            else{
                                //                            let customername = Appconstant.firstname + " " + Appconstant.lastname
                                Appconstant.customername = Appconstant.firstname
                            }
                            let customertype = "WOC"
                            let notificationInsert = "INSERT INTO PROFILE_INFO (CUSTOMER_ID,YAP_CODE,CUSTOMER_NAME,MOBILE_NUMBER,EMAIL,CUSTOMER_TYPE) VALUES ('"+Appconstant.customerid+"','"+Appconstant.pwd+"','\(Appconstant.customername)','"+Appconstant.mobileno+"','"+Appconstant.email+"','\(customertype)')"
                            let result = purzDB.executeUpdate(notificationInsert,
                                withArgumentsInArray: nil)
                            
                            if !result {
                                //   status.text = "Failed to add contact"
                                print("Error: \(purzDB.lastErrorMessage())")
                                dispatch_async(dispatch_get_main_queue()) {
                                    self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                                    
                                }
                            }
                            else {
                                dispatch_async(dispatch_get_main_queue()) {
                                    var alertController:UIAlertController?
                                    alertController?.view.tintColor = UIColor.blackColor()
                                    alertController = UIAlertController(title: "Registered successfully!",
                                        message: "",
                                        preferredStyle: .Alert)
                                    
                                    let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
                                        dispatch_async(dispatch_get_main_queue()) {
                                            self!.performSegueWithIdentifier("to_complete_profile", sender: self)
                                        }
                                        
                                        })
                                    
                                    alertController?.addAction(action)
                                    self.presentViewController(alertController!, animated: true, completion: nil)
                                    
                                }
                            }
                            
                        }
                    }
                    else{
                        dispatch_async(dispatch_get_main_queue()) {
                            self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                            
                        }
                    }
                }
        }
        
        task.resume()
        
    }
    
    
    
    func sendrequesttoserverForSignup(url : String, values: String)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        
        
        request.addValue("Basic YWRtaW46YWRtaW4=", forHTTPHeaderField: "Authorization")
        request.addValue(Appconstant.TENANT, forHTTPHeaderField: "TENANT")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = values.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    print(error)
                    if Reachability.isConnectedToNetwork() == true {
                    } else {
                        print("Internet connection FAILED")
                        self.presentViewController(Alert().alert("Internet is being a bummer.. Please check net connections and try again!", message: ""),animated: true,completion: nil)
                        
                    }
                    return
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                    self.activityIndicator.stopAnimating()
                    dispatch_async(dispatch_get_main_queue()) {
                        self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                    }
                }
                else{
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("responseString = \(responseString)")
                    let json = JSON(data: data!)
                    self.activityIndicator.stopAnimating()
                    let item = json["result"]
                    print(item["entityId"].stringValue)
                    Appconstant.customerid = item["entityId"].stringValue
                    if(item["entityId"].stringValue != ""){
                        DBHelper().purzDB()
                        let databaseURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent("purz.db")
                        let databasePath = databaseURL.absoluteString
                        let purzDB = FMDatabase(path: databasePath as String)
                        if purzDB.open() {
                            if(Appconstant.firstname == Appconstant.lastname){
                                Appconstant.customername = Appconstant.firstname
                            }
                            else{
                                Appconstant.customername = Appconstant.firstname
                            }
                            let customertype = "WOC"
                            let notificationInsert = "INSERT INTO PROFILE_INFO (CUSTOMER_ID,YAP_CODE,CUSTOMER_NAME,MOBILE_NUMBER,EMAIL,CUSTOMER_TYPE) VALUES ('"+item["entityId"].stringValue+"','"+Appconstant.pwd+"','\(Appconstant.customername)','"+Appconstant.mobileno+"','"+Appconstant.email+"','\(customertype)')"
                            let result = purzDB.executeUpdate(notificationInsert,
                                withArgumentsInArray: nil)
                            
                            if !result {
                                //   status.text = "Failed to add contact"
                                print("Error: \(purzDB.lastErrorMessage())")
                            }
                            else {
                                dispatch_async(dispatch_get_main_queue()) {
                                    var alertController:UIAlertController?
                                    alertController?.view.tintColor = UIColor.blackColor()
                                    alertController = UIAlertController(title: "Registered successfully!",
                                        message: "",
                                        preferredStyle: .Alert)
                                    
                                    let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
                                        dispatch_async(dispatch_get_main_queue()) {
                                            self!.performSegueWithIdentifier("otp_homepage", sender: self)
                                        }
                                        
                                        })
                                    
                                    alertController?.addAction(action)
                                    self.presentViewController(alertController!, animated: true, completion: nil)
                                    
                                }
                                
                            }
                        }
                        
                    }
                    else{
                        dispatch_async(dispatch_get_main_queue()) {
                            self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                            
                        }
                    }
                }
        }
        
        task.resume()
        
    }
    
    
    
    @IBAction func resendotpBtnAction(sender: AnyObject) {
        print(Appconstant.WEB_URL+Appconstant.URL_GENERATE_OTP+Appconstant.mobileno)
        self.sendrequesttoserverForGenerateOTP(Appconstant.WEB_URL+Appconstant.URL_GENERATE_OTP+Appconstant.mobileno)
    }
    func sendrequesttoserverForGenerateOTP(url : String)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "GET"
        request.addValue("Basic YWRtaW46YWRtaW4=", forHTTPHeaderField: "Authorization")
        request.addValue(Appconstant.TENANT, forHTTPHeaderField: "TENANT")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    if Reachability.isConnectedToNetwork() == true {
                    } else {
                        print("Internet connection FAILED")
                        self.presentViewController(Alert().alert("Internet is being a bummer.. Please check net connections and try again!", message: ""),animated: true,completion: nil)
                        
                    }
                    return
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                    dispatch_async(dispatch_get_main_queue()) {
                    }
                }
                
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("responseString = \(responseString)")
                let json = JSON(data: data!)
                
                let item = json["result"]
                if((item["success"].stringValue == "true")&&(item["isCustomerExists"].stringValue == "true")){
                    dispatch_async(dispatch_get_main_queue()) {
                        Appconstant.otp = item["otp"].stringValue
                        Appconstant.customerid = item["customerId"].stringValue
                        Appconstant.customername = item["customerName"].stringValue
                        Appconstant.dummycustomer = true
                        Appconstant.newcustomer = false
                    }
                }
                else if((item["success"].stringValue == "true")&&(item["isCustomerExists"].stringValue == "false")){
                    dispatch_async(dispatch_get_main_queue()) {
                        Appconstant.otp = item["otp"].stringValue
                        Appconstant.newcustomer = true
                        Appconstant.dummycustomer = false
                    }
                }
                else{
                    dispatch_async(dispatch_get_main_queue()) {
                        self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                        
                    }
                }
        }
        
        task.resume()
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "from_otp") {
            let nextview = segue.destinationViewController as! SignupViewController
            nextview.segue = true
        }
        if(segue.identifier == "otp_sendmoney"){
            let nextview = segue.destinationViewController as! SendOrAskMoneyViewController
            nextview.contact_number = businessid
            nextview.amount_value = amount
            nextview.remarks_txt = remark
            nextview.fromotp = true
        }
//        if(segue.identifier == "otp_recharge"){
//            let nextview = segue.destinationViewController as! RechargeorPayBill
////            nextview.recharge_amount = self.recharge_amount
////            nextview.operatorcode = self.recharge_operatorcode
////            nextview.recharge_number = self.recharge_number
////            nextview.switchvalue = self.recharge_switchvalue
////            nextview.special = self.recharge_special
////            nextview.radio = self.recharge_radio
////            nextview.providername = self.providername
////            nextview.radioview = radioview
////            nextview.fromotp = true
////            
////            
////            nextview.pre_operatorCode = self.pre_operatorCode
////            nextview.pre_operatorName = self.pre_operatorName
////            nextview.pre_operatorId = self.pre_operatorId
////            nextview.pre_operatorType = self.pre_operatorType
////            nextview.pre_special = self.pre_special
////            nextview.post_operatorCode = self.post_operatorCode
////            nextview.post_operatorName = self.post_operatorName
////            nextview.post_operatorId = self.post_operatorId
////            nextview.post_operatorType = self.post_operatorType
////            nextview.post_special = self.post_special
////            nextview.dth_operatorCode = self.dth_operatorCode
////            nextview.dth_operatorName = self.dth_operatorName
////            nextview.dth_operatorId = self.dth_operatorId
////            nextview.dth_operatorType = self.dth_operatorType
////            nextview.dth_special = self.dth_special
////            nextview.dth = dth
////            nextview.dthprovidername = dthprovidername
//        }
        if(segue.identifier == "backtopay"){
            let nextview = segue.destinationViewController as! PayatStoreViewController
            nextview.merchantcode = merchantcode
            nextview.paystoreamount = paystoreamount
            nextview.payremarks = payremarks
            nextview.qrdata = qrdata
        }
        if(segue.identifier == "otp_pay"){
            let nextview = segue.destinationViewController as! PayatStoreViewController
            nextview.merchantcode = merchantcode
            nextview.paystoreamount = paystoreamount
            nextview.payremarks = payremarks
            nextview.qrdata = qrdata
            nextview.fromotp = true
        }
        if(segue.identifier == "otp_notification"){
            let nextview = segue.destinationViewController as! NotificationViewController
            nextview.fromotp = true
            nextview.fundno = fundno
            nextview.status = status
            nextview.amount = self.notificationamount
            nextview.fromid = fromid
            nextview.toid = toid
            nextview.time = time
            nextview.isread = isread
            nextview.phonenumber = phonenumber
            nextview.request_amt_to_us = request_amt_to_us
            nextview.entityid = entityid
            nextview.approveordecline = approveordecline
            nextview.fundnumber = fundnumber
            nextview.index = index
        }
        
        
    }
    
    var frompay = false
    var merchantcode = ""
    var paystoreamount = ""
    var payremarks = ""
    var qrdata = ""
    
    
    
    var notificationamount = [String]()
    var fromid = [String]()
    var toid = [String]()
    var time = [String]()
    var isread = [Bool]()
    var phonenumber = [String]()
    var request_amt_to_us = [Bool]()
    var entityid = [String]()
    var approveordecline = [String]()
    var fundnumber = [String]()
    var index = 0
    
    
}

