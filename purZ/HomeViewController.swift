//kCVImageBufferChromaLocation_Center//
//  HomeViewController.swift
//  Cippy
//
//  Created by apple on 16/11/16.
//  Copyright © 2016 vertace. All rights reserved.
//

import UIKit
import MapKit
class HomeViewController: UIViewController, UINavigationControllerDelegate,CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate
    
{
    @IBOutlet weak var amtsymbol: UILabel!
    @IBOutlet weak var Transactionlbl: UILabel!
   @IBOutlet weak var payatshoplbl: UILabel!
    @IBOutlet weak var sendoraskMoneyBtn: UIButton!
    @IBOutlet weak var addbtn: UIButton!
     @IBOutlet weak var Transactionbtn: UIButton!
            //    @IBOutlet weak var transactiondate1: UILabel!
//    @IBOutlet weak var transactionbtn1: UIButton!
//   
//    @IBOutlet weak var transactionbtn3: UIButton!
//        @IBOutlet weak var transactionamount2lbl: UILabel!
//    @IBOutlet weak var transactionamount3lbl: UILabel!
//    @IBOutlet weak var transactionname1lbl: UILabel!
//    @IBOutlet weak var transactionname2lbl: UILabel!
//    @IBOutlet weak var transactionname3lbl: UILabel!
//   
   //       @IBOutlet weak var Transactionbtn: UIButton!
       
//    @IBOutlet weak var badgebtn: UIButton!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var viewallbtn: UIButton!
    @IBOutlet weak var transactionslbl: UILabel!
    @IBOutlet weak var sendasklbl: UILabel!
          @IBOutlet weak var balancelbl: UILabel!
    @IBOutlet weak var RechargeorPayBtn: UIButton!
    @IBOutlet weak var payatshopBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rechargepaybilllbl: UILabel!
    @IBOutlet weak var Transactionheaderlbl: UILabel!
    
    @IBOutlet weak var batteryview: UIView!
  
    @IBOutlet weak var batterylab1: UILabel!
//    @IBOutlet weak var sidemenubarbtn: UIBarButtonItem!
    @IBOutlet weak var batterylab2: UILabel!
    
    @IBOutlet weak var batterylab3: UILabel!
    
    @IBOutlet weak var batterylab4: UILabel!
    
    @IBOutlet weak var batterylab5: UILabel!
    
    @IBOutlet weak var batterylab6: UILabel!
    @IBOutlet weak var batterylab7: UILabel!
    @IBOutlet weak var batterylab8: UILabel!
    @IBOutlet weak var batterylab9: UILabel!
    @IBOutlet weak var batterylab10: UILabel!
    @IBOutlet weak var batterylab11: UILabel!
    @IBOutlet weak var batterylab12: UILabel!
    @IBOutlet weak var batterylab13: UILabel!
    @IBOutlet weak var batterylab14: UILabel!
    @IBOutlet weak var batterylab15: UILabel!
    @IBOutlet weak var batterylab16: UILabel!
    @IBOutlet weak var batterylab17: UILabel!
    @IBOutlet weak var batterylab18: UILabel!
    @IBOutlet weak var batterylab19: UILabel!
    @IBOutlet weak var batterylab20: UILabel!
    
//  var sidemenu: UIBarButtonItem!
    var sidemenu: UIBarButtonItem!
         var trans_date = [String]()
    var transactionamt = [String]()
    var beneficiaryname = [String]()
    var balance = [String]()
    var transactiontype = [String]()
        
    var refresh_balnc = 0
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
//    var sidemenubtn: UIBarButtonItem!
//    @IBOutlet var btnRightBadge: MIBadgeButton!
    var fromweb = false
    var alertmsg = ""
    var colorlabel:UIColor!
    var selectedindex = 0
    var selectedfromtable = false
    
    override func viewDidLoad() {
      
         initialfunc()
        if(Appconstant.SideMenu==1)
        {
            payatshopBtn.sendActionsForControlEvents(.TouchUpInside);
        }
        if(Appconstant.SideMenu==2)
        {
            RechargeorPayBtn.sendActionsForControlEvents(.TouchUpInside);
        }
        if(Appconstant.SideMenu==3)
        {
            sendoraskMoneyBtn.sendActionsForControlEvents(.TouchUpInside);
        }
        if(Appconstant.SideMenu==4)
        {
            Transactionbtn.sendActionsForControlEvents(.TouchUpInside);
        }

        if(Appconstant.SideMenu==6)
        {
           performSegueWithIdentifier("home_contact", sender: self)
        }
          super.viewDidLoad()
    tabBarController?.delegate = self
        self.tabBarController?.tabBar.hidden = false
        let badgeButton : UIButton = UIButton(frame: CGRectMake(0, 0, 40, 40))
        badgeButton.setImage(UIImage(named: "Notifications-2"), forState: UIControlState.Normal)
        badgeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        badgeButton.targetForAction("buttonTouched", withSender: self)
        badgeButton.addTarget(self, action: "buttonTouched", forControlEvents: UIControlEvents.TouchUpInside)
                        //ROUNDED BUTTON Labelin
        if(Appconstant.notificationcount > 0){
                let label = UILabel(frame: CGRectMake(20, 0, 18, 18))
                label.layer.masksToBounds = true
                label.layer.cornerRadius = 8.0;
                label.textAlignment = NSTextAlignment.Center
                label.backgroundColor = UIColor.whiteColor()
                label.textColor = UIColor.blackColor()
                label.font = label.font.fontWithSize(12)
                label.text = String(Appconstant.notificationcount)
                badgeButton.addSubview(label)
            }
        
                let barButton : UIBarButtonItem = UIBarButtonItem(customView: badgeButton)
        //        barButton.setImage(UIImage(named: "Pay-at-store"), forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = barButton
        amtsymbol.text = "\u{20B9}"
                     sidemenu = UIBarButtonItem(image: UIImage(named: "menu_three_line.png"), style: .Plain, target: self, action: Selector("action"))
        navigationItem.leftBarButtonItem = sidemenu
               sidemenu.target = self.revealViewController()
                    sidemenu.action = #selector(SWRevealViewController.revealToggle(_:))
        battery()
        Transactionlbl.text = "We will pop out your recent transaction made on\nPurz soon as you start using your Wallet.\nSo what are you waiting for!"
        
             navigationController?.navigationBarHidden = false
        tableView.scrollEnabled = false;
        payatshoplbl.text = "Pay @\nShop"
        rechargepaybilllbl.text = "Recharge/\nPayBills"
        sendasklbl.text = "Send/Ask\nMoney"
        transactionslbl.text = "Transaction\ns"
        payatshopBtn.layer.cornerRadius = self.payatshopBtn.frame.size.height/2
        addbtn.layer.cornerRadius = self.addbtn.frame.size.height/2
        RechargeorPayBtn.layer.cornerRadius = self.RechargeorPayBtn.frame.size.height/2
        sendoraskMoneyBtn.layer.cornerRadius = self.sendoraskMoneyBtn.frame.size.height/2
        Transactionbtn.layer.cornerRadius = self.Transactionbtn.frame.size.height/2
        Transactionheaderlbl .layer.cornerRadius = 15
        Transactionheaderlbl.layer.masksToBounds = true
        viewallbtn.layer.cornerRadius = 6
//tableView.layer.cornerRadius = 9
           getbalancefromServer(Appconstant.BASE_URL+Appconstant.URL_FETCH_MULTI_BALANCE_INFO+Appconstant.customerid)
        print(Appconstant.BASE_URL+Appconstant.URL_FETCH_RECENT_TRANSACTIONS+Appconstant.customerid+"?pageNo=1&pageSize=3")
        getrecenttransaction(Appconstant.BASE_URL+Appconstant.URL_FETCH_RECENT_TRANSACTIONS+Appconstant.customerid+"?pageNo=1&pageSize=3")
        getplanlist(Appconstant.BASE_URL+Appconstant.URL_GETOPEARTORS)
     }
    func buttonTouched()
    {
        performSegueWithIdentifier("home_notification", sender: nil)
    }

