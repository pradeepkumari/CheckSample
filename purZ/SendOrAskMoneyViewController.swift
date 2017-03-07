//
//  SendOrAskMoneyViewController.swift
//  Cippy
//
//  Created by apple on 23/11/16.
//  Copyright © 2016 vertace. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI
class SendOrAskMoneyViewController: UIViewController, CNContactPickerDelegate, UITextFieldDelegate, UITextViewDelegate,UITabBarControllerDelegate {
      @IBOutlet weak var badgebtn: UIButton!
     @IBOutlet weak var contactnotxtField: UITextField!
    @IBOutlet weak var amounttxtField: UITextField!
       @IBOutlet weak var balancelbl: UILabel!
    
    @IBOutlet weak var remarksTxtField: UITextField!
    @IBOutlet weak var moneybtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
       @IBOutlet weak var cancelbtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var viewForSegment: UIView!
    @IBOutlet weak var segmentlbl1: UILabel!
    
    @IBOutlet weak var segmentlbl2: UILabel!
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    var sendmoney = true
    var askmoney = false
    var phonenumber = [String]()
    var characterCountLimit = 4
    var fromotp = false
    var contact_number = ""
    var amount_value = ""
    var remarks_txt = ""
    override func viewDidLoad() {
        super.viewDidLoad()
         Appconstant.SideMenu = 0;
        tabBarController?.delegate = self
       remarksTxtField.delegate = self
        navigationController?.navigationBarHidden = true
        segmentlbl1.frame.size.width = viewForSegment.frame.size.width/2.0 + 10
        segmentlbl2.frame.size.width = segmentController.frame.size.width/2.0
        segmentlbl1.layer.backgroundColor = UIColor.whiteColor().CGColor
        segmentlbl2.layer.backgroundColor = UIColor(red: 250.0/255.0, green: 194.0/255.0, blue: 35.0/255.0, alpha: 1).CGColor
        print("Segment Widths==>>")
        print(segmentController.frame.size.width)
        print(self.view.frame.size.width)
        print(viewForSegment.frame.size.width)
        print(segmentlbl1.frame.size.width)
        print(segmentlbl2.frame.size.width)
        
let titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
              UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, forState: .Normal)
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, forState: .Selected)

        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 400)
        remarksTxtField.layer.cornerRadius = 5
        remarksTxtField.layer.borderColor = UIColor(red: 225.0/255.0, green: 228.0/255.0, blue: 229.0/255.0, alpha: 1).CGColor

        moneybtn.layer.cornerRadius = 20
        moneybtn.layer.borderWidth = 2.5;
        moneybtn.layer.borderColor = UIColor.greenColor().CGColor
        cancelbtn.layer.cornerRadius = 20
        cancelbtn.layer.borderWidth = 2.5;
        cancelbtn.layer.borderColor = UIColor.redColor().CGColor
        (segmentController.subviews[1] as UIView).backgroundColor = UIColor(red: 252.0/255.0, green: 207.0/255.0, blue: 80.0/255.0, alpha: 1)
