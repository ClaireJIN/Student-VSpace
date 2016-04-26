//
//  AccountViewController.swift
//  VSpace
//
//  Created by 李昂 on 15/8/31.
//  Copyright (c) 2015年 Obisoft Inc. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet var AccountLab: UILabel!
    var usr=ObiUser()
    var delegate:LoginProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        AccountLab.text=usr.Username
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Logout() {
        let backdata=try! NSURLConnection.sendSynchronousRequest(NSURLRequest(URL: NSURL(string: "http://101.200.182.196/vspace/LoggingOut")!), returningResponse: nil)
        let backstring=NSString(data: backdata, encoding: NSUTF8StringEncoding)!
        if backstring == "Successfully Logged out." {
            let alv1=UIAlertView()
            alv1.title=InterStr("Successfully logged out.")
            alv1.addButtonWithTitle(InterStr("OK"))
            alv1.show()
            NSNotificationCenter.defaultCenter().postNotificationName("LogoutNotificationCompletion", object: nil)
            self.dismissViewControllerAnimated(true, completion: {
                self.delegate?.passValue(nil)
                print("dismiss complete")
            })
        }
        else {
            let alv2=UIAlertView()
            alv2.title=InterStr("Wrong")
            alv2.addButtonWithTitle(InterStr("OK"))
            alv2.show()
        }
    }
    
    @IBAction func manageacc() {
        let vc0=UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ManageAccountViewController") as! ManageAcccountViewController
        vc0.usr=self.usr
        self.presentViewController(vc0, animated: true, completion: nil)
    }
    
    @IBAction func gob() {
        self.dismissViewControllerAnimated(true, completion: nil)
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
