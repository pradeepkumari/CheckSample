//
//  HomeViewController.swift
//  Cippy
//
//  Created by apple on 16/11/16.
//  Copyright © 2016 vertace. All rights reserved.
//

import UIKit
import MapKit
class HomeViewController: UIViewController, UINavigationControllerDelegate,CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate
    
{
    
        @IBOutlet weak var Transactionlbl: UILabel!
    
    @IBOutlet weak var payatshoplbl: UILabel!
    @IBOutlet weak var sendoraskMoneyBtn: UIButton!
//    @IBOutlet weak var transactionview: UIView!
    @IBOutlet weak var addbtn: UIButton!
    
//    @IBOutlet weak var sidemenubtn: UIBarButtonItem!
    
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
    var sidemenubtn: UIBarButtonItem!
//    @IBOutlet var btnRightBadge: MIBadgeButton!
    var fromweb = false
    var alertmsg = ""
    override func viewDidLoad() {
        super.viewDidLoad()
//        tabBarController?.tabBar.items?[2].badgeValue = "2"
        tabBarItem = UITabBarItem(title: "", image: UIImage(named: "logout"), tag: 2)
//              UINavigationBar.appearance().barTintColor = UIColor(red: 250.0/255.0, green: 194.0/255.0, blue: 35.0/255.0, alpha: 1.0)
//        let badgeButton : MIBadgeButton = MIBadgeButton(frame: CGRectMake(0, 0, 40, 40))
//        badgeButton.setTitle("T1", forState: UIControlState.Normal)
//        badgeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        badgeButton.badgeString = "1";
//        let barButton : UIBarButtonItem = UIBarButtonItem(customView: badgeButton)
//        self.navigationItem.leftBarButtonItem = barButton//              sidemenubtn.addTarget(self, action: "action",
//                forControlEvents: UIControlEvents.TouchUpInside)
//        sidemenubtn.targetForAction(Selector("revealToggle:"), withSender: <#T##AnyObject?#>)
//        sidemenubtn.actionsForTarget(self.revealViewController(), forControlEvent: UIControlEvents.TouchUpInside)
   //                     self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
  sidemenubtn = UIBarButtonItem(image: UIImage(named: "menu_three_line.png"), style: .Plain, target: self, action: Selector("action"))
         navigationItem.leftBarButtonItem = sidemenubtn
        sidemenubtn.target = revealViewController()
        sidemenubtn.action = "revealToggle:"
        
        
        
        
//        scrollview.contentSize = CGSize(width: self.view.frame.size.width, height: 850)
        

        navigationController?.navigationBarHidden = false
        tableView.scrollEnabled = true;
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
tableView.layer.cornerRadius = 9
//        Transactionbtn.layer.cornerRadius = self.Transactionbtn.frame.size.height/2
//        Transactionbacklbl.layer.cornerRadius = 9
//        transactionlabl.layer.cornerRadius = 9
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //        locManager.requestWhenInUseAuthorization()
        //
        //        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
        //            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized){
        //
        //                currentLocation = locManager.location!
        //                print(currentLocation)
        //                print(currentLocation.coordinate.latitude)
        //                print(currentLocation.coordinate.longitude)
        //        }
              initialfunc()
        getbalancefromServer(Appconstant.BASE_URL+Appconstant.URL_FETCH_MULTI_BALANCE_INFO+Appconstant.customerid)
        print(Appconstant.BASE_URL+Appconstant.URL_FETCH_RECENT_TRANSACTIONS+Appconstant.customerid+"?pageNo=1&pageSize=3")
        getrecenttransaction(Appconstant.BASE_URL+Appconstant.URL_FETCH_RECENT_TRANSACTIONS+Appconstant.customerid+"?pageNo=1&pageSize=3")
        getplanlist(Appconstant.BASE_URL+Appconstant.URL_GETOPEARTORS)
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        print("No\(tabBarController?.selectedIndex)")
//       print("hte value\(tabBarController?.tabBarItem.tag)")
////         print("The Value of String is \(tabBarController?.selectedIndex)")
//        if(self.tabBarController?.selectedIndex == 2)
//       if( (tabBarController?.tabBarItem.tag)! == "2")
//
//             {
//                  exit(0)
//             }
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
        if(cippybalance != nil){
            balancelbl.text = cippybalance
        }
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
                            }
                            else{
                                self.balancelbl.text = balance_two_decimal
                                Appconstant.mainbalance = self.balancelbl.text!
                                
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
                
//                self.transactiontable()
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
        if(segue.identifier == "home_rechargeorbill") {
            let nextview = segue.destinationViewController as! RechargeorPayBillViewController
            nextview.pre_operatorCode = self.pre_operatorCode
            nextview.pre_operatorName = self.pre_operatorName
            nextview.pre_operatorId = self.pre_operatorId
            nextview.pre_operatorType = self.pre_operatorType
            nextview.pre_special = self.pre_special
            nextview.post_operatorCode = self.post_operatorCode
            nextview.post_operatorName = self.post_operatorName
            nextview.post_operatorId = self.post_operatorId
            nextview.post_operatorType = self.post_operatorType
            nextview.post_special = self.post_special
            nextview.dth_operatorCode = self.dth_operatorCode
            nextview.dth_operatorName = self.dth_operatorName
            nextview.dth_operatorId = self.dth_operatorId
            nextview.dth_operatorType = self.dth_operatorType
            nextview.dth_special = self.dth_special
        }
    }
    
}

    
    
       
    