//        (segmentController.subviews[1] as UIView).tintColor = UIColor(red: 250.0/255.0, green: 194.0/255.0, blue: 35.0/255.0, alpha: 1)
//        (segmentController.subviews[0] as UIView).tintColor = UIColor(red: 230/255.0, green: 175.0/255.0, blue: 10.0/255.0, alpha: 1)
//        (segmentController.subviews[0] as UIView).backgroundColor = UIColor.redColor().CGColor
        (segmentController.subviews[0] as UIView).backgroundColor = UIColor(red: 252.0/255.0, green: 207.0/255.0, blue: 80.0/255.0, alpha: 1)
        if(Appconstant.notificationcount > 0){
            badgebtn.hidden = false
            badgebtn.setTitle("\(Appconstant.notificationcount)", forState: .Normal)
            badgebtn.userInteractionEnabled = false
        }
        else{
            badgebtn.hidden = true
        }
        if fromotp{
            contactnotxtField.text = contact_number
            amounttxtField.text = amount_value
       //     remarkstxtField.textview = remarks_txt
           moneybtn.layer.cornerRadius = 15
            moneybtn.layer.borderWidth = 3;
            moneybtn.layer.borderColor = UIColor.greenColor().CGColor
           cancelbtn.layer.cornerRadius = 15
           cancelbtn.layer.borderWidth = 3;
           cancelbtn.layer.borderColor = UIColor.redColor().CGColor

            callserverforsendmoney()
        }
        else{
            badgebtn.layer.cornerRadius  = self.badgebtn.frame.size.height/2
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
            scrollView.addGestureRecognizer(tap)
            textfield()
        }
    }
    
    
    func textViewDidChange(textView: UITextView)
    {
        print(textView.text);
    }
    func textfield(){
        balancelbl.text = self.balancelbl.text! + " \u{20B9} " + Appconstant.mainbalance
     /*  if `switch`.on{
            contactnotxtField.placeholder = "Select Payee"
            moneybtn.setTitle("Ask For Money", forState: .Normal)
        }
       else{
            contactnotxtField.placeholder = "Select Receiver"
            moneybtn.setTitle("Send Money", forState: .Normal)
        }*/
        moneybtn.layer.cornerRadius = 20
        
    }
    @IBAction func segmentBtnAction(sender: AnyObject) {
   if(segmentController.selectedSegmentIndex == 0)
        
   {
    segmentlbl1.layer.backgroundColor = UIColor.whiteColor().CGColor
    segmentlbl2.layer.backgroundColor = UIColor(red: 250.0/255.0, green: 194.0/255.0, blue: 35.0/255.0, alpha: 1).CGColor
            }
        else
   {
    segmentlbl2.layer.backgroundColor = UIColor.whiteColor().CGColor
    segmentlbl1.layer.backgroundColor = UIColor(red: 250.0/255.0, green: 194.0/255.0, blue: 35.0/255.0, alpha: 1).CGColor
     }
         switch segmentController.selectedSegmentIndex {
        case 0:
//            (segmentController.subviews[1] as UIView).backgroundColor = UIColor.whiteColor()
//                        (segmentController.subviews[1] as UIView).tintColor = UIColor(red: 250.0/255.0, green: 194.0/255.0, blue: 35.0/255.0, alpha: 1)
//            (segmentController.subviews[0] as UIView).tintColor = UIColor(red: 230/255.0, green: 175.0/255.0, blue: 10.0/255.0, alpha: 1)
////            (segmentController.subviews[0] as UIView).backgroundColor = UIColor.whiteColor();
            moneybtn.setTitle("SEND MONEY", forState: .Normal)
            askmoney = false
            sendmoney = true
            view.endEditing(true)
                    case 1:
//            (segmentController.subviews[0] as UIView).backgroundColor = UIColor.whiteColor()
//            (segmentController.subviews[0] as UIView).tintColor = UIColor(red: 250.0/255.0, green: 194.0/255.0, blue: 35.0/255.0, alpha: 1)
//            (segmentController.subviews[1] as UIView).tintColor = UIColor(red: 230/255.0, green: 175.0/255.0, blue: 10.0/255.0, alpha: 1)
//            (segmentController.subviews[1] as UIView).backgroundColor = UIColor.whiteColor()
        moneybtn.setTitle("ASK MONEY", forState: .Normal)

            askmoney = true
            sendmoney = false
            view.endEditing(true)
        default:
            break;
        }
           }
 /*
    func removeBorders() {
        segmentController.setBackgroundImage(imageWithColor(UIColor.clearColor()), forState: .Normal, barMetrics: .Default)
        segmentController.setBackgroundImage(imageWithColor(UIColor.clearColor()), forState: .Selected, barMetrics: .Default)
        segmentController.setDividerImage(imageWithColor(UIColor.clearColor()), forLeftSegmentState: .Normal, rightSegmentState: .Normal, barMetrics: .Default)
    }
    func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image
    }*/