    @IBAction func viewallBtn(sender: AnyObject) {
        Transactionbtn.sendActionsForControlEvents(.TouchUpInside);
    }
          override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if Appconstant.fromlogout{
        Appconstant.fromlogout = false
                let alert = UIAlertController(title: "Are you sure want to logout?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        //             alert.setValue(attributedString, forKey: "attributedTitle")
                alert.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.Default, handler: { alertAction in
                    exit (0)
                }))
        
                                  alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.Default, handler: { alertAction in
                        }))
                self.presentViewController(alert, animated: true, completion: nil)
        }
    }
       
    func initialfunc(){
        if fromweb{
            dispatch_async(dispatch_get_main_queue()) {
                self.presentViewController(Alert().alert(self.alertmsg, message: ""),animated: true,completion: nil)
            }
        }
        //        transactionview.layer.cornerRadius = 10
        //        transactionbtn1.layer.cornerRadius = 10
//        transactionbtn2.layer.cornerRadius = 10
//        transactionbtn3.layer.cornerRadius = 10
//       
//        transactionbtn1.hidden = true
//        transactionbtn2.hidden = true
//        transactionbtn3.hidden = true
//        transactionamount1lbl.hidden = true
//        transactionamount2lbl.hidden = true
//        transactionamount3lbl.hidden = true
//        transactionname1lbl.hidden = true
//        transactionname2lbl.hidden = true
//        transactionname3lbl.hidden = true
        print(Appconstant.customername)
//        dispatch_async(dispatch_get_main_queue()) {
//            self.namelbl.text = Appconstant.customername
//        }
//        transactionbtn1.userInteractionEnabled = false
//        transactionbtn2.userInteractionEnabled = false
//        transactionbtn3.userInteractionEnabled = false
//        let frame = 45 - self.view.frame.size.width/2
//        let frame1 = 75 - self.view.frame.size.width/2
//        RechargeorPayBtn.imageEdgeInsets = UIEdgeInsetsMake(0,frame, 0, 0)
//        RechargeorPayBtn.titleEdgeInsets = UIEdgeInsetsMake(0, frame1, 0, 0)
//        payatshopBtn.imageEdgeInsets = UIEdgeInsetsMake(0,frame-48, 0, 0)
//        payatshopBtn.titleEdgeInsets = UIEdgeInsetsMake(0, frame1-48, 0, 0)
        let defaults = NSUserDefaults.standardUserDefaults()
        //        defaults.setObject(Appconstant.notificationcount, forKey: "badgecount")
               let cippybalance = defaults.stringForKey("cippybalance")
        let badgevalue = defaults.stringForKey("badgecount")
//        if(cippybalance != nil){
//            balancelbl.text = cippybalance
//        }
        print(badgevalue)
        if(badgevalue == nil){
            
        }
        else{
            Appconstant.notificationcount = Int(badgevalue!)!
        }
//        if(Appconstant.notificationcount > 0){
//            badgebtn.hidden = false
//            badgebtn.setTitle("\(Appconstant.notificationcount)", forState: .Normal)
//        }
//        else{
//            badgebtn.hidden = true
//        }
        
        
    }
    
    func transactiontable(){
        DBHelper().purzDB()
        let databaseURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent("purz.db")
        let databasePath = databaseURL.absoluteString
        let purzDB = FMDatabase(path: databasePath as String)
        if purzDB.open() {
            let select = "SELECT * FROM TRANSACTIONS"
            let result4:FMResultSet = purzDB.executeQuery(select,
                withArgumentsInArray: nil)
            if(result4.next()){
                
            }
            else{
                dispatch_async(dispatch_get_main_queue()) {
                    self.gettentransaction(Appconstant.BASE_URL+Appconstant.URL_FETCH_RECENT_TRANSACTIONS+Appconstant.customerid+"?pageNo=1&pageSize=10")
                }
            }
        }
        purzDB.close()
        
    }
    
