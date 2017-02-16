//
//  ViewController.swift
//  Cippy
//
//  Created by apple on 15/11/16.
//  Copyright © 2016 vertace. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

//        var poseDuration: Float = 1.0
//    var indexProgressBar: Float = 0.0
//    var index = 0
//    var final = 10
//    var timer = NSTimer()
    

    @IBOutlet weak var funbankingimage: UIImageView!
    @IBOutlet weak var logoimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.logobackscrollview.minimumZoomScale = 1.0
//        self.logobackscrollview.maximumZoomScale = 6.0
//         NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 1))
//        // Do any additional setup after loading the view, typically from a nib.
//        progressView.layer.cornerRadius = 10
//        progressView.progress = 0.0
//        self.navigationController?.navigationBarHidden = true
//        timer = NSTimer.scheduledTimerWithTimeInterval(
//            0.1, target: self, selector: Selector("setProgressBar"), userInfo: nil, repeats: true)
        logoimage.layer.borderWidth = 2
        logoimage.layer.masksToBounds = false
        logoimage.layer.borderColor = UIColor(red:230/255.0, green:175/255.0, blue:7/255.0, alpha:1.0).CGColor;
        logoimage.layer.cornerRadius =  logoimage.frame.size.height/2
        logoimage.clipsToBounds = true
        funbankingimage.layer.borderWidth = 2
        funbankingimage.layer.masksToBounds = false
        funbankingimage.layer.borderColor = UIColor(red:230/255.0, green:175/255.0, blue:7/255.0, alpha:1.0).CGColor; 
        funbankingimage.layer.cornerRadius =  funbankingimage.frame.size.height/2
        funbankingimage.clipsToBounds = true
        func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
        {
            return self.logoimage
        }
        

        calldatabase()
//        logoimage.layer.shadowPath = UIBezierPath(rect:logoimage.bounds).CGPath
      
        
    }
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    func panView (recognizer: UIPanGestureRecognizer) {
//        
//        let translation = recognizer.translationInView(self.view)
//        
//        if let panView = recognizer.view {
//            
//            panView.center = CGPoint(x: panView.center.x + translation.x, y: panView.center.y + translation.y)
//            
//        }
//        
//        recognizer.setTranslation(CGPointZero, inView: self.view)
//        
//    }
    
//    func setProgressBar()
//    {
//        if index == final
//        {
//            calldatabase()
//            timer.invalidate()
//            
//            
//        }
//        progressView.progress = indexProgressBar
//        
//        // increment the counter
//        index += 2
//        indexProgressBar += 0.2
//    }
//
    func calldatabase(){
        DBHelper().purzDB()
        let databaseURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent("purz.db")
        let databasePath = databaseURL.absoluteString
        let purzDB = FMDatabase(path: databasePath as String)
        if purzDB.open() {
            
            let selectSQL = "SELECT * FROM PROFILE_INFO"
            
            let result:FMResultSet! = purzDB.executeQuery(selectSQL,
                withArgumentsInArray: nil)
            if (result.next()){
                print(result.stringForColumn("YAP_CODE"))
                Appconstant.customerid = result.stringForColumn("CUSTOMER_ID")
                Appconstant.pwd = result.stringForColumn("YAP_CODE")
                Appconstant.customername = result.stringForColumn("CUSTOMER_NAME")
                Appconstant.mobileno = result.stringForColumn("MOBILE_NUMBER")
                dispatch_async(dispatch_get_main_queue()) {
                  self.performSegueWithIdentifier("startviewtoFourdigitview", sender: self)
                }
            }
            else{
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("initial_to_signin", sender: self)
                }
            }
            
        }
        purzDB.close()
    }

}

class Alert: UIViewController {
    func alert(title: String,message: String)-> UIAlertController
    {
        let alert = UIAlertController(title: title,message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK",style: UIAlertActionStyle.Default, handler: nil))
        return alert
    }
}

