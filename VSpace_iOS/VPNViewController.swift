//
//  LoveWallViewController.swift
//  VSpace_iOS
//
//  Created by 李昂 on 15/8/10.
//  Copyright (c) 2015年 Obisoft Inc. All rights reserved.
//

import UIKit

class VPNViewController: VSpaceOutViewController {
    @IBOutlet var ServerNameLabel: UILabel!
    @IBOutlet var UserNameLabel: UILabel!
    @IBOutlet var PasswordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVPN() {
        var VPN:[String:String]?
        while (true) {
            let GetVPNRes:NSURL=NSURL(string: "http://101.200.182.196/VSpace/GetVPN")!
            let GetVPNResRequest:NSURLRequest=NSURLRequest(URL: GetVPNRes)
            var GetVPNDt:NSData=try! NSURLConnection.sendSynchronousRequest(GetVPNResRequest, returningResponse: nil)
            var GetVPNString=NSString(data: GetVPNDt, encoding: NSUTF8StringEncoding) as! String
            GetVPNString=getRightResponseJSONString(GetVPNString)
            GetVPNDt=(GetVPNString as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
            VPN=(try? NSJSONSerialization.JSONObjectWithData(GetVPNDt, options: NSJSONReadingOptions.MutableLeaves)) as? [String:String]
            if VPN != nil {
                break
            }
        }
        
        ServerNameLabel.text=VPN!["ServerAddress"]!
        UserNameLabel.text=DESEncryptor.textFromBase64String(VPN!["Username"]!)
        PasswordLabel.text=DESEncryptor.textFromBase64String(VPN!["PasswordDES"]!)
        
    }
    
    @IBAction func getDetail() {
        self.presentViewController((UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("VPNDetailViewController") as! VPNDetailViewController), animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if ousr.Username == "" {
            let alv_notLogged=UIAlertView()
            alv_notLogged.title=InterStr("Not Logged In")
            alv_notLogged.message=InterStr("Please log in obisoft account to get available VPN.")
            alv_notLogged.addButtonWithTitle("OK")
            alv_notLogged.show()
        }
        else {
            let thrd:NSThread=NSThread(target: self, selector: "getVPN", object: nil)
            thrd.start()
        }
    }
}