//    @IBAction func balanceRefereshBtnAction(sender: AnyObject) {
//        refresh_balnc = 1
//        getrecenttransaction(Appconstant.BASE_URL+Appconstant.URL_FETCH_RECENT_TRANSACTIONS+Appconstant.customerid+"?pageNo=1&pageSize=3")
//    }
//    
//    
//    
//    
//    
//    
//    
//    @IBAction func notificationBtnAction(sender: AnyObject) {
//        
//    }
       
    func getbalancefromServer(url: String){
        
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
                    
                    for item in json["result"].arrayValue{
                        dispatch_async(dispatch_get_main_queue()) {
                            let balance_two_decimal = String(format: "%.2f", item["balance"].doubleValue)
                            let checkbalancedecimal = balance_two_decimal.componentsSeparatedByString(".")
                            if(checkbalancedecimal[1].characters.count == 1){
                                self.balancelbl.text = balance_two_decimal + "0"
                                Appconstant.mainbalance = self.balancelbl.text!
                                print("AMOUNT\(Appconstant.mainbalance)")
                                self.batteryamt()

                            }
                            else{
                                self.balancelbl.text = balance_two_decimal
                                Appconstant.mainbalance = self.balancelbl.text!
                                print("AMOUNT\(Appconstant.mainbalance)")
                                self.batteryamt()

                                let defaults = NSUserDefaults.standardUserDefaults()
                                defaults.setObject(Appconstant.mainbalance, forKey: "cippybalance")
                            }
                        }
                    }
                    if(self.refresh_balnc == 1){
                        self.refresh_balnc = 0
                        dispatch_async(dispatch_get_main_queue()) {
                            self.presentViewController(Alert().alert("So Fresh! Balance in your wallet is refreshed.", message: ""),animated: true,completion: nil)
                        }
                    }
                    
                }
        }
        
        task.resume()
        
        
    }
    
    func getrecenttransaction(url: String){
        
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
                self.trans_date.removeAll()
                self.transactionamt.removeAll()
                self.beneficiaryname.removeAll()
                for item1 in json["result"].arrayValue{
                    let item = item1["transaction"]
                    
                    let balance_two_decimal = String(format: "%.2f", item["amount"].doubleValue)
                    let amount = balance_two_decimal.componentsSeparatedByString(".")
                    if(amount[1].characters.count == 1){
                        let finalamount = balance_two_decimal + "0"
                        self.transactionamt.append(finalamount)
                    }
                    else{
                        self.transactionamt.append(balance_two_decimal)
                    }
                    
                    
                    self.beneficiaryname.append(item["beneficiaryName"].stringValue)
                    let date = NSDate(timeIntervalSince1970: item["time"].doubleValue/1000.0)
                    self.transactiontype.append(item["type"].stringValue)
                     let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd MMM"
                    dateFormatter.timeZone = NSTimeZone(name: "UTC")
                    let dateString = dateFormatter.stringFromDate(date)
                    if(!dateString.isEmpty){
                        let datearray = dateString.componentsSeparatedByString(" ")
                        if(datearray[0] != "11" && datearray[0].characters.last == "1"){
                            let correctdate = datearray[0] + "st " + datearray[1]
                            self.trans_date.append(correctdate)
                        }
                        else if(datearray[0] != "12" && datearray[0].characters.last == "2"){
                            let correctdate = datearray[0] + "nd " + datearray[1]
                            self.trans_date.append(correctdate)
                        }
                        else if(datearray[0] != "13" && datearray[0].characters.last == "3"){
                            let correctdate = datearray[0] + "rd " + datearray[1]
                            self.trans_date.append(correctdate)
                        }
                        else{
                            let correctdate = datearray[0] + "th " + datearray[1]
                            self.trans_date.append(correctdate)
                        }
                        
                    }
                }
                dispatch_async(dispatch_get_main_queue()) {

                self.tableView.reloadData()                }
                
                self .transactiontable()
        }
        
        task.resume()
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell!
        let transactionimg = cell.viewWithTag(1) as! UIImageView
        let transactionnamelbl = cell.viewWithTag(3) as! UILabel
        let transactiondatelbl = cell.viewWithTag(4) as! UILabel
        let transactionamountlbl = cell.viewWithTag(2) as! UILabel
     
        
       
