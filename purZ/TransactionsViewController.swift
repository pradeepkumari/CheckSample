//
//  TransactionViewController.swift
//  Cippy
//
//  Created by apple on 30/11/16.
//  Copyright © 2016 vertace. All rights reserved.
//
import UIKit
class TransactionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate{
    
    @IBOutlet weak var badgebtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var transactionlbl: UILabel!
    
    var transactionamt = [String]()
    // var transactionamt1 = [String]()
    var trans_date = [String]()
    var trans_type = [String]()
    var type = [String]()
    var txref = [String]()
    var ben_name = [String]()
    var ben_id = [String]()
    var descriptions = [String]()
    var otherpartyname = [String]()
    var otherpartyid = [String]()
    var txnorigin = [String]()
    var trans_status = [String]()
    var externalTransactionId = [String]()
    var selected = [Bool]()
    var refresh = true
    var transactionsItem = [TransactionModel]()
    var FilteredItems = [TransactionModel]()
    var cellheight = [Bool]()
    // var fromsplitbill = false
    var tx_ref = ""
    var benname = ""
    var time = ""
    //  var splitamt = ""
    var refreshControl = UIRefreshControl()
    var fromhome = false
    var selectedindex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Appconstant.BASE_URL+Appconstant.URL_FETCH_RECENT_TRANSACTIONS+Appconstant.customerid+"?pageNo=1&pageSize=10")
            Appconstant.SideMenu = 0;
        tabBarController?.delegate = self
          transactionlbl.text = "No transactions yet!\nBut you can change that in a jiffy...\nTry out our easy Recharge & Bill payments, Or do you fancy some other features?"
        transactionlbl.tintColor = UIColor.blueColor()
        transactionlbl.numberOfLines = 5
        navigationController?.navigationBarHidden = true
        badgebtn.layer.cornerRadius = badgebtn.frame.size.height/2
        initializefunc()
        calltransactiontable()
        badgebtn.userInteractionEnabled = false
        refreshControl.addTarget(self, action: "refreshaction", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
//       getTentransaction()
        
    }
    
    
    func initializefunc(){
        badgebtn.layer.cornerRadius = badgebtn.frame.size.height/2
        if(Appconstant.notificationcount > 0){
            badgebtn.hidden = false
            badgebtn.setTitle("\(Appconstant.notificationcount)", forState: .Normal)
        }
        else{
            badgebtn.hidden = true
        }
        let bottomLine = CALayer()
        let topLine = CALayer()
        
        bottomLine.borderWidth = 1
        topLine.backgroundColor = UIColor.whiteColor().CGColor
        bottomLine.backgroundColor = UIColor.blackColor().CGColor
             transactionlbl.hidden = true
        titlelbl.hidden = false
    }
    func calltransactiontable(){
        DBHelper().purzDB()
        let databaseURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent("purz.db")
        let databasePath = databaseURL.absoluteString
        let purzDB = FMDatabase(path: databasePath as String)
        if purzDB.open() {
            let selectSQL = "SELECT * FROM TRANSACTIONS"
            
            let result:FMResultSet! = purzDB.executeQuery(selectSQL,
                                                          withArgumentsInArray: nil)
            
            while(result.next()){
                transactionamt.append(result.stringForColumn("AMOUNT"))
                trans_type.append(result.stringForColumn("TRANSACTION_TYPE"))
                type.append(result.stringForColumn("TYPE"))
                trans_date.append(result.stringForColumn("TIME"))
                txref.append(result.stringForColumn("TX_REF"))
                ben_name.append(result.stringForColumn("BENEFICIARY_NAME"))
                ben_id.append(result.stringForColumn("BENEFICIARY_ID"))
                descriptions.append(result.stringForColumn("DESCRIPTION"))
                otherpartyname.append(result.stringForColumn("OTHER_PARTY_NAME"))
                otherpartyid.append(result.stringForColumn("OTHER_PARTY_ID"))
                txnorigin.append(result.stringForColumn("TXN_ORIGIN"))
                trans_status.append(result.stringForColumn("TRANSACTION_STATUS"))
                self.selected.append(false)
            }
            if fromhome{
                self.selected[selectedindex] = true
            }
            for(var i = 0; i<self.transactionamt.count; i++){
                let transaction = TransactionModel(amount: self.transactionamt[i], trans_type: self.trans_type[i], type: self.type[i], time: self.trans_date[i], tx_ref: self.txref[i], beneficiaryname: self.ben_name[i], beneficiaryid: self.ben_id[i], descripition: self.descriptions[i], otherpartyname: self.otherpartyname[i], otherpartyid: self.otherpartyid[i], txnorigin: self.txnorigin[i], transactionstatus: self.trans_status[i])!
                self.transactionsItem += [transaction]
                if((self.type[i] == "DEBIT") && (Double(self.transactionamt[i]) >= 2.0)){
                    self.cellheight.append(true)
//                    self.getTentransaction(Appconstant.BASE_URL+Appconstant.URL_FETCH_RECENT_TRANSACTIONS+Appconstant.customerid+"?pageNo=1&pageSize=10")

                }
                else{
                    self.cellheight.append(false)
                }
                
            }
            self.FilteredItems = self.transactionsItem
            
        }
        purzDB.close()
         dispatch_async(dispatch_get_main_queue())
         {
        if self.transactionamt.count == 0{
            print("gfhhjh\(self.transactionamt)")
            self.tableView.hidden = true
            self.transactionlbl.hidden = false
            }
        }
    }
    
    func refreshaction(){
        if refresh{
            self.view.userInteractionEnabled = false
            DBHelper().purzDB()
            let databaseURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent("purz.db")
            let databasePath = databaseURL.absoluteString
            let purzDB = FMDatabase(path: databasePath as String)
            
            if purzDB.open() {
                
                let delete = "DELETE FROM TRANSACTIONS"
                let result = purzDB.executeUpdate(delete,
                                                  withArgumentsInArray: nil)
                if !result {
                    //   status.text = "Failed to add contact"
                    print("Error: \(purzDB.lastErrorMessage())")
                }
                
            }
            print(Appconstant.BASE_URL+Appconstant.URL_FETCH_RECENT_TRANSACTIONS+Appconstant.customerid+"?pageNo=1&pageSize=10")
            self.getTentransaction(Appconstant.BASE_URL+Appconstant.URL_FETCH_RECENT_TRANSACTIONS+Appconstant.customerid+"?pageNo=1&pageSize=10")
        }
        else{
            self.refreshControl.endRefreshing()
        }
    }
    
    
    
    func textField(textFieldToChange: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
    }
    
    
    func getTentransaction(url: String){
        
        
        self.view.userInteractionEnabled = false
        activityIndicator.startAnimating()
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "GET"
        request.addValue("Basic YWRtaW46WRtaW4=", forHTTPHeaderField: "Authorization")
        request.addValue(Appconstant.TENANT, forHTTPHeaderField: "TENANT")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
        { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                self.activityIndicator.stopAnimating()
                self.view.userInteractionEnabled = true
                if Reachability.isConnectedToNetwork() == true {
                } else {
                    print("Internet connection FAILED")
                    dispatch_async(dispatch_get_main_queue()) {
                        self.presentViewController(Alert().alert("Internet is being a bummer.. Please check net connections and try again!", message: ""),animated: true,completion: nil)
                    }
                    
                }
                self.refreshControl.endRefreshing()
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                self.view.userInteractionEnabled = true
                self.refreshControl.endRefreshing()
                dispatch_async(dispatch_get_main_queue()) {
                    self.activityIndicator.stopAnimating()
                }
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            let json = JSON(data: data!)
            self.refreshControl.endRefreshing()
            self.transactionamt.removeAll()
            self.trans_date.removeAll()
            
            self.transactionamt.removeAll()
            self.trans_date.removeAll()
            self.trans_type.removeAll()
            self.type.removeAll()
            self.txref.removeAll()
            self.ben_name.removeAll()
            self.ben_id.removeAll()
            self.descriptions.removeAll()
            self.otherpartyname.removeAll()
            self.otherpartyid.removeAll()
            self.txnorigin.removeAll()
            self.trans_status.removeAll()
            self.externalTransactionId.removeAll()
            self.selected.removeAll()
            
            self.transactionsItem.removeAll()
            
            for item1 in json["result"].arrayValue{
                let item = item1["transaction"]
                
                self.trans_type.append(item["transactionType"].stringValue)
                self.type.append(item["type"].stringValue)
                self.txref.append(item["txRef"].stringValue)
                self.ben_name.append(item["beneficiaryName"].stringValue)
                if(!item["beneficiaryId"].stringValue.isEmpty){
                    let benid = item["beneficiaryId"].stringValue.componentsSeparatedByString("+91")
                    print(benid)
                    var i = 0
                    for(i=0; i<benid.count; i++){
                        
                    }
                    self.ben_id.append(benid[i-1])
                }
                else{
                    self.ben_id.append(item["beneficiaryId"].stringValue)
                }
                
                let matches = self.matchesForRegexInText("[0-9]", text: item["description"].stringValue)
                let desc = matches.joinWithSeparator("")
                self.descriptions.append(desc)
                self.otherpartyname.append(item["otherPartyName"].stringValue)
                self.otherpartyid.append(item["otherPartyId"].stringValue)
                self.txnorigin.append(item["txnOrigin"].stringValue)
                self.trans_status.append(item["transactionStatus"].stringValue)
                self.externalTransactionId.append(item["externalTransactionId"].stringValue)
                self.selected.append(false)
                
                let balance_two_decimal = String(format: "%.2f", item["amount"].doubleValue)
                let amt = balance_two_decimal.componentsSeparatedByString(".")
                if(amt[1].characters.count == 1){
                    let finalamount = balance_two_decimal + "0"
                    self.transactionamt.append(finalamount)
                }
                else{
                    self.transactionamt.append(balance_two_decimal)
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
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.activityIndicator.stopAnimating()
                
            }
            for(var i = 0; i<self.transactionamt.count; i++){
                let transaction = TransactionModel(amount: self.transactionamt[i], trans_type: self.trans_type[i], type: self.type[i], time: self.trans_date[i], tx_ref: self.txref[i], beneficiaryname: self.ben_name[i], beneficiaryid: self.ben_id[i], descripition: self.descriptions[i], otherpartyname: self.otherpartyname[i], otherpartyid: self.otherpartyid[i], txnorigin: self.txnorigin[i], transactionstatus: self.trans_status[i])!
                self.transactionsItem += [transaction]
                if((self.type[i] == "DEBIT") && (Double(self.transactionamt[i]) >= 2.0)){
                    self.cellheight.append(true)
                }
                else{
                    self.cellheight.append(false)
                }
                
                DBHelper().purzDB()
                let databaseURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent("purz.db")
                let databasePath = databaseURL.absoluteString
                let purzDB = FMDatabase(path: databasePath as String)
                if purzDB.open() {
                    
                    let insert = "INSERT INTO TRANSACTIONS (AMOUNT,BENEFICIARY_ID,TRANSACTION_TYPE,TYPE,TIME,TRANSACTION_STATUS,TX_REF,BENEFICIARY_NAME,DESCRIPTION,OTHER_PARTY_NAME,OTHER_PARTY_ID,TXN_ORIGIN) VALUES"
                    let value0 =  "('"+self.transactionamt[i]+"','\(self.ben_id[i])','\(self.trans_type[i])','\(self.type[i])',"
                    let value1 = "'"+self.trans_date[i]+"','\(self.trans_status[i])','\(self.txref[i])','\(self.ben_name[i])',"
                    let value2 = "'\(self.descriptions[i])','\(self.otherpartyname[i])','\(self.otherpartyid[i])','\(self.txnorigin[i])')"
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
            dispatch_async(dispatch_get_main_queue()) {
                if self.refresh{
                    self.refresh = false
                    self.presentViewController(Alert().alert("Yey! Transaction list is here, have a look.", message: ""),animated: true,completion: nil)
                    
                }
            }
            self.FilteredItems.removeAll()
            self.FilteredItems = self.transactionsItem
            dispatch_async(dispatch_get_main_queue()) {
                if(self.FilteredItems.count == 0){
                    self.transactionlbl.hidden = false
                    self.tableView.hidden = true
                }
                self.view.userInteractionEnabled = true
                self.tableView.reloadData()
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TransactionCell", forIndexPath: indexPath) as UITableViewCell!
        print(indexPath.row)
        //        if(indexPath.row % 2 == 0){
        //            cell.backgroundColor = UIColor(red: 212.0/255.0, green: 242.0/255.0, blue: 246.0/255.0, alpha: 1)
        //        }
        //        else{
        //            cell.backgroundColor = UIColor(red: 238.0/255.0, green: 247.0/255.0, blue: 250.0/255.0, alpha: 1)
        //        }
        //
        //        let border = CALayer()
        //        let width = CGFloat(0.6)
        //        border.borderColor = UIColor.lightGrayColor().CGColor
        //        border.frame = CGRect(x: 0, y: cell.frame.size.height - width, width:  cell.frame.size.width, height: cell.frame.size.height)
        //
        //        border.borderWidth = width
        //        cell.layer.addSublayer(border)
        //        cell.layer.masksToBounds = true
        
        let symbolimg = cell.viewWithTag(1) as! UIImageView
        
        let trans_namelbl = cell.viewWithTag(11) as! UILabel
        let trans_namelbl2 = cell.viewWithTag(41) as! UILabel
        
        let amountlbl = cell.viewWithTag(13) as! UILabel
        let amountlbl2 = cell.viewWithTag(42) as! UILabel
        
        let time1lbl = cell.viewWithTag(12) as! UILabel
        let time2lbl = cell.viewWithTag(21) as! UILabel
        let mobilelbl = cell.viewWithTag(43) as! UILabel
        
        let image1 = cell.viewWithTag(31)
        let image2 = cell.viewWithTag(32)
        let image3 = cell.viewWithTag(33)
        let image4 = cell.viewWithTag(34)
        
        
        
        //  let descriptionlbl = cell.viewWithTag(22) as! UILabel
        // let splitbillbtn = cell.viewWithTag(9) as! UIButton
        let share = cell.viewWithTag(3) as! UIButton
        // splitbillbtn.layer.cornerRadius = 7
        share.hidden = true
        trans_namelbl2.hidden = true
        amountlbl2.hidden = true
        mobilelbl.hidden = true
        image1!.hidden = true
        image2!.hidden = true
        image3!.hidden = true
        image4!.hidden = true
        
        //  splitbillbtn.hidden = true
        let transaction = FilteredItems[indexPath.row]
        time1lbl.text = transaction.time
        time2lbl.text = transaction.time
        amountlbl.text = "₹ " + transaction.amount
        amountlbl2.text = "₹ " + transaction.amount
        mobilelbl.text = transaction.tx_ref
        
        if((transaction.type == "DEBIT") && (transaction.trans_type == "TPP")) {
            
            trans_namelbl.text = "to " + transaction.beneficiaryname
            trans_namelbl2.text = "to " + transaction.beneficiaryname
            
        }
        else if((transaction.type == "CREDIT") && (transaction.trans_type == "RCHREV")) {
            
            trans_namelbl.text = "From " + transaction.beneficiaryname
            trans_namelbl2.text = "From " + transaction.beneficiaryname
            
            
        }
        else if((transaction.type == "DEBIT") && (transaction.trans_type == "C2M")) {
            
            trans_namelbl.text = "to " + transaction.beneficiaryname
            trans_namelbl2.text = "to " + transaction.beneficiaryname
            
        }
        
        
        if((transaction.type == "DEBIT") && (transaction.trans_type == "C2C")) {
            trans_namelbl.text = "to " + transaction.beneficiaryname
            trans_namelbl2.text = "to " + transaction.beneficiaryname
            
        }
        else if((transaction.type == "CREDIT") && (transaction.trans_type == "C2C")) {
            trans_namelbl.text = "From " + transaction.beneficiaryname
            trans_namelbl2.text = "From " + transaction.beneficiaryname
            
            
        }
            
        else if((transaction.type == "CREDIT") && ((transaction.trans_type == "PG") || (transaction.trans_type == "M2C"))) {
            
            trans_namelbl.text = "From " + transaction.beneficiaryname
            trans_namelbl2.text = "From " + transaction.beneficiaryname
            
        }
        
        
        // descriptionlbl.text = "You have Successfully Paid Bill of " + "₹" + transaction.amount + " to " + transaction.beneficiaryname + ", reference transaction no is " + transaction.tx_ref
        
        //        if((transaction.type == "DEBIT") && (transaction.trans_type == "TPP")) {
        //            descriptionlbl.text = "You have Recharged " + "₹" + transaction.amount + " on " + descriptions[indexPath.row] + " account"
        //            trans_namelbl.text =  "Recharged"
        //        }
        //        else if((transaction.type == "CREDIT") && (transaction.trans_type == "RCHREV")) {
        //            descriptionlbl.text = "You have credited " + "₹" + transaction.amount + " as Recharge reversal"
        //            trans_namelbl.text = "Recharge - Failed"
        //        }
        //        else if((transaction.type == "DEBIT") && (transaction.trans_type == "C2M")) {
        //            descriptionlbl.text = "You have Successfully Paid Bill of " + "₹" + transaction.amount + " to " + transaction.beneficiaryname + ", reference transaction no is " + transaction.tx_ref
        //            trans_namelbl.text = "Paid Bill - Successful"
        //        }
        
        //        else if((transaction.type == "DEBIT") && (transaction.trans_type == "C2C")) {
        //            descriptionlbl.text = "You have Successfully Sent " + "₹" + transaction.amount + " to " + transaction.beneficiaryid
        //            trans_namelbl.text = "Sent - Successful"
        //        }
        //        else if((transaction.type == "CREDIT") && (transaction.trans_type == "C2C")) {
        //            descriptionlbl.text = "You have Successfully Received " + "₹" + transaction.amount + " from " + transaction.beneficiaryid
        //            trans_namelbl.text = "Received - Successful"
        //        }
        //        else if((transaction.type == "CREDIT") && ((transaction.trans_type == "PG") || (transaction.trans_type == "M2C"))) {
        //            descriptionlbl.text = "You have Successfully Loaded " + "₹" + transaction.amount + ", reference transaction no is " + transaction.tx_ref
        //            trans_namelbl.text = "Loaded Cippy"
        //        }
        
        
        if selected[indexPath.row]{
            
            
            
            if(transaction.type == "DEBIT") {
                //                trans_namelbl.text = "to " + transaction.beneficiaryname
                //                trans_namelbl2.text = "to " + transaction.beneficiaryname
                //
                symbolimg.image = UIImage(named: "Out.png")
                
            }
            else if(transaction.type == "CREDIT") {
                //                trans_namelbl.text = "From " + transaction.beneficiaryname
                //                trans_namelbl2.text = "From " + transaction.beneficiaryname
                //
                
                symbolimg.image = UIImage(named: "In.png")
                
            }
            
            
            trans_namelbl.hidden = true
            time1lbl.hidden = true
            amountlbl.hidden = true
            time2lbl.hidden = false
            trans_namelbl2.hidden = false
            amountlbl2.hidden = false
            
            mobilelbl.hidden = false
            image1!.hidden = false
            image2!.hidden = false
            image3!.hidden = false
            image4!.hidden = false
            //   border.borderColor = UIColor.clearColor().CGColor
            
            //  descriptionlbl.hidden = false
            share.hidden = false
            //            if((transaction.type == "DEBIT") && (Double(transaction.amount) >= 2.0)){
            //                splitbillbtn.hidden = false
            //            }
            //            else{
            //                splitbillbtn.hidden = true
            //            }
        }
        else{
            // border.borderColor = UIColor.clearColor().CGColor
            //            symbolimg.hidden = false
            
            
            if(transaction.type == "DEBIT") {
                //                trans_namelbl.text = "to " + transaction.beneficiaryname
                //                trans_namelbl2.text = "to " + transaction.beneficiaryname
                //
                symbolimg.image = UIImage(named: "Out.png")
                
            }
            else if(transaction.type == "CREDIT") {
                //                trans_namelbl.text = "From " + transaction.beneficiaryname
                //                trans_namelbl2.text = "From " + transaction.beneficiaryname
                //
                
                symbolimg.image = UIImage(named: "In.png")
                
            }
            
            time2lbl.hidden = true
            //  descriptionlbl.hidden = true
            trans_namelbl.hidden = false
            time1lbl.hidden = false
            amountlbl.hidden = false
            //  splitbillbtn.hidden = true
            share.hidden = true
        }
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return FilteredItems.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let selectionColor = UIView() as UIView
        selectionColor.layer.borderWidth = 1
        selectionColor.layer.borderColor = UIColor.clearColor().CGColor
        selectionColor.backgroundColor = UIColor.clearColor()
        cell.selectedBackgroundView = selectionColor
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(type[indexPath.row])
        //        if fromsplitbill{
        //            tx_ref = self.txref[indexPath.row]
        //            benname = self.ben_name[indexPath.row]
        //            time = trans_date[indexPath.row]
        //            splitamt = transactionamt[indexPath.row]
        //            if(Double(splitamt)! < 2){
        //                dispatch_async(dispatch_get_main_queue()) {
        //                    self.presentViewController(Alert().alert("Please select value more than ₹2", message: ""),animated: true,completion: nil)
        //
        //                }
        //            }
        //
        //            else if(type[indexPath.row] == "CREDIT"){
        //                dispatch_async(dispatch_get_main_queue()) {
        //                    self.presentViewController(Alert().alert("Please select transaction paid from your wallet. Or simply type the amount you want to split!", message: ""),animated: true,completion: nil)
        //
        //                }
        //            }
        //            else{
        //                self.activityIndicator.startAnimating()
        //               // self.sendrequesttoserverToCheckSplitBill(Appconstant.BASE_URL+Appconstant.URL_SPLIT_TRANSACTION+tx_ref)
        //            }
        //        }
        
        if selected[indexPath.row] {
            selected[indexPath.row] = false
        }
        else{
            selected[indexPath.row] = true
        }
        self.view.endEditing(true)
        self.tableView.reloadRowsAtIndexPaths([tableView.indexPathForSelectedRow!], withRowAnimation: .Fade)
        print(indexPath.row)
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if selected[indexPath.row]{
            
            if cellheight[indexPath.row]{
                return 130
            }
            else{
                return 130
            }
        }
        else{
            return 70
        }
        return 70
    }
    
    @IBAction func shareBtnAction(sender: AnyObject) {
        let point = sender.convertPoint(CGPointZero, toView: tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(point)!
        
        var msg = "Message"
        //        let msg = "Share your message"
        
        if(self.trans_type[indexPath.row] == "TPP") {
            msg = "On " + self.trans_date[indexPath.row] + ", " + self.ben_name[indexPath.row] + " has Recharged ₹ " + self.transactionamt[indexPath.row] + " on " + self.descriptions[indexPath.row] + " account"
        }
        else if((self.trans_type[indexPath.row] == "C2C") && (self.type[indexPath.row] == "DEBIT")) {
            msg = "On " + self.trans_date[indexPath.row] + ", " + self.ben_name[indexPath.row] + " has Sent ₹ " + self.transactionamt[indexPath.row] + " to " + self.ben_id[indexPath.row]
        }
        else if ((self.trans_type[indexPath.row] == "C2C") && (self.type[indexPath.row] == "CREDIT")) {
            msg = "On " + self.trans_date[indexPath.row] + ", " + self.ben_name[indexPath.row] + " has Received ₹ " + self.transactionamt[indexPath.row] + " from " + self.ben_id[indexPath.row]
        }
        else if ((self.trans_type[indexPath.row] == "C2M") && (self.type[indexPath.row] == "DEBIT")) {
            msg = "On " + self.trans_date[indexPath.row] + ", " + self.ben_name[indexPath.row] + " has Paid ₹ " + self.transactionamt[indexPath.row] + " to " + self.ben_name[indexPath.row] + ",reference transaction no is " + self.txref[indexPath.row]
        }
        else if ((self.trans_type[indexPath.row] == "PG") || (self.trans_type[indexPath.row] == "M2C") && (self.type[indexPath.row] == "CREDIT")) {
            msg = "On " + self.trans_date[indexPath.row] + ", " + self.ben_name[indexPath.row] + " has Loaded ₹ " + self.transactionamt[indexPath.row] + " to Cippy,Reference transaction no is " + self.txref[indexPath.row]
        }
        
        let objectsToShare = [msg]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        activityVC.excludedActivityTypes = [ UIActivityTypePostToFacebook, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo, UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop, UIActivityTypeOpenInIBooks, UIActivityTypeAddToReadingList]
        
        if let urlString = msg.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.sharedApplication().canOpenURL(whatsappURL) {
                    UIApplication.sharedApplication().openURL(whatsappURL)
                } else {
                    // Cannot open whatsapp
                }
            }
        }
        activityVC.popoverPresentationController?.sourceView = sender as? UIView
        self.presentViewController(activityVC, animated: true, completion: nil)
        
    }
    
    //    @IBAction func billsplitBtnAction(sender: AnyObject) {
    //
    //        let point = sender.convertPoint(CGPointZero, toView: tableView)
    //        let indexPath = self.tableView.indexPathForRowAtPoint(point)!
    //        tx_ref = self.txref[indexPath.row]
    //        benname = self.ben_name[indexPath.row]
    //        time = trans_date[indexPath.row]
    //        splitamt = transactionamt[indexPath.row]
    //       self.activityIndicator.startAnimating()
    //        self.sendrequesttoserverToCheckSplitBill(Appconstant.BASE_URL+Appconstant.URL_SPLIT_TRANSACTION+tx_ref)
    //
    //    }
    func sendrequesttoserverToCheckSplitBill(url : String)
    {
        self.view.userInteractionEnabled = false
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "GET"
        print(url)
        request.addValue("BaYsic YWRtaW46WRtaW4=", forHTTPHeaderField: "Authorization")
        request.addValue(Appconstant.TENANT, forHTTPHeaderField: "TENANT")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
        { data, response, error in
            guard error == nil && data != nil else {
                self.view.userInteractionEnabled = true
                self.activityIndicator.stopAnimating()// check for fundamental networking error
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
                dispatch_async(dispatch_get_main_queue()) {
                    self.activityIndicator.stopAnimating()
                }
                //                    dispatch_async(dispatch_get_main_queue()) {
                //                        self.presentViewController(Alert().alert("Uh - Oh! Something went wrong, let's start again!", message: ""),animated: true,completion: nil)
                //                    }
            }
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            let json = JSON(data: data!)
            self.view.userInteractionEnabled = true
            dispatch_async(dispatch_get_main_queue()) {
                self.activityIndicator.stopAnimating()
            }
            let item = json["exception"]
            if item["detailMessage"].stringValue == "No Split Found"{
                self.performSegueWithIdentifier("trans_splitbill", sender: self)
            }
            else{
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(Alert().alert("Looks like this bill is already split! Please Check again.", message: ""),animated: true,completion: nil)
                    
                }
            }
        }
        
        task.resume()
        
    }
    
    
    @IBAction func backBtnAction(sender: AnyObject) {
        //        if fromsplitbill{
        //            self.performSegueWithIdentifier("goto_splitbill", sender: self)
        //        }
        //        else{
        self.performSegueWithIdentifier("back_trans_home", sender: self)
        
        
        
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
        print(viewController.parentViewController)
        print(viewController)
        
        
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
            print("Selected item")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("HomeView")
           self.navigationController?.pushViewController(controller, animated: true)
                    }
        else if tabBarIndex == 1 {
            print("Selected item")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("MyAccount")
            self.navigationController?.pushViewController(controller, animated: true)
            //            self.navigationController?.pushViewController(HomeVc, animated: true)
        }

        
        print("Selected view controller")
        
    }
    
}
