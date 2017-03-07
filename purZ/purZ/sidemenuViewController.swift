//
//  SideMenuViewController.swift
//  purZ
//
//  Created by Vertace on 14/02/17.
//  Copyright © 2017 Vertace. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    var items = [String]()
    var id: Int32 = 1

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = true

        items = ["Dashboard","PayatShop","RechargePay","SendAsk Money","Transactions","Offers","ContactUs"]
        
        //self.navigationController?.navigationBarHidden = false
//        let backgroundImage = UIImageView(frame: CGRectMake(0, 0, 320, 800))
        
        //        backgroundImage.image = UIImage(named: "greenbackground.jpeg")
//        
//        self.tableView.insertSubview(backgroundImage, atIndex: 0)
//
//
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(items[indexPath.row], forIndexPath: indexPath) as UITableViewCell!

        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
//        self.tableView.rowHeight = 50.0
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
   func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    cell.backgroundColor = UIColor.clearColor()
    
    let selectionColor = UIView() as UIView
    selectionColor.layer.borderWidth = 1
    selectionColor.layer.borderColor = UIColor.clearColor().CGColor
    selectionColor.backgroundColor = UIColor.clearColor()
    cell.selectedBackgroundView = selectionColor
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 6)
            {
                Appconstant.SideMenu = 6;

                }
        if(indexPath.row == 5)
        {
            UIApplication.sharedApplication().openURL(NSURL(string: "https://www.equitasbank.com/business-cards-offers.php")!)
           
        }
        if(indexPath.row == 3)
        {
            Appconstant.SideMenu = 3;
        }

        if(indexPath.row == 1)
        {
            Appconstant.SideMenu = 1;
        }
        if(indexPath.row == 2)
        {
            Appconstant.SideMenu = 2;
        }
        if(indexPath.row == 4)
        {
            Appconstant.SideMenu = 4;
        }

}

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