//        let statuslbl = cell.viewWithTag(10) as! UILabel
//        statuslbl.hidden = true
        print(indexPath.row)
        print(transactionamt)
        print(beneficiaryname)
        if(transactionamt[indexPath.row] == "true"){
            Transactionlbl.hidden = false
            Transactionlbl.text = "We will pop out your recent transaction made on/nPurz soon as you start using your Wallet./nSo what are you waiting for!"
                            //                self.activityIndicator.stopAnimating()
        }
            
            else{
             Transactionlbl.hidden = true
            transactionamountlbl.text =  self.transactionamt[indexPath.row] + " @"
            transactionnamelbl.text =  self.beneficiaryname[indexPath.row];
            transactiondatelbl.text =  self.trans_date[indexPath.row]
            if(self.transactiontype[indexPath.row] == "CREDIT")
            {
                transactionimg.image = UIImage(named: "In.png")!
                    }
            else if(self.transactiontype[indexPath.row] == "DEBIT")
            {
               transactionimg.image = UIImage(named: "Out.png")!
            }
//            transactionnamelbl.text =  self.transactionamt[indexPath.row] + " @"
}
        cell.layer.borderWidth = 0.5
                cell.layer.borderColor = UIColor.whiteColor().CGColor
        cell.selectionStyle = .None
        
        return cell
        if(refresh_balnc == 1){
            getbalancefromServer(Appconstant.BASE_URL+Appconstant.URL_FETCH_MULTI_BALANCE_INFO+Appconstant.customerid)
        }

    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.beneficiaryname.count)
        return self.beneficiaryname.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
        selectedindex = indexPath.row
        selectedfromtable = true
        self.performSegueWithIdentifier("from-home", sender: self)
    

    }

    func gettentransaction(url: String){
        
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
                
                self.transactionamt.removeAll()
                self.trans_date.removeAll()
                self.beneficiaryname.removeAll()
                var i = 0
                for item1 in json["result"].arrayValue{
                    let item = item1["transaction"]
                    
                    
                    
                    
                    
                    let balance_two_decimal = String(format: "%.2f", item["amount"].doubleValue)
                    let amount = balance_two_decimal.componentsSeparatedByString(".")
                    if(amount[1].characters.count == 1){
                        let finalamount = balance_two_decimal + "0"
                        self.transactionamt.append(finalamount)
                    }
                    else{
                        self.transactionamt.append(balance_two_decimal)
                    }
                    
                    let mainbalance_two_decimal = String(format: "%.2f", item["balance"].doubleValue)
                    let mainamount = mainbalance_two_decimal.componentsSeparatedByString(".")
                    if(mainamount[1].characters.count == 1){
                        let finalamount = balance_two_decimal + "0"
                        self.balance.append(finalamount)
                    }
                    else{
                        self.balance.append(mainbalance_two_decimal)
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
                            self.trans_date.append(correctdate)
                        }
                        else if(datearray[0] != "12" && datearray[0].characters.last == "2"){
                            let correctdate = datearray[0] + "nd " + datearray[1]
                            self.trans_date.append(correctdate)
                        }
                        else if(datearray[0] != "13" && datearray[0].characters.last == "3"){
                            let correctdate = datearray[0] + "rd " + datearray[1]
                            self.trans_date.append(correctdate)
                        }
                        else{
                            let correctdate = datearray[0] + "th " + datearray[1]
                            self.trans_date.append(correctdate)
                        }
                        
                    }
                    print(item["description"].stringValue)
//                    let matches = self.matchesForRegexInText("[0-9]", text: item["description"].stringValue)
//                    let desc = matches.joinWithSeparator("")
                 let desc = ""
                    DBHelper().purzDB()
                    let databaseURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent("purz.db")
                    let databasePath = databaseURL.absoluteString
                    let purzDB = FMDatabase(path: databasePath as String)
                    if purzDB.open() {
                        
                        let insert = "INSERT INTO TRANSACTIONS (AMOUNT,BENEFICIARY_ID,TRANSACTION_TYPE,TYPE,TIME,TRANSACTION_STATUS,TX_REF,BENEFICIARY_NAME,DESCRIPTION,OTHER_PARTY_NAME,OTHER_PARTY_ID,TXN_ORIGIN) VALUES"
                        let value0 =  "('"+self.transactionamt[i]+"','\(item["beneficiaryId"].stringValue)','\(item["transactionType"].stringValue)','\(item["type"].stringValue)',"
                        let value1 = "'"+self.trans_date[i]+"','\(item["transactionStatus"].stringValue)','\(item["txRef"].stringValue)','\(item["beneficiaryName"].stringValue)',"
                        let value2 = "'\(desc)','\(item["otherPartyName"].stringValue)','\(item["otherPartyId"].stringValue)','\(item["txnOrigin"].stringValue)')"
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
                    i++
                    
                }
        }
        
        task.resume()
    }
    
