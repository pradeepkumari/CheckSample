//
//  FourdigitpasswordViewController.swift
//  Cippy
//
//  Created by Vertace on 20/01/17.
//  Copyright © 2017 vertace. All rights reserved.
//

import UIKit
import QuartzCore


class FourdigitpasswordViewController: UIViewController {
    var pwd: String = ""
    var counter: Int = 0
    var pwdarr = [String]()
    
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var btn2: UIButton!
    
   @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
     @IBOutlet weak var btn7: UIButton!
    
    @IBOutlet weak var btn8: UIButton!
    
    @IBOutlet weak var btn9: UIButton!
    
    @IBOutlet weak var btn0: UIButton!
    
    @IBOutlet weak var backwardbtn: UIButton!
    
    @IBOutlet weak var clickherebtn: UIButton!
    @IBOutlet weak var roundlab1: UILabel!
    
    @IBOutlet weak var roundlab2: UILabel!
    
    @IBOutlet weak var roundlab4: UILabel!
    @IBOutlet weak var roundlab3: UILabel!
    
    @IBOutlet weak var namelbl: UILabel!
          override func viewDidLoad() {
        super.viewDidLoad()
            navigationController?.navigationBarHidden = true
               namelbl.text = "Hi," + Appconstant.customername + "!"
        namelbl.layer.borderColor = UIColor.clearColor().CGColor
//        namelbl.textColor = UIColor.yellowColor()
            // Do any additional setup after loading the view.
        btn1.layer.cornerRadius = self.btn1.frame.size.height/2
        btn2.layer.cornerRadius = self.btn2.frame.size.height/2
        
        btn3.layer.cornerRadius = self.btn3.frame.size.height/2
        btn4.layer.cornerRadius = self.btn4.frame.size.height/2
        btn5.layer.cornerRadius = self.btn5.frame.size.height/2

        btn6.layer.cornerRadius = self.btn6.frame.size.height/2
        btn7.layer.cornerRadius = self.btn7.frame.size.height/2
        btn8.layer.cornerRadius = self.btn8.frame.size.height/2

        btn9.layer.cornerRadius = self.btn9.frame.size.height/2
        
        btn0.layer.cornerRadius = self.btn0.frame.size.height/2
         backwardbtn.layer.cornerRadius = self.btn0.frame.size.height/2
        roundlab1.layer.cornerRadius = self.roundlab1.frame.size.height/2
        roundlab1.layer.masksToBounds = true
        roundlab1.layer.borderWidth = 1.0
        roundlab1.layer.borderColor = UIColor.blackColor().CGColor
        roundlab2.layer.cornerRadius = self.roundlab2.frame.size.height/2
        roundlab2.layer.masksToBounds = true
        roundlab2.layer.borderWidth = 1.0
       roundlab2.layer.borderColor = UIColor.blackColor().CGColor
        roundlab3.layer.cornerRadius = self.roundlab3.frame.size.height/2
        roundlab3.layer.masksToBounds = true
        roundlab3.layer.borderWidth = 1.0
        roundlab3.layer.borderColor = UIColor.blackColor().CGColor
        roundlab4.layer.cornerRadius = self.roundlab4.frame.size.height/2
        roundlab4.layer.masksToBounds = true
        roundlab4.layer.borderWidth = 1.0
        roundlab4.layer.borderColor = UIColor.blackColor().CGColor
        let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
        clickherebtn.titleLabel?.attributedText = NSAttributedString(string: "Click here!", attributes: underlineAttribute)

        namedbcall()
    }
    func namedbcall()
    {
let databaseURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent("purz.db")
let databasePath = databaseURL.absoluteString
let purzDB = FMDatabase(path: databasePath as String)
if purzDB.open() {
    let selectSQL = "SELECT CUSTOMER_NAME FROM PROFILE_INFO"
    
    let result:FMResultSet! = purzDB.executeQuery(selectSQL,
        withArgumentsInArray: nil)
//    namelab.text = result.stringForColumn("CUSTOMER_NAME")
    
        }
    }
    
    @IBAction func onebtnAction(sender: AnyObject) {
        pwd = pwd + "1"
        pwdarr.append("1")
    labelfill()
        
    }
    
