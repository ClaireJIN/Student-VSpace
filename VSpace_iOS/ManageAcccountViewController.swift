//
//  ManageAcccountViewController.swift
//  VSpace
//
//  Created by 李昂 on 15/8/31.
//  Copyright (c) 2015年 Obisoft Inc. All rights reserved.
//

import UIKit

class ManageAcccountViewController: UIViewController {
    @IBOutlet var webView: UIWebView!
    var usr=ObiUser()
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://101.200.182.196/vspace/manage?Username=\(usr.Username)&PasswordDes=\(usr.PasswordDES)")!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
