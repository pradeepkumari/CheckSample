//
//  contactViewController.swift
//  purZ
//
//  Created by Vertace on 21/02/17.
//  Copyright © 2017 Vertace. All rights reserved.
//

import UIKit
import MessageUI

class contactViewController: UIViewController, MFMailComposeViewControllerDelegate, UITabBarControllerDelegate {

    @IBOutlet weak var logoimg: UIImageView!
    @IBOutlet weak var linelbl: UILabel!
    @IBOutlet weak var callbtn: UIButton!
    @IBOutlet weak var emailbtn: UIButton!
  
    @IBOutlet weak var badgebtn: UIButton!
    
    @IBOutlet weak var addresslbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = true
            Appconstant.SideMenu = 0;
        tabBarController?.delegate = self

        // Do any additional setup after loading the view.
        design()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func callBtn(sender: AnyObject) {
        let alert = UIAlertController(title: "Purz", message: "Are you sure want to call our support?", preferredStyle: UIAlertControllerStyle.Alert)
        //             alert.setValue(attributedString, forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { alertAction in
            let url:NSURL = NSURL(string: "tel://180030001222")!
            UIApplication.sharedApplication().openURL(url)

           
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: { alertAction in
        }))
        self.presentViewController(alert, animated: true, completion: nil)

//        var alertController:UIAlertController?
//        alertController?.view.tintColor = UIColor.blackColor()
//        alertController = UIAlertController(title: "Purz",
//               message: "Are you sure want to call our support?",
//    preferredStyle: .Alert)
//  let action1 = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
//            let url:NSURL = NSURL(string: "tel://180030001222")!
//            UIApplication.sharedApplication().openURL(url)
//            
//            })
//        let action = UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
//            
//            })
//
//        alertController?.addAction(action1)
//        alertController?.addAction(action)
//        self.presentViewController(alertController!, animated: true, completion: nil)

    }
    
    @IBAction func emailBtn(sender: AnyObject) {
        var alertController:UIAlertController?
        alertController?.view.tintColor = UIColor.blackColor()
        alertController = UIAlertController(title: "Purz",
                                            message: "Are you sure want to mail our support?",
                                            preferredStyle: .Alert)
        
               let action1 = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
                let mailVC = MFMailComposeViewController()
                mailVC.mailComposeDelegate = self
                mailVC.setToRecipients(["info@equitasbank.com"])
//            self!.presentViewController(mailVC, animated: true, completion: nil)
            })
        let action = UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: {[weak self](paramAction:UIAlertAction!) in
            
            })

        
        alertController?.addAction(action1)
        alertController?.addAction(action)
        self.presentViewController(alertController!, animated: true, completion: nil)

    }
    
 func design()
{
    if(Appconstant.notificationcount > 0){
        badgebtn.hidden = false
        badgebtn.setTitle("\(Appconstant.notificationcount)", forState: .Normal)
        badgebtn.userInteractionEnabled = false
    }
    else{
        badgebtn.hidden = true
    }
    badgebtn.layer.cornerRadius  = self.badgebtn.frame.height/2

   logoimg.layer.cornerRadius = self.logoimg.frame.height/2
    logoimg.layer.borderColor = UIColor(red:250/255.0, green:194/255.0, blue:35/255.0, alpha:1.0).CGColor
    logoimg.layer.borderWidth = 5
    callbtn.layer.cornerRadius = self.callbtn.frame.height/2
    emailbtn.layer.cornerRadius = self.emailbtn.frame.height/2
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
    }


}