// 
//    @IBAction func switchaction(sender: AnyObject) {
//      /*  if `switch`.on{
//            //            sendmoneylbl.font = UIFont.systemFontOfSize(16, weight: UIFontWeightThin)
//            //            askformoneylbl.font = UIFont.systemFontOfSize(16, weight: UIFontWeightBold)
//            sendmoneylbl.font = UIFont(name: "Quicksand-Regular", size: 16)
//            askformoneylbl.font = UIFont(name: "Quicksand-Bold", size: 16)
//            contactnotxtField.placeholder = "Select Payee"
//            moneybtn.setTitle("Ask For Money", forState: .Normal)
//            askmoney = true
//            sendmoney = false
//        }
//        else{
//            //            sendmoneylbl.font = UIFont.systemFontOfSize(16, weight: UIFontWeightBold)
//            //            askformoneylbl.font = UIFont.systemFontOfSize(16, weight: UIFontWeightThin)
//            sendmoneylbl.font = UIFont(name: "Quicksand-Bold", size: 16)
//            askformoneylbl.font = UIFont(name: "Quicksand-Regular", size: 16)
//            contactnotxtField.placeholder = "Select Receiver"
//            moneybtn.setTitle("Send Money", forState: .Normal)
//            askmoney = false
//            sendmoney = true
//        }*/
//    }
//    
    func dismissKeyboard(){
        self.view.endEditing(true)
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 400)
    }
    @IBAction func contactpickerBtnAction(sender: AnyObject) {
        let contactPickerViewController = CNContactPickerViewController()
        
        contactPickerViewController.predicateForEnablingContact = NSPredicate(format: "Phonenumber != nil")
        
        contactPickerViewController.delegate = self
        
        presentViewController(contactPickerViewController, animated: true, completion: nil)
    }
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        phonenumber.removeAll()
        var phonenos = [String]()
        for phoneno:CNLabeledValue in contact.phoneNumbers{
            let numVal = phoneno.value as! CNPhoneNumber
            phonenos.append(numVal.stringValue)
            
        }
        setcontactnumber(phonenos)
        navigationController?.popViewControllerAnimated(true)
    }
    
    func setcontactnumber(numbers: [String]){
        for number1 in numbers {
            var number = ""
            number = number1.stringByReplacingOccurrencesOfString("+", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            number = number.stringByReplacingOccurrencesOfString(") ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            number = number.stringByReplacingOccurrencesOfString("(", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            number = number.stringByReplacingOccurrencesOfString(")", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            number = number.stringByReplacingOccurrencesOfString("-", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            number = number.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            number = number.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            if(number.characters.count == 10){
                phonenumber.append(number)
            }
            else{
                var str = number.componentsSeparatedByString("91")
                print(str.count)
                if(str.count == 1 || str.count > 2){
                    phonenumber.append(number)
                }
                else if(str[1].characters.count > 5){
                    
                    phonenumber.append(str[1])
                }
                else{
                    phonenumber.append(number)
                }
            }
            
            
            
        }
        if(phonenumber.count == 0){
            self.presentViewController(Alert().alert("Number not found", message: ""),animated: true,completion: nil)
        }
        else if(phonenumber.count == 1){
            contactnotxtField.text = phonenumber[0]
            amounttxtField.becomeFirstResponder()
        }
        else{
            let alertView: UIAlertView = UIAlertView()
            alertView.delegate = self
            alertView.title = "Pick a number.."
            for(var i = 0; i<phonenumber.count; i++){
                alertView.addButtonWithTitle(phonenumber[i])
            }
            alertView.addButtonWithTitle("Cancel")
            alertView.show()
        }
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        if buttonIndex == phonenumber.count{
            
        }
        else{
            contactnotxtField.text = phonenumber[buttonIndex]
            amounttxtField.becomeFirstResponder()
        }
    }
    
    @IBAction func sendoraskmoneyBtnAction(sender: AnyObject) {
        contact_number = self.contactnotxtField.text!
        amount_value = self.amounttxtField.text!
        remarks_txt = self.remarksTxtField.text!
        if(self.contactnotxtField.text!.characters.count < 10){
            dispatch_async(dispatch_get_main_queue()) {
                self.presentViewController(Alert().alert("Type a mobile number or directly add from saved contacts here", message: ""),animated: true,completion: nil)
            }
        }
        else if(self.contactnotxtField.text! == Appconstant.mobileno) {
            if sendmoney{
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(Alert().alert("You cannot send money to yourself!", message: ""),animated: true,completion: nil)
                }
            }
            else if askmoney{
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(Alert().alert("You cannot request funds to yourself!", message: ""),animated: true,completion: nil)
                }
            }
        }
        else if((self.amounttxtField.text! == "") || (Double(self.amounttxtField.text!) < 1.0) || (Double(self.amounttxtField.text!) > 20000.0)){
            dispatch_async(dispatch_get_main_queue()) {
                if self.sendmoney{
                    self.presentViewController(Alert().alert("Pick any amount up to Rs 20,000", message: ""),animated: true,completion: nil)
                }
                else{
                    self.presentViewController(Alert().alert("Pick any amount up to Rs 20,000", message: ""),animated: true,completion: nil)
                }
            }
        }
        else if sendmoney{
            print(Double(self.amounttxtField.text!))
            print(Double(Appconstant.mainbalance)!)
            if(Double(self.amounttxtField.text!) > Double(Appconstant.mainbalance)!){
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(Alert().alert("Ouch! Insufficient Funds..Add some money instantly, it’s simple!", message: ""),animated: true,completion: nil)
                }
            }
            else{
                alertforproceed()
            }
            
        }
        else if askmoney{
            activityIndicator.startAnimating()
            let cont_no = "+91" + self.contactnotxtField.text!
            let checkcustomerViewModel = CheckRegistrationViewModel.init(business: "EQWALLET", businessId: cont_no)!
            let serializedjson  = JSONSerializer.toJson(checkcustomerViewModel)
            print(serializedjson)
            sendrequesttoserverForCheckCustomer(Appconstant.BASE_URL+Appconstant.URL_CHECK_CUSTOMER_REGISTRATION, values: serializedjson)
        }
    }
    
    func sendrequesttoserverForCheckCustomer(url : String, values: String)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        
        
        request.addValue("BaYsic YWRtaW46WRtaW4=", forHTTPHeaderField: "Authorization")
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
                    self.activityIndicator.stopAnimating()
                    dispatch_async(dispatch_get_main_queue()) {
                        self.presentViewController(Alert().alert("Incorrect Password", message: ""),animated: true,completion: nil)
                    }
                }
                else{
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("responseString = \(responseString)")
                    let json = JSON(data: data!)
                    
                    let item = json["result"]
                    if(item["existingCustomer"].stringValue == "true"){
                        dispatch_async(dispatch_get_main_queue()) {
                            var amount = ""
                            let amount_two_decimal = String(format: "%.2f", Double(self.amounttxtField.text!)!)
                            let checkamountdecimal = amount_two_decimal.componentsSeparatedByString(".")
                            if(checkamountdecimal[1].characters.count == 1){
                                amount = amount_two_decimal + "0"
                            }
                            else{
                                amount = amount_two_decimal
                            }
                            let businessid = "+91" + self.contactnotxtField.text!
                            
                            let askmoneymodel = AskMoneyViewModel.init(amount: amount, description: self.remarksTxtField.text!, toEntityId: Appconstant.customerid, businessId: businessid, productId: "GENERAL", transactionType: "C2C", transactionOrigin: "MOBILE")!
                            let serializedjson  = JSONSerializer.toJson(askmoneymodel)
                            print(serializedjson)
                            self.sendrequesttoserverForAskMoney(Appconstant.BASE_URL+Appconstant.URL_REQUEST_FUNDS, values: serializedjson)
                        }
                        
                    }
                    else if(item["existingCustomer"].stringValue == "false"){
                        dispatch_async(dispatch_get_main_queue()) {
                            let contact_no = "+91" + self.contactnotxtField.text!
                            let dummyregistermodel = DummyRegisterViewModel.init(contactNo: contact_no, firstName: "merchant", lastName: "name", business: "DCBWALLET_DIRECT")!
                            let serializedjson  = JSONSerializer.toJson(dummyregistermodel)
                            print(serializedjson)
                            self.sendrequesttoserverForDummyRegister(Appconstant.BASE_URL+Appconstant.URL_REGISTER, values: serializedjson)
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
    func sendrequesttoserverForDummyRegister(url : String, values: String)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        
        
        request.addValue("BaYsic YWRtaW46WRtaW4=", forHTTPHeaderField: "Authorization")
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
                    dispatch_async(dispatch_get_main_queue()) {
                        self.activityIndicator.stopAnimating()
                    }
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
                    if(item["entityId"].stringValue != ""){
                        dispatch_async(dispatch_get_main_queue()) {
                            var amount = ""
                            let amount_two_decimal = String(format: "%.2f", Double(self.amounttxtField.text!)!)
                            let checkamountdecimal = amount_two_decimal.componentsSeparatedByString(".")
                            if(checkamountdecimal[1].characters.count == 1){
                                amount = amount_two_decimal + "0"
                            }
                            else{
                                amount = amount_two_decimal
                            }
                            
                            let businessid = "+91" + self.contactnotxtField.text!
                            
                            let askmoneymodel = AskMoneyViewModel.init(amount: amount, description: self.remarksTxtField.text!, toEntityId: Appconstant.customerid, businessId: businessid, productId: "GENERAL", transactionType: "C2C", transactionOrigin: "MOBILE")!
                            let serializedjson  = JSONSerializer.toJson(askmoneymodel)
                            print(serializedjson)
                            self.sendrequesttoserverForAskMoney(Appconstant.BASE_URL+Appconstant.URL_REQUEST_FUNDS, values: serializedjson)
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
    
    func sendrequesttoserverForAskMoney(url : String, values: String)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        
        
        request.addValue("BaYsic YWRtaW46WRtaW4=", forHTTPHeaderField: "Authorization")
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
                    dispatch_async(dispatch_get_main_queue()) {
                        self.activityIndicator.stopAnimating()
                    }
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                    }
                }
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("responseString = \(responseString)")
                Appconstant.updatenotification = true
                self.updatetransactionDB()
                let json = JSON(data: data!)
                self.activityIndicator.stopAnimating()
                let item1 = json["result"]
                let item = item1["requestfunds"]
                if(item["pkey"].stringValue != ""){
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        var alertController:UIAlertController?
                        alertController?.view.tintColor = UIColor.blackColor()
                        alertController = UIAlertController(title: "Yey! Your request for money is sent.",
                            message: "",
                            preferredStyle: .Alert)
                        
                        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
                            dispatch_async(dispatch_get_main_queue()) {
                                self!.performSegueWithIdentifier("ask_home", sender: self)
                            }
                            
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
                //                }
        }
        
        task.resume()
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == contactnotxtField{
            amounttxtField.becomeFirstResponder()
        }
        if textField == amounttxtField{
            remarksTxtField.becomeFirstResponder()
        }
        
        return true // We do not want UITextField to insert line-breaks.
    }
    func textFieldShouldBeginEditing(state: UITextField) -> Bool {
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 550)
        return true
    }
    func textField(textFieldToChange: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 550)
        if(textFieldToChange.placeholder == "Enter 4 digit Password"){
            characterCountLimit = 4
        }
        else if(textFieldToChange == contactnotxtField){
            characterCountLimit = 10
        }
        else{
            characterCountLimit = 50
        }
        if((amounttxtField.text?.rangeOfString(".")) != nil){
            let strcount = amounttxtField.text! + string
            let strarray = strcount.componentsSeparatedByString(".")
            
            for(var i = 0; i<strarray.count; i++){
                if i == 1{
                    if strarray[1].isEmpty{
                        
                    }
                    else{
                        if strarray[1].characters.count == 3{
                            return false
                        }
                        else{
                            return true
                        }
                    }
                }
            }
            
        }
        let startingLength = textFieldToChange.text?.characters.count ?? 0
        let lengthToAdd = string.characters.count
        let lengthToReplace = range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
        return newLength <= characterCountLimit
    }
    
    func alertforproceed(){
        var alertController:UIAlertController?
        alertController?.view.tintColor = UIColor.blackColor()
        alertController = UIAlertController(title: "PASSWORD",
            message: "Please enter your 4 digit secret password. This is necessary to initiate every transaction",
            preferredStyle: .Alert)
        alertController!.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                
                textField.placeholder = "Enter 4 digit Password"
                textField.delegate = self
                textField.secureTextEntry  = true
                textField.keyboardType = UIKeyboardType.NumberPad
                
        })
        let action = UIAlertAction(title: "Proceed", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
            if let textFields = alertController?.textFields{
                let theTextFields = textFields as [UITextField]
                let password = theTextFields[0].text!
                if((password == "") || (password.characters.count < 4) || (Appconstant.pwd != password)){
                    self!.alert()
                }
                else{
                    self!.callserverforsendmoney()
                }
                
            }
            })
        let action1 = UIAlertAction(title: "Forgot?", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
            
            print(Appconstant.WEB_URL+Appconstant.URL_GENERATE_OTP+Appconstant.mobileno)
            self!.sendrequesttoserverForForgotPassword(Appconstant.WEB_URL+Appconstant.URL_GENERATE_OTP+Appconstant.mobileno)
            
            })
        let action2 = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
            
            })
        
        alertController?.addAction(action)
        alertController?.addAction(action1)
        alertController?.addAction(action2)
        self.presentViewController(alertController!, animated: true, completion: nil)
    }
    
    func callserverforsendmoney(){
        let businessid = "+91" + self.contactnotxtField.text!
        let sendmoneymodel = SendMoneyViewModel.init(amount: self.amounttxtField.text!, description: self.remarksTxtField.text!, fromEntityId: Appconstant.customerid, businessId: businessid, businessType: "EQWALLET", productId: "GENERAL", yapcode: Appconstant.pwd, transactionType: "C2C", transactionOrigin: "MOBILE")!
        let serializedjson  = JSONSerializer.toJson(sendmoneymodel)
        print(serializedjson)
        self.activityIndicator.startAnimating()
        self.sendrequesttoserverForSendMoney(Appconstant.BASE_URL+Appconstant.URL_PAY_MERCHANT, values: serializedjson)
    }
    
    
    func sendrequesttoserverForSendMoney(url : String, values: String)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        
        
        request.addValue("BaYsic YWRtaW46WRtaW4=", forHTTPHeaderField: "Authorization")
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
                    dispatch_async(dispatch_get_main_queue()) {
                        self.activityIndicator.stopAnimating()
                    }
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
                    self.activityIndicator.stopAnimating()
                    let item = json["result"]
                    if(item["txId"].stringValue != ""){
                        self.updatetransactionDB()
                        dispatch_async(dispatch_get_main_queue()) {
                            var alertController:UIAlertController?
                            alertController?.view.tintColor = UIColor.blackColor()
                            alertController = UIAlertController(title: "Payment",
                                message: "Yey! Money sent.",
                                preferredStyle: .Alert)
                            
                            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
                                dispatch_async(dispatch_get_main_queue()) {
                                    self!.performSegueWithIdentifier("ask_home", sender: self)
                                }
                                
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
    
    func updatetransactionDB(){
        DBHelper().purzDB()
        let databaseURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent("purz.db")
        let databasePath = databaseURL.absoluteString
        let purzDB = FMDatabase(path: databasePath as String)
        
        if purzDB.open() {
            let delete = "DELETE FROM TRANSACTIONS"
            
            let result = purzDB.executeUpdate(delete,
                withArgumentsInArray: nil)
            
            if !result{
                //   status.text = "Failed to add contact"
                print("Error: \(purzDB.lastErrorMessage())")
            }
            
        }
        purzDB.close()
        
        let request = NSMutableURLRequest(URL: NSURL(string: Appconstant.BASE_URL+Appconstant.URL_FETCH_RECENT_TRANSACTIONS+Appconstant.customerid+"?pageNo=1&pageSize=10")!)
        request.HTTPMethod = "GET"
        request.addValue("BaYsic YWRtaW46WRtaW4=", forHTTPHeaderField: "Authorization")
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
                    self.view.userInteractionEnabled = true
                    
                }
                
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("responseString = \(responseString)")
                let json = JSON(data: data!)
                DBHelper().purzDB()
                let databaseURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent("purz.db")
                let databasePath = databaseURL.absoluteString
                let purzDB = FMDatabase(path: databasePath as String)
                
                for item1 in json["result"].arrayValue{
                    let item = item1["transaction"]
                    
                    var transactionamt = ""
                    var ben_id = ""
                    var trans_date = ""
                    var descriptions = ""
                    let balance_two_decimal = String(format: "%.2f", item["amount"].doubleValue)
                    let amt = balance_two_decimal.componentsSeparatedByString(".")
                    if(amt[1].characters.count == 1){
                        let finalamount = balance_two_decimal + "0"
                        transactionamt = finalamount
                    }
                    else{
                        transactionamt = balance_two_decimal
                    }
                    if(!item["beneficiaryId"].stringValue.isEmpty){
                        let benid = item["beneficiaryId"].stringValue.componentsSeparatedByString("+91")
                        print(benid)
                        var i = 0
                        for(i=0; i<benid.count; i++){
                            
                        }
                        ben_id = benid[i-1]
                    }
                    else{
                        ben_id = item["beneficiaryId"].stringValue
                    }
                    let date = NSDate(timeIntervalSince1970: item["time"].doubleValue/1000.0)
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd MMM"
                    dateFormatter.timeZone = NSTimeZone(name: "UTC")
                    let dateString = dateFormatter.stringFromDate(date)
                    if(!dateString.isEmpty){
                        let datearray = dateString.componentsSeparatedByString(" ")
                        if(datearray[0] != "11" && datearray[0].characters.last == "1"){
                            let correctdate = datearray[0] + "st " + datearray[1]
                            trans_date = correctdate
                        }
                        else if(datearray[0] != "12" && datearray[0].characters.last == "2"){
                            let correctdate = datearray[0] + "nd " + datearray[1]
                            trans_date = correctdate
                        }
                        else if(datearray[0] != "13" && datearray[0].characters.last == "3"){
                            let correctdate = datearray[0] + "rd " + datearray[1]
                            trans_date = correctdate
                        }
                        else{
                            let correctdate = datearray[0] + "th " + datearray[1]
                            trans_date = correctdate
                        }
                        
                    }
                    let matches = self.matchesForRegexInText("[0-9]", text: item["description"].stringValue)
                    let desc = matches.joinWithSeparator("")
                    descriptions = desc
                    
                    if purzDB.open() {
                        
                        let insert = "INSERT INTO TRANSACTIONS (AMOUNT,BENEFICIARY_ID,TRANSACTION_TYPE,TYPE,TIME,TRANSACTION_STATUS,TX_REF,BENEFICIARY_NAME,DESCRIPTION,OTHER_PARTY_NAME,OTHER_PARTY_ID,TXN_ORIGIN) VALUES"
                        let value0 =  "('"+transactionamt+"','\(ben_id)','\(item["transactionType"].stringValue)','\(item["type"].stringValue)',"
                        let value1 = "'"+trans_date+"','\(item["transactionStatus"].stringValue)','\(item["txRef"].stringValue)','\(item["beneficiaryName"].stringValue)',"
                        let value2 = "'\(descriptions)','\(item["otherPartyName"].stringValue)','\(item["otherPartyId"].stringValue)','\(item["txnOrigin"].stringValue)')"
                        let insertsql = insert+value0+value1+value2
                        let result = purzDB.executeUpdate(insertsql,
                            withArgumentsInArray: nil)
                        
                        if !result {
                            //   status.text = "Failed to add contact"
                            print("Error: \(purzDB.lastErrorMessage())")
                            dispatch_async(dispatch_get_main_queue()) {
                                self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                                
                            }
                        }
                        purzDB.close()
                        
                    }
                }
        }
        
        task.resume()
        
        
    }
    func matchesForRegexInText(regex: String, text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let results = regex.matchesInString(text,
                options: [], range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substringWithRange($0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func sendrequesttoserverForForgotPassword(url : String)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "GET"
        request.addValue("BaYsic YWRtaW46WRtaW4=", forHTTPHeaderField: "Authorization")
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
                
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("responseString = \(responseString)")
                let json = JSON(data: data!)
                
                let item = json["result"]
                if(item["success"].stringValue == "true"){
                    dispatch_async(dispatch_get_main_queue()) {
                        Appconstant.otp = item["otp"].stringValue
                        self.performSegueWithIdentifier("sendmoney_otp", sender: self)
                    }
                }
                    
                else{
                    dispatch_async(dispatch_get_main_queue()) {
                        dispatch_async(dispatch_get_main_queue()) {
                            self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                        }
                    }
                }
        }
                task.resume()
        
    }
    
    
    
    func alert(){
        dispatch_async(dispatch_get_main_queue()) {
            self.presentViewController(Alert().alert("Please enter a valid Password", message: ""),animated: true,completion: nil)
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "sendmoney_otp") {
            let nextview = segue.destinationViewController as! OTPViewController
            nextview.fromsendmoney = true
            nextview.amount = amount_value
            nextview.remark = remarks_txt
            nextview.businessid = contact_number
        }
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
        print(viewController.parentViewController)
        print(viewController)
        
        
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
            print("Selected item")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("RevealView")
            
            
            //            let HomeVc: HomeViewController = HomeViewController()
            //
            self.navigationController?.pushViewController(controller, animated: true)
            //            self.navigationController?.pushViewController(HomeVc, animated: true)
        }
        else if tabBarIndex == 1 {
            print("Selected item")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("MyAccount")
            self.navigationController?.pushViewController(controller, animated: true)
            //            self.navigationController?.pushViewController(HomeVc, animated: true)
        }

}
}