//    
//    func matchesForRegexInText(regex: String, text: String) -> [String]
//    {
//        do {
//        let regex = try NSRegularExpression(pattern: regex, options: [])
//            let nsString = text as NSString
//            let results = regex.matchesInString(text,
//                options: [], range: NSMakeRange(0, nsString.length))
//            return results.map { nsString.substringWithRange($0.range)}
//        }
//        catch let error as NSError {
//            print("invalid regex: \(error.localizedDescription)")
//            return []
//        }
//    }
    func getplanlist(url: String){
        print(url)
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
                for item in json["result"].arrayValue{
                    if(item["operatorType"].stringValue == "PREPAID"){
                        self.pre_operatorCode.append(item["operatorCode"].stringValue)
                        self.pre_operatorName.append(item["operatorName"].stringValue)
                        self.pre_operatorId.append(item["operatorId"].stringValue)
                        self.pre_operatorType.append(item["operatorType"].stringValue)
                        self.pre_special.append(item["special"].boolValue)
                    }
                    else if(item["operatorType"].stringValue == "POSTPAID"){
                        self.post_operatorCode.append(item["operatorCode"].stringValue)
                        self.post_operatorName.append(item["operatorName"].stringValue)
                        self.post_operatorId.append(item["operatorId"].stringValue)
                        self.post_operatorType.append(item["operatorType"].stringValue)
                        self.post_special.append(item["special"].boolValue)
                    }
                    else if(item["operatorType"].stringValue == "DTH"){
                        self.dth_operatorCode.append(item["operatorCode"].stringValue)
                        self.dth_operatorName.append(item["operatorName"].stringValue)
                        self.dth_operatorId.append(item["operatorId"].stringValue)
                        self.dth_operatorType.append(item["operatorType"].stringValue)
                        self.dth_special.append(item["special"].boolValue)
                    }
                    
                }
        }
        
        task.resume()
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if(segue.identifier == "home_rechargeorbill") {
//            let nextview = segue.destinationViewController as! RechargeorPayBillViewController
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
//        }
//        
        if(segue.identifier == "from-home") {
            let nextview = segue.destinationViewController as! TransactionsViewController
            nextview.fromhome = true
            nextview.selectedindex = selectedindex
            //                nextview.txref = tx_ref
            //                nextview.ben_name = benname
            //                nextview.time = time
            //                nextview.mainamount = splitamt
            //            }
        }
    }
    
    
    
    func battery()
    {
        batteryview.layer.cornerRadius = 7
        batteryview.layer.borderColor = UIColor.lightGrayColor().CGColor
        batteryview.layer.borderWidth = 3
        batterylab1.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab1.layer.borderWidth = 1
        batterylab2.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab2.layer.borderWidth = 1
        batterylab3.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab3.layer.borderWidth = 1
        batterylab4.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab4.layer.borderWidth = 1
        batterylab5.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab5.layer.borderWidth = 1
        batterylab6.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab6.layer.borderWidth = 1
        batterylab7.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab7.layer.borderWidth = 1
        batterylab8.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab8
            .layer.borderWidth = 1
        batterylab9.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab9.layer.borderWidth = 1
        batterylab10.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab10.layer.borderWidth = 1
        batterylab11.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab11.layer.borderWidth = 1
        batterylab12.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab12.layer.borderWidth = 1
        batterylab13.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab13.layer.borderWidth = 1
        batterylab14.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab14.layer.borderWidth = 1
        batterylab15.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab15.layer.borderWidth = 1
        batterylab16.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab16.layer.borderWidth = 1
        batterylab17.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab17.layer.borderWidth = 1
        batterylab18.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab18.layer.borderWidth = 1
        batterylab19.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab19.layer.borderWidth = 1
        batterylab20.layer.borderColor = UIColor.lightGrayColor().CGColor
        batterylab20.layer.borderWidth = 1
        
    batterylab1.layer.cornerRadius = 3
    batterylab2.layer.cornerRadius = 3
    batterylab3.layer.cornerRadius = 3
    batterylab4.layer.cornerRadius = 3
    batterylab5.layer.cornerRadius = 3
    batterylab6.layer.cornerRadius = 3
    batterylab7.layer.cornerRadius = 3
    batterylab8.layer.cornerRadius = 3
    batterylab9.layer.cornerRadius = 3
    batterylab10.layer.cornerRadius = 3
    batterylab11.layer.cornerRadius = 3
    batterylab12.layer.cornerRadius = 3
    batterylab13.layer.cornerRadius = 3
    batterylab14.layer.cornerRadius = 3
    batterylab15.layer.cornerRadius = 3
    batterylab16.layer.cornerRadius = 3
    batterylab17.layer.cornerRadius = 3
    batterylab18.layer.cornerRadius = 3
    batterylab19.layer.cornerRadius = 3
    batterylab20.layer.cornerRadius = 3
}
       func batteryamt()
    {
//  (Appconstant.mainbalance) = "10000"
        
        if(Double(Appconstant.mainbalance) == 0)
        {
            colorlabel = UIColor.redColor()
            batteryfivecolor()
            batteryeightcolor()
            batteryfifteencolor()
            batterytwentycolor()
        }

else if(Double(Appconstant.mainbalance) <= 5000  )
        {
 colorlabel = UIColor.redColor()
     batteryfivecolor()
    
    }
      else if(Double(Appconstant.mainbalance) <= 8000  )
        {
           colorlabel = UIColor.yellowColor()
            batteryfivecolor()
            batteryeightcolor()
            
        }
 else if (Double(Appconstant.mainbalance) <= 15000  )
{
    colorlabel =  UIColor(red: 120.0/255.0, green: 210.0/255.0, blue: 110.0/255.0, alpha: 1.0)

    batteryfivecolor()
    batteryeightcolor()
    batteryfifteencolor()
    
        }
else if(Double(Appconstant.mainbalance) <= 20000  )
{
    colorlabel = UIColor.greenColor()
    batteryfivecolor()
    batteryeightcolor()
    batteryfifteencolor()
    batterytwentycolor()
            }

    }
    func batteryfivecolor()
    {
        
        print(Appconstant.mainbalance)
        
        if(Double(Appconstant.mainbalance) <= 1000.0)
        {
            batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            
        }
        else if(Double(Appconstant.mainbalance) <= 2000.0)
        {batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor


        }
        else if(Double(Appconstant.mainbalance) <= 3000.0)
        {batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor

        }
        else if(Double(Appconstant.mainbalance) <= 4000.0)
        {batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor

        }
        else if(Double(Appconstant.mainbalance) <= 5000.0)
        {batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
            batterylab5.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor
            batterylab5.layer.borderColor = UIColor.clearColor().CGColor

        }
        

    }
    func batteryeightcolor()
    {
        if(Double(Appconstant.mainbalance) <= 6000.0)
        {batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
         batterylab5.layer.backgroundColor = colorlabel.CGColor
            batterylab6.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor
             batterylab5.layer.borderColor = UIColor.clearColor().CGColor
            batterylab6.layer.borderColor = UIColor.clearColor().CGColor

        }
        else if(Double(Appconstant.mainbalance) <= 7000.0)
        {
            batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
            batterylab5.layer.backgroundColor = colorlabel.CGColor
            batterylab6.layer.backgroundColor = colorlabel.CGColor
            batterylab7.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor
            batterylab5.layer.borderColor = UIColor.clearColor().CGColor
            batterylab6.layer.borderColor = UIColor.clearColor().CGColor
            batterylab7.layer.borderColor = UIColor.clearColor().CGColor

        }
        else if(Double(Appconstant.mainbalance) <= 8000.0)
        {
            batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
            batterylab5.layer.backgroundColor = colorlabel.CGColor
            batterylab6.layer.backgroundColor = colorlabel.CGColor
            batterylab7.layer.backgroundColor = colorlabel.CGColor
            batterylab8.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor
            batterylab5.layer.borderColor = UIColor.clearColor().CGColor
            batterylab6.layer.borderColor = UIColor.clearColor().CGColor
            batterylab7.layer.borderColor = UIColor.clearColor().CGColor
            batterylab8.layer.borderColor = UIColor.clearColor().CGColor

        }
   }
    func batteryfifteencolor()
    {
        if(Double(Appconstant.mainbalance) <= 9000.0)
        {
            batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
            batterylab5.layer.backgroundColor = colorlabel.CGColor
            batterylab6.layer.backgroundColor = colorlabel.CGColor
            batterylab7.layer.backgroundColor = colorlabel.CGColor
            batterylab8.layer.backgroundColor = colorlabel.CGColor
            batterylab9.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor
            batterylab5.layer.borderColor = UIColor.clearColor().CGColor
            batterylab6.layer.borderColor = UIColor.clearColor().CGColor
            batterylab7.layer.borderColor = UIColor.clearColor().CGColor
            batterylab8.layer.borderColor = UIColor.clearColor().CGColor
            batterylab9.layer.borderColor = UIColor.clearColor().CGColor

        }
        else if(Double(Appconstant.mainbalance) <= 10000.0)
        {
            batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
            batterylab5.layer.backgroundColor = colorlabel.CGColor
            batterylab6.layer.backgroundColor = colorlabel.CGColor
            batterylab7.layer.backgroundColor = colorlabel.CGColor
            batterylab8.layer.backgroundColor = colorlabel.CGColor
            batterylab9.layer.backgroundColor = colorlabel.CGColor
            batterylab10.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor
            batterylab5.layer.borderColor = UIColor.clearColor().CGColor
            batterylab6.layer.borderColor = UIColor.clearColor().CGColor
            batterylab7.layer.borderColor = UIColor.clearColor().CGColor
            batterylab8.layer.borderColor = UIColor.clearColor().CGColor
            batterylab9.layer.borderColor = UIColor.clearColor().CGColor
            batterylab10.layer.borderColor = UIColor.clearColor().CGColor


        }
        else if(Double(Appconstant.mainbalance) <= 11000.0)
        {
            batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
            batterylab5.layer.backgroundColor = colorlabel.CGColor
            batterylab6.layer.backgroundColor = colorlabel.CGColor
            batterylab7.layer.backgroundColor = colorlabel.CGColor
            batterylab8.layer.backgroundColor = colorlabel.CGColor
            batterylab9.layer.backgroundColor = colorlabel.CGColor
            batterylab10.layer.backgroundColor = colorlabel.CGColor
            batterylab11.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor
            batterylab5.layer.borderColor = UIColor.clearColor().CGColor
            batterylab6.layer.borderColor = UIColor.clearColor().CGColor
            batterylab7.layer.borderColor = UIColor.clearColor().CGColor
            batterylab8.layer.borderColor = UIColor.clearColor().CGColor
            batterylab9.layer.borderColor = UIColor.clearColor().CGColor
            batterylab10.layer.borderColor = UIColor.clearColor().CGColor
            batterylab11.layer.borderColor = UIColor.clearColor().CGColor


        }
        else if(Double(Appconstant.mainbalance) <= 12000.0)
        {
            batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
            batterylab5.layer.backgroundColor = colorlabel.CGColor
            batterylab6.layer.backgroundColor = colorlabel.CGColor
            batterylab7.layer.backgroundColor = colorlabel.CGColor
            batterylab8.layer.backgroundColor = colorlabel.CGColor
            batterylab9.layer.backgroundColor = colorlabel.CGColor
            batterylab10.layer.backgroundColor = colorlabel.CGColor
            batterylab11.layer.backgroundColor = colorlabel.CGColor
            batterylab12.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor
            batterylab5.layer.borderColor = UIColor.clearColor().CGColor
            batterylab6.layer.borderColor = UIColor.clearColor().CGColor
            batterylab7.layer.borderColor = UIColor.clearColor().CGColor
            batterylab8.layer.borderColor = UIColor.clearColor().CGColor
            batterylab9.layer.borderColor = UIColor.clearColor().CGColor
            batterylab10.layer.borderColor = UIColor.clearColor().CGColor
            batterylab11.layer.borderColor = UIColor.clearColor().CGColor
            batterylab12.layer.borderColor = UIColor.clearColor().CGColor


        }
        else if(Double(Appconstant.mainbalance) <= 13000.0)
        {
            batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
            batterylab5.layer.backgroundColor = colorlabel.CGColor
            batterylab6.layer.backgroundColor = colorlabel.CGColor
            batterylab7.layer.backgroundColor = colorlabel.CGColor
            batterylab8.layer.backgroundColor = colorlabel.CGColor
            batterylab9.layer.backgroundColor = colorlabel.CGColor
            batterylab10.layer.backgroundColor = colorlabel.CGColor
            batterylab11.layer.backgroundColor = colorlabel.CGColor
            batterylab12.layer.backgroundColor = colorlabel.CGColor
            batterylab13.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor
            batterylab5.layer.borderColor = UIColor.clearColor().CGColor
            batterylab6.layer.borderColor = UIColor.clearColor().CGColor
            batterylab7.layer.borderColor = UIColor.clearColor().CGColor
            batterylab8.layer.borderColor = UIColor.clearColor().CGColor
            batterylab9.layer.borderColor = UIColor.clearColor().CGColor
            batterylab10.layer.borderColor = UIColor.clearColor().CGColor
            batterylab11.layer.borderColor = UIColor.clearColor().CGColor
            batterylab12.layer.borderColor = UIColor.clearColor().CGColor
            batterylab13.layer.borderColor = UIColor.clearColor().CGColor


        }
        else if(Double(Appconstant.mainbalance) <= 14000.0)
        {
            batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
            batterylab5.layer.backgroundColor = colorlabel.CGColor
            batterylab6.layer.backgroundColor = colorlabel.CGColor
            batterylab7.layer.backgroundColor = colorlabel.CGColor
            batterylab8.layer.backgroundColor = colorlabel.CGColor
            batterylab9.layer.backgroundColor = colorlabel.CGColor
            batterylab10.layer.backgroundColor = colorlabel.CGColor
            batterylab11.layer.backgroundColor = colorlabel.CGColor
            batterylab12.layer.backgroundColor = colorlabel.CGColor
            batterylab13.layer.backgroundColor = colorlabel.CGColor
            batterylab14.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor
            batterylab5.layer.borderColor = UIColor.clearColor().CGColor
            batterylab6.layer.borderColor = UIColor.clearColor().CGColor
            batterylab7.layer.borderColor = UIColor.clearColor().CGColor
            batterylab8.layer.borderColor = UIColor.clearColor().CGColor
            batterylab9.layer.borderColor = UIColor.clearColor().CGColor
            batterylab10.layer.borderColor = UIColor.clearColor().CGColor
            batterylab11.layer.borderColor = UIColor.clearColor().CGColor
            batterylab12.layer.borderColor = UIColor.clearColor().CGColor
            batterylab13.layer.borderColor = UIColor.clearColor().CGColor
            batterylab14.layer.borderColor = UIColor.clearColor().CGColor

            

        }
        else if(Double(Appconstant.mainbalance) <= 15000.0)
        {
            batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
            batterylab5.layer.backgroundColor = colorlabel.CGColor
            batterylab6.layer.backgroundColor = colorlabel.CGColor
            batterylab7.layer.backgroundColor = colorlabel.CGColor
            batterylab8.layer.backgroundColor = colorlabel.CGColor
            batterylab9.layer.backgroundColor = colorlabel.CGColor
            batterylab10.layer.backgroundColor = colorlabel.CGColor
            batterylab11.layer.backgroundColor = colorlabel.CGColor
            batterylab12.layer.backgroundColor = colorlabel.CGColor
            batterylab13.layer.backgroundColor = colorlabel.CGColor
            batterylab14.layer.backgroundColor = colorlabel.CGColor
            batterylab15.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor
            batterylab5.layer.borderColor = UIColor.clearColor().CGColor
            batterylab6.layer.borderColor = UIColor.clearColor().CGColor
            batterylab7.layer.borderColor = UIColor.clearColor().CGColor
            batterylab8.layer.borderColor = UIColor.clearColor().CGColor
            batterylab9.layer.borderColor = UIColor.clearColor().CGColor
            batterylab10.layer.borderColor = UIColor.clearColor().CGColor
            batterylab11.layer.borderColor = UIColor.clearColor().CGColor
            batterylab12.layer.borderColor = UIColor.clearColor().CGColor
            batterylab13.layer.borderColor = UIColor.clearColor().CGColor
            batterylab14.layer.borderColor = UIColor.clearColor().CGColor
            batterylab15.layer.borderColor = UIColor.clearColor().CGColor

        }
    }
 
    func batterytwentycolor()
    {
         if((Double(Appconstant.mainbalance) <= 20000.0) || (Double(Appconstant.mainbalance) == 0))
        {
            batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
            batterylab5.layer.backgroundColor = colorlabel.CGColor
            batterylab6.layer.backgroundColor = colorlabel.CGColor
            batterylab7.layer.backgroundColor = colorlabel.CGColor
            batterylab8.layer.backgroundColor = colorlabel.CGColor
            batterylab9.layer.backgroundColor = colorlabel.CGColor
            batterylab10.layer.backgroundColor = colorlabel.CGColor
            batterylab11.layer.backgroundColor = colorlabel.CGColor
            batterylab12.layer.backgroundColor = colorlabel.CGColor
            batterylab13.layer.backgroundColor = colorlabel.CGColor
            batterylab14.layer.backgroundColor = colorlabel.CGColor
            batterylab15.layer.backgroundColor = colorlabel.CGColor
            batterylab16.layer.backgroundColor = colorlabel.CGColor
            batterylab17.layer.backgroundColor = colorlabel.CGColor
            batterylab18.layer.backgroundColor = colorlabel.CGColor
            batterylab19.layer.backgroundColor = colorlabel.CGColor
            batterylab20.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor
            batterylab5.layer.borderColor = UIColor.clearColor().CGColor
            batterylab6.layer.borderColor = UIColor.clearColor().CGColor
            batterylab7.layer.borderColor = UIColor.clearColor().CGColor
            batterylab8.layer.borderColor = UIColor.clearColor().CGColor
            batterylab9.layer.borderColor = UIColor.clearColor().CGColor
            batterylab10.layer.borderColor = UIColor.clearColor().CGColor
            batterylab11.layer.borderColor = UIColor.clearColor().CGColor
            batterylab12.layer.borderColor = UIColor.clearColor().CGColor
            batterylab13.layer.borderColor = UIColor.clearColor().CGColor
            batterylab14.layer.borderColor = UIColor.clearColor().CGColor
            batterylab15.layer.borderColor = UIColor.clearColor().CGColor
            batterylab16.layer.borderColor = UIColor.clearColor().CGColor
            batterylab17.layer.borderColor = UIColor.clearColor().CGColor
            batterylab18.layer.borderColor = UIColor.clearColor().CGColor
            batterylab19.layer.borderColor = UIColor.clearColor().CGColor
            batterylab20.layer.borderColor = UIColor.clearColor().CGColor
            
        }
       
        else if(Double(Appconstant.mainbalance) <= 16000.0)
        {
            batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
            batterylab5.layer.backgroundColor = colorlabel.CGColor
            batterylab6.layer.backgroundColor = colorlabel.CGColor
            batterylab7.layer.backgroundColor = colorlabel.CGColor
            batterylab8.layer.backgroundColor = colorlabel.CGColor
            batterylab9.layer.backgroundColor = colorlabel.CGColor
            batterylab10.layer.backgroundColor = colorlabel.CGColor
            batterylab11.layer.backgroundColor = colorlabel.CGColor
            batterylab12.layer.backgroundColor = colorlabel.CGColor
            batterylab13.layer.backgroundColor = colorlabel.CGColor
            batterylab14.layer.backgroundColor = colorlabel.CGColor
            batterylab15.layer.backgroundColor = colorlabel.CGColor
            batterylab16.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor
            batterylab5.layer.borderColor = UIColor.clearColor().CGColor
            batterylab6.layer.borderColor = UIColor.clearColor().CGColor
            batterylab7.layer.borderColor = UIColor.clearColor().CGColor
            batterylab8.layer.borderColor = UIColor.clearColor().CGColor
            batterylab9.layer.borderColor = UIColor.clearColor().CGColor
            batterylab10.layer.borderColor = UIColor.clearColor().CGColor
            batterylab11.layer.borderColor = UIColor.clearColor().CGColor
            batterylab12.layer.borderColor = UIColor.clearColor().CGColor
            batterylab13.layer.borderColor = UIColor.clearColor().CGColor
            batterylab14.layer.borderColor = UIColor.clearColor().CGColor
            batterylab15.layer.borderColor = UIColor.clearColor().CGColor
            batterylab16.layer.borderColor = UIColor.clearColor().CGColor


        }
        else if(Double(Appconstant.mainbalance) <= 17000.0)
        { batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
            batterylab5.layer.backgroundColor = colorlabel.CGColor
            batterylab6.layer.backgroundColor = colorlabel.CGColor
            batterylab7.layer.backgroundColor = colorlabel.CGColor
            batterylab8.layer.backgroundColor = colorlabel.CGColor
            batterylab9.layer.backgroundColor = colorlabel.CGColor
            batterylab10.layer.backgroundColor = colorlabel.CGColor
            batterylab11.layer.backgroundColor = colorlabel.CGColor
            batterylab12.layer.backgroundColor = colorlabel.CGColor
            batterylab13.layer.backgroundColor = colorlabel.CGColor
            batterylab14.layer.backgroundColor = colorlabel.CGColor
           batterylab15.layer.backgroundColor = colorlabel.CGColor
            batterylab16.layer.backgroundColor = colorlabel.CGColor
            batterylab17.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor
            batterylab5.layer.borderColor = UIColor.clearColor().CGColor
            batterylab6.layer.borderColor = UIColor.clearColor().CGColor
            batterylab7.layer.borderColor = UIColor.clearColor().CGColor
            batterylab8.layer.borderColor = UIColor.clearColor().CGColor
            batterylab9.layer.borderColor = UIColor.clearColor().CGColor
            batterylab10.layer.borderColor = UIColor.clearColor().CGColor
            batterylab11.layer.borderColor = UIColor.clearColor().CGColor
            batterylab12.layer.borderColor = UIColor.clearColor().CGColor
            batterylab13.layer.borderColor = UIColor.clearColor().CGColor
            batterylab14.layer.borderColor = UIColor.clearColor().CGColor
            batterylab15.layer.borderColor = UIColor.clearColor().CGColor
            batterylab16.layer.borderColor = UIColor.clearColor().CGColor
            batterylab17.layer.borderColor = UIColor.clearColor().CGColor

        }
        else if(Double(Appconstant.mainbalance) <= 18000.0)
        {batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
            batterylab5.layer.backgroundColor = colorlabel.CGColor
            batterylab6.layer.backgroundColor = colorlabel.CGColor
            batterylab7.layer.backgroundColor = colorlabel.CGColor
            batterylab8.layer.backgroundColor = colorlabel.CGColor
            batterylab9.layer.backgroundColor = colorlabel.CGColor
            batterylab10.layer.backgroundColor = colorlabel.CGColor
            batterylab11.layer.backgroundColor = colorlabel.CGColor
            batterylab12.layer.backgroundColor = colorlabel.CGColor
            batterylab13.layer.backgroundColor = colorlabel.CGColor
            batterylab14.layer.backgroundColor = colorlabel.CGColor
            batterylab15.layer.backgroundColor = colorlabel.CGColor
            batterylab16.layer.backgroundColor = colorlabel.CGColor
            batterylab17.layer.backgroundColor = colorlabel.CGColor
            batterylab18.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor
            batterylab5.layer.borderColor = UIColor.clearColor().CGColor
            batterylab6.layer.borderColor = UIColor.clearColor().CGColor
            batterylab7.layer.borderColor = UIColor.clearColor().CGColor
            batterylab8.layer.borderColor = UIColor.clearColor().CGColor
            batterylab9.layer.borderColor = UIColor.clearColor().CGColor
            batterylab10.layer.borderColor = UIColor.clearColor().CGColor
            batterylab11.layer.borderColor = UIColor.clearColor().CGColor
            batterylab12.layer.borderColor = UIColor.clearColor().CGColor
            batterylab13.layer.borderColor = UIColor.clearColor().CGColor
            batterylab14.layer.borderColor = UIColor.clearColor().CGColor
            batterylab15.layer.borderColor = UIColor.clearColor().CGColor
            batterylab16.layer.borderColor = UIColor.clearColor().CGColor
            batterylab17.layer.borderColor = UIColor.clearColor().CGColor
            batterylab18.layer.borderColor = UIColor.clearColor().CGColor


        }
        else if(Double(Appconstant.mainbalance) <= 19000.0)
        {batterylab1.layer.backgroundColor = colorlabel.CGColor
            batterylab2.layer.backgroundColor = colorlabel.CGColor
            batterylab3.layer.backgroundColor = colorlabel.CGColor
            batterylab4.layer.backgroundColor = colorlabel.CGColor
            batterylab5.layer.backgroundColor = colorlabel.CGColor
            batterylab6.layer.backgroundColor = colorlabel.CGColor
            batterylab7.layer.backgroundColor = colorlabel.CGColor
            batterylab8.layer.backgroundColor = colorlabel.CGColor
            batterylab9.layer.backgroundColor = colorlabel.CGColor
            batterylab10.layer.backgroundColor = colorlabel.CGColor
            batterylab11.layer.backgroundColor = colorlabel.CGColor
            batterylab12.layer.backgroundColor = colorlabel.CGColor
            batterylab13.layer.backgroundColor = colorlabel.CGColor
            batterylab14.layer.backgroundColor = colorlabel.CGColor
            batterylab15.layer.backgroundColor = colorlabel.CGColor
            batterylab16.layer.backgroundColor = colorlabel.CGColor
            batterylab17.layer.backgroundColor = colorlabel.CGColor
            batterylab18.layer.backgroundColor = colorlabel.CGColor
            batterylab19.layer.backgroundColor = colorlabel.CGColor
            batterylab1.layer.borderColor = UIColor.clearColor().CGColor
            batterylab2.layer.borderColor = UIColor.clearColor().CGColor
            batterylab3.layer.borderColor = UIColor.clearColor().CGColor
            batterylab4.layer.borderColor = UIColor.clearColor().CGColor
            batterylab5.layer.borderColor = UIColor.clearColor().CGColor
            batterylab6.layer.borderColor = UIColor.clearColor().CGColor
            batterylab7.layer.borderColor = UIColor.clearColor().CGColor
            batterylab8.layer.borderColor = UIColor.clearColor().CGColor
            batterylab9.layer.borderColor = UIColor.clearColor().CGColor
            batterylab10.layer.borderColor = UIColor.clearColor().CGColor
            batterylab11.layer.borderColor = UIColor.clearColor().CGColor
            batterylab12.layer.borderColor = UIColor.clearColor().CGColor
            batterylab13.layer.borderColor = UIColor.clearColor().CGColor
            batterylab14.layer.borderColor = UIColor.clearColor().CGColor
            batterylab15.layer.borderColor = UIColor.clearColor().CGColor
            batterylab16.layer.borderColor = UIColor.clearColor().CGColor
            batterylab17.layer.borderColor = UIColor.clearColor().CGColor
            batterylab18.layer.borderColor = UIColor.clearColor().CGColor
            batterylab19.layer.borderColor = UIColor.clearColor().CGColor

        }
     
        
        
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
            
            
            //            let HomeVc: HomeViewController = HomeViewController()
            //
            self.navigationController?.pushViewController(controller, animated: true)
            //            self.navigationController?.pushViewController(HomeVc, animated: true)
        }
        
        
        print("Selected view controller")
        
    }

}


















