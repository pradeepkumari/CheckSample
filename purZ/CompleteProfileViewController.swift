//
//  CompleteProfileViewController.swift
//  Cippy
//
//  Created by apple on 18/11/16.
//  Copyright © 2016 vertace. All rights reserved.
//

import UIKit

class CompleteProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate{

    @IBOutlet weak var profileimgBtn: UIButton!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var dobtxtField: UITextField!
    @IBOutlet weak var profileimg: UIImageView!
    
    var checkbtn = true
    let imagePicker = UIImagePickerController()
    var datePickerView:UIDatePicker!
    var base64str = ""
    var date_of_birth = ""
    var customerbank = "DCB"
    var toolbarView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        imagePicker.delegate = self
        profileimg.layer.cornerRadius = self.profileimg.frame.size.height/2
        profileimg.clipsToBounds = true
        if(Appconstant.firstname == Appconstant.lastname)
        {
            namelbl.text = Appconstant.firstname;
        }
        else
        {
        namelbl.text = Appconstant.firstname + " " + Appconstant.lastname
        }
        self.navigationController?.navigationBarHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    func dismissKeyboard(){
        toolbarView.hidden = true
        self.view.endEditing(true)
    }
    
    @IBAction func dobtxtFieldAction(sender: AnyObject) {
        createDatePickerViewWithAlertController()
    }
  
 
    
       func createDatePickerViewWithAlertController()
    {
      
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        let dateString = "1990-01-01"
        let df = NSDateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let date = df.dateFromString(dateString)
        datePickerView.setDate(date!, animated: false)
        
        dobtxtField.inputView = datePickerView
        
        toolbarView = UIView(frame: CGRectMake(0,self.view.frame.size.height-datePickerView.frame.size.height-44,self.view.frame.size.width,44))
        toolbarView.backgroundColor = UIColor.lightGrayColor()
        //        let toolBar = UIToolbar(frame: CGRectMake(0,0,self.view.frame.size.width,44))
        let doneButton = UIButton.init(frame: CGRectMake(self.view.frame.size.width - 60,5,50,34))
        doneButton.addTarget(self, action: "Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        
//        let cancelButton = UIButton.init(frame: CGRectMake(10,5,70,34))
//        cancelButton.addTarget(self, action: "Clicked", forControlEvents: UIControlEvents.TouchUpInside)
//        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        
        NSTimer.scheduledTimerWithTimeInterval(0.2, target:self, selector: Selector("timerfunc"), userInfo: nil, repeats: false)
        toolbarView.addSubview(doneButton)
//        toolbarView.addSubview(cancelButton)
        
        datePickerView.addTarget(self, action: "datePickerValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
    }
    func timerfunc(){
        toolbarView.hidden = false
        self.view.addSubview(toolbarView)
        
    }
    func Clicked(){
        toolbarView.hidden = true
        self.view.endEditing(true)
    }
    @IBAction func checkBtn(sender: AnyObject) {
        if(checkbtn){
            checkbtn = false
            customerbank = "others"
            checkBtn.setImage(UIImage(named: "uncheck.png"), forState: UIControlState.Normal)
        }
        else{
            checkbtn = true
            customerbank = "DCB"
            checkBtn.setImage(UIImage(named: "check.png"), forState: UIControlState.Normal)
        }
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        let currentdate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: currentdate)
        
        let year =  components.year
        
        
        print(sender.date)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateFormatter2 = NSDateFormatter()
        dateFormatter2.dateFormat = "yyyy"
        
        print(dateFormatter2.stringFromDate(sender.date))
        let selectdate = Int(dateFormatter2.stringFromDate(sender.date))!
        if(selectdate+18 > Int(year)){
            if !toolbarView.hidden{
                toolbarView.hidden = true
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.presentViewController(Alert().alert("Sorry! The minimum age for using Cippy is 18 years", message: ""),animated: true,completion: nil)
            }
        }
        
        else{
            dobtxtField.text = dateFormatter.stringFromDate(sender.date)
        date_of_birth = dateFormatter.stringFromDate(sender.date)
            
        }
        
    }
    
    @IBAction func cameraBtnAction(sender: AnyObject) {
        var alertController:UIAlertController?
        alertController?.view.tintColor = UIColor.blackColor()
        alertController = UIAlertController(title: "Add Photo!",
            message: "",
            preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
            
            self!.takePhotoFromCamera()
            
            })
        let action1 = UIAlertAction(title: "Choose from Gallery", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
            
            self!.takePhotofromGallery()
            
            })
        
        
        
        
        
        let action4 = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
        }
        
        alertController?.addAction(action)
        alertController?.addAction(action1)
        alertController?.addAction(action4)
        self.presentViewController(alertController!, animated: true, completion: nil)
        
        
    }
    func takePhotoFromCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = true
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
        }
    }
    func takePhotofromGallery(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            profileimgBtn.setImage(pickedImage, forState: .Normal)
            profileimg.image = pickedImage
            let image : UIImage = pickedImage
            let imageData:NSData = UIImageJPEGRepresentation(image,1)!
            base64str = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            self.profileimg.contentMode = UIViewContentMode.ScaleAspectFill
//            profileimg.layer.cornerRadius = profileimg.frame.height/2
//            profileimg.clipsToBounds = true
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func skipBtnAction(sender: AnyObject) {
        self.performSegueWithIdentifier("profile_to_home", sender: self)
        
    }
   
 
    @IBAction func saveprofileBtnAction(sender: AnyObject) {
        
            let deFormatter = NSDateFormatter()
            deFormatter.dateFormat = "dd/MM/yyyy"
            let startTime = deFormatter.dateFromString(date_of_birth)!
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            date_of_birth = formatter.stringFromDate(startTime)
            let dobviewmodel = DOBViewModel.init(entityId: Appconstant.customerid, specialDate: date_of_birth)!
            let serializedjson  = JSONSerializer.toJson(dobviewmodel)
            print(serializedjson)
            sendrequesttoserverForUpdateDOB(Appconstant.BASE_URL+Appconstant.URL_UPDATE_ENTITY, values: serializedjson)
      

    }
    
    func sendrequesttoserverForUpdateDOB(url : String, values: String)
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
                    
                    if(json["result"].stringValue == "true"){
                       self.saveintoDB()
                        
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

    func saveintoDB(){
        DBHelper().purzDB()
        let databaseURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent("purz.db")
        let databasePath = databaseURL.absoluteString
        let purzDB = FMDatabase(path: databasePath as String)
        if purzDB.open() {
            let security_q = ""
            let security_ans = ""
            let insertsql = "INSERT INTO CUSTOMERDETAIL (CUSTOMER_ID,DATE_OF_BIRTH,CUSTOMER_BANK,IMAGE_PATH,ADDRESS_LINE_1,ADDRESS_LINE_2,CITY,STATE,PIN,SECURITY_QUESTION,SECURITY_ANSWER) VALUES ('\(Appconstant.customerid)','\(date_of_birth)','\(customerbank)','\(base64str)','\("")','\("")','\("")','\("")','\("")','\(security_q)','\(security_ans)')"
            
            let result = purzDB.executeUpdate(insertsql,
                withArgumentsInArray: nil)
            
            if !result {
                //   status.text = "Failed to add contact"
                print("Error: \(purzDB.lastErrorMessage())")
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                    
                }
            }
            else{
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("profile_to_home", sender: self)
                    
                }
            }
        }
    }
    
}
