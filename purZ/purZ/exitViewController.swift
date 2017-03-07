//
//  exitViewController.swift
//  purZ
//
//  Created by Vertace on 21/02/17.
//  Copyright © 2017 Vertace. All rights reserved.
//

import UIKit

class exitViewController: UIViewController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//     tabBarController?.selectedIndex = 0
        
        //        let alert = UIAlertController(title: "Are you sure want to logout?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
////             alert.setValue(attributedString, forKey: "attributedTitle")
//        alert.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.Default, handler: { alertAction in
//            exit (0)
//        }))
//        
//                          alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.Default, handler: { alertAction in
//                }))
//        self.presentViewController(alert, animated: true, completion: nil)
          // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        
        Appconstant.fromlogout = true
        guard let tabBarController = tabBarController else { return }
        tabBarController.selectedIndex = 0
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