    @IBAction func twobtnAction(sender: AnyObject) {
    pwd = pwd + "2"
        pwdarr.append("2")
        labelfill()
    }
    
    @IBAction func threebtnAction(sender: AnyObject) {
         pwd = pwd + "3"
        pwdarr.append("3")
        labelfill()
    }
        @IBAction func fourbtnAction(sender: AnyObject) {
         pwd = pwd + "4"
            pwdarr.append("4")
            labelfill()
    }
    
    @IBAction func fivebtnAction(sender: AnyObject) {
        pwd = pwd + "5"
        pwdarr.append("5")
        labelfill()
}
   
    @IBAction func sixbtnAction(sender: AnyObject) {
        pwd = pwd + "6"
        pwdarr.append("6")
        labelfill()

    }
    @IBAction func sevenbtnAction(sender: AnyObject) {
        pwd = pwd + "7"
        pwdarr.append("7")
        labelfill()

    }
    @IBAction func eightbtnAction(sender: AnyObject) {
   
            pwd = pwd + "8"
        pwdarr.append("8")
        labelfill()
    }
    
    @IBAction func ninebtnAction(sender: AnyObject) {
        pwd = pwd + "9"
        pwdarr.append("9")
        labelfill()

    }
    
    @IBAction func zerobtnAction(sender: AnyObject) {
        pwd = pwd + "0"
        pwdarr.append("0")
        labelfill()
}
    
    func labelfill()
    {
       print(pwd)
   if(pwdarr.count == 1)
    {
       roundlab1.backgroundColor = UIColor.blackColor()
        roundlab2.backgroundColor = UIColor.whiteColor()
        roundlab3.backgroundColor = UIColor.whiteColor()
        roundlab4.backgroundColor = UIColor.whiteColor()
    
    }
        else if(pwdarr.count == 2)
        {
             roundlab1.backgroundColor = UIColor.blackColor()
             roundlab2.backgroundColor = UIColor.blackColor()
            roundlab3.backgroundColor = UIColor.whiteColor()
            roundlab4.backgroundColor = UIColor.whiteColor()
        }
    
    else if(pwdarr.count == 3)
    {
        roundlab1.backgroundColor = UIColor.blackColor()
        roundlab2.backgroundColor = UIColor.blackColor()
        roundlab3.backgroundColor = UIColor.blackColor()
        roundlab4.backgroundColor = UIColor.whiteColor()
        }
    else if(pwdarr.count == 4)
    {
        roundlab1.backgroundColor = UIColor.blackColor()
        roundlab2.backgroundColor = UIColor.blackColor()
        roundlab3.backgroundColor = UIColor.blackColor()
        roundlab4.backgroundColor = UIColor.blackColor()
        
        if(pwd == Appconstant.pwd)
        {
            self.performSegueWithIdentifier("fourdigittohome", sender: self)
        }
           else
        {
            dispatch_async(dispatch_get_main_queue()) {
                self.presentViewController(Alert().alert("Invalid Password", message: ""),animated: true,completion: nil)
            }
            pwd = ""
            pwdarr.removeAll()
            roundlab1.backgroundColor = UIColor.whiteColor()
            roundlab2.backgroundColor = UIColor.whiteColor()
            roundlab3.backgroundColor = UIColor.whiteColor()
            roundlab4.backgroundColor = UIColor.whiteColor()
    }
   }
       else if(pwdarr.count == 0)
        {
            roundlab1.backgroundColor = UIColor.whiteColor()
            roundlab2.backgroundColor = UIColor.whiteColor()
            roundlab3.backgroundColor = UIColor.whiteColor()
            roundlab4.backgroundColor = UIColor.whiteColor()
        }

   }

    
    @IBAction func backward(sender: AnyObject) {
        
// var someNumb: Int = Int(pwd)
        if pwd != ""{
        let someNumb: Int = Int(pwd)!/10
        pwd = String(someNumb)
            if pwdarr.count > 0 {
        pwdarr.removeLast()
            }
        counter = pwd.characters.count
            labelfill()
        }
        
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
