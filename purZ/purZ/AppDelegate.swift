//
//  AppDelegate.swift
//  Cippy
//
//  Created by apple on 15/11/16.
//  Copyright © 2016 vertace. All rights reserved.
//

import UIKit
import Contacts
import Google

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GGLInstanceIDDelegate, GCMReceiverDelegate  {

    var window: UIWindow?
    var connectedToGCM = false
    var subscribedToTopic = false
    var gcmSenderID: String = "684097176981"
    var registrationToken: String?
    var registrationOptions = [String: AnyObject]()
    
    let registrationKey = "onRegistrationCompleted"
    let messageKey = "onMessageReceived"
    let subscriptionTopic = "/topics/global"

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
//       FIRApp.configure()
        
       
//        UILabel.appearance().font = UIFont(name: "calibri", size: .NaN)
//        UIButton.appearance().titleLabel?.font = UIFont(name: "calibri", size: .NaN)!
        
        if #available(iOS 8.0, *) {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        } else {
            // Fallback
            let types: UIRemoteNotificationType = [.Alert, .Badge, .Sound]
            application.registerForRemoteNotificationTypes(types)
        }
        let gcmConfig = GCMConfig.defaultConfig()
        gcmConfig.receiverDelegate = self
        GCMService.sharedInstance().startWithConfig(gcmConfig)
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken
        deviceToken: NSData ) {
            // [END receive_apns_token]
            // [START get_gcm_reg_token]
            // Create a config and set a delegate that implements the GGLInstaceIDDelegate protocol.
            let instanceIDConfig = GGLInstanceIDConfig.defaultConfig()
            instanceIDConfig.delegate = self
            // Start the GGLInstanceID shared instance with that config and request a registration
            // token to enable reception of notifications
            GGLInstanceID.sharedInstance().startWithConfig(instanceIDConfig)
            registrationOptions = [kGGLInstanceIDRegisterAPNSOption:deviceToken,
                kGGLInstanceIDAPNSServerTypeSandboxOption:true]
            GGLInstanceID.sharedInstance().tokenWithAuthorizedEntity(gcmSenderID,
                scope: kGGLInstanceIDScopeGCM, options: registrationOptions, handler: registrationHandler)

            let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
            var tokenString = ""
            
            for i in 0..<deviceToken.length {
                tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
            }
            
            print("Device Token:", tokenString)
            Appconstant.gcmid = tokenString
            print(Appconstant.gcmid)
//            // [END get_gcm_reg_token]
    }
    func onTokenRefresh() {
        // A rotation of the registration tokens is happening, so the app needs to request a new token.
        print("The GCM registration token needs to be changed.")
        GGLInstanceID.sharedInstance().tokenWithAuthorizedEntity(gcmSenderID,
            scope: kGGLInstanceIDScopeGCM, options: registrationOptions, handler: registrationHandler)
    }
    
    func registrationHandler(registrationToken: String!, error: NSError!) {
        if (registrationToken != nil) {
            self.registrationToken = registrationToken
            print("Registration Token: \(registrationToken)")
            self.subscribeToTopic()
            let userInfo = ["registrationToken": registrationToken]
            NSNotificationCenter.defaultCenter().postNotificationName(
                self.registrationKey, object: nil, userInfo: userInfo)
        } else {
            print("Registration to GCM failed with error: \(error.localizedDescription)")
            let userInfo = ["error": error.localizedDescription]
            NSNotificationCenter.defaultCenter().postNotificationName(
                self.registrationKey, object: nil, userInfo: userInfo)
        }
    }
    
    func subscribeToTopic() {
        // If the app has a registration token and is connected to GCM, proceed to subscribe to the
        // topic
        if(registrationToken != nil && connectedToGCM) {
            GCMPubSub.sharedInstance().subscribeWithToken(self.registrationToken, topic: subscriptionTopic,
                options: nil, handler: {(error:NSError?) -> Void in
                    if let error = error {
                        // Treat the "already subscribed" error more gently
                        if error.code == 3001 {
                            print("Already subscribed to \(self.subscriptionTopic)")
                        } else {
                            print("Subscription failed: \(error.localizedDescription)");
                        }
                    } else {
                        self.subscribedToTopic = true;
                        NSLog("Subscribed to \(self.subscriptionTopic)");
                    }
            })
        }
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        application.applicationIconBadgeNumber = 0
    }
        
    func application( application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        if application.applicationState == UIApplicationState.Active {
            if let info = userInfo as? Dictionary<String,String> {
                let req_no = info["RequestNo"]!.dataUsingEncoding(NSUTF8StringEncoding)
                let reqno  = JSON(data: req_no!)
                let msg1 = info["BroadcastMsg"]!.dataUsingEncoding(NSUTF8StringEncoding)
                let msg  = JSON(data: msg1!)
                let amt1 = info["Amount"]!.dataUsingEncoding(NSUTF8StringEncoding)
                let amt  = JSON(data: amt1!)
                let phonenoarray = msg.stringValue.componentsSeparatedByString(" has")
                let phoneno = phonenoarray[0]
                
                var alertController:UIAlertController?
                alertController?.view.tintColor = UIColor.blackColor()
                alertController = UIAlertController(title: "Fund Request",
                    message: "\(msg)",
                    preferredStyle: .Alert)
                
                let action = UIAlertAction(title: "Approve", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
                  
                    let date = NSDate()
                    let formatter = NSDateFormatter()
                    
                    formatter.dateFormat = "d/MM/yyyy HH:mm"
                    
                    let result = formatter.stringFromDate(date)
//                    let dateFormatter = NSDateFormatter()
//                    dateFormatter.dateFormat = "d/MM/yyyy HH:mm"
//                    let dateString = dateFormatter.stringFromDate(date)
                    DBHelper().purzDB()
                    let databaseURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent("purz.db")
                    let databasePath = databaseURL.absoluteString
                    let purzDB = FMDatabase(path: databasePath as String)
                    if purzDB.open() {
                        let insertsql = "INSERT INTO NOTIFICATION (AMOUNT,DATE,FUND_REQ_NUMBER,STATUS,APPROVE_DECLINE,REQ_TO_US,ISREAD,PHONENUMBER) VALUES ('\(amt.stringValue)','\(result)','\(reqno.stringValue)','\("APPROVED")','\("true")','\("true")','\("false")','\(phoneno)')"
                        print(insertsql)
                        let result = purzDB.executeUpdate(insertsql,
                            withArgumentsInArray: nil)
                        
                        if !result {
                            //   status.text = "Failed to add contact"
                            print("Error: \(purzDB.lastErrorMessage())")
                        }
                    }

                
            })
                let action1 = UIAlertAction(title: "Decline", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
                    
                    let date = NSDate()
                    let formatter = NSDateFormatter()
                    
                    formatter.dateFormat = "d/MM/yyyy HH:mm"
                    
                    let result = formatter.stringFromDate(date)
                    //                    let dateFormatter = NSDateFormatter()
                    //                    dateFormatter.dateFormat = "d/MM/yyyy HH:mm"
                    //                    let dateString = dateFormatter.stringFromDate(date)
                    DBHelper().purzDB()
                    let databaseURL = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent("purz.db")
                    let databasePath = databaseURL.absoluteString
                    let purzDB = FMDatabase(path: databasePath as String)
                    if purzDB.open() {
                        let insertsql = "INSERT INTO NOTIFICATION (AMOUNT,DATE,FUND_REQ_NUMBER,STATUS,APPROVE_DECLINE,REQ_TO_US,ISREAD,PHONENUMBER) VALUES ('\(amt.stringValue)','\(result)','\(reqno.stringValue)','\("DECLINED")','\("true")','\("true")','\("false")','\(phoneno)')"
                        print(insertsql)
                        let result = purzDB.executeUpdate(insertsql,
                            withArgumentsInArray: nil)
                        
                        if !result {
                            //   status.text = "Failed to add contact"
                            print("Error: \(purzDB.lastErrorMessage())")
                        }
                    }
                    
                    
                    })
                
                alertController?.addAction(action)
                alertController?.addAction(action1)
                self.window?.rootViewController?.presentViewController(alertController!, animated: true, completion: nil)
            }

        }
            print("Notification received: \(userInfo)")
    
    }
    


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }


}

