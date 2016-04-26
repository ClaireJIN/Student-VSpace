//
//  NEUIPGWViewController.swift
//  VSpace_iOS
//
//  Created by 李昂 on 15/8/10.
//  Copyright (c) 2015年 Obisoft Inc. All rights reserved.
//

import UIKit

class NEUIPGWViewController: VSpaceOutViewController, UITextFieldDelegate {
    @IBOutlet var UserAccountTextField: UITextField!
    @IBOutlet var UserPasswordTextField: UITextField!
    var pp:[String:String] = [:]
    var traffic:[String:String] = [:]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connect2SchoolNetwork() {
        // 检查用户名及密码是否为空
        if (UserAccountTextField.text == "") {
            let alv_accountempty:UIAlertView=UIAlertView();
            alv_accountempty.title="Wrong"
            alv_accountempty.message="User account shouldn't be empty!"
            alv_accountempty.addButtonWithTitle("OK")
            alv_accountempty.show()
            UserPasswordTextField.text=""
            UserAccountTextField.becomeFirstResponder()
            return
        }
        if (UserPasswordTextField.text == "") {
            let alv_passwordempty:UIAlertView=UIAlertView()
            alv_passwordempty.title="Wrong"
            alv_passwordempty.message="User password shouldn't be empty!"
            alv_passwordempty.addButtonWithTitle("OK")
            alv_passwordempty.show()
            UserPasswordTextField.becomeFirstResponder()
        }
        
        // 登录
        let SchoolNetworkURL:NSURL=NSURL(string: "https://ipgw.neu.edu.cn/ipgw/ipgw.ipgw?uid=\(UserAccountTextField.text)&password=\(UserPasswordTextField.text)&range=")!
        let SchoolNetworkRequest:NSURLRequest=NSURLRequest(URL: SchoolNetworkURL, cachePolicy: NSURLRequestCachePolicy(rawValue: 1)!, timeoutInterval: 100)
        let returnlogindata:NSData?=try? NSURLConnection.sendSynchronousRequest(SchoolNetworkRequest, returningResponse: nil)
        
        if (returnlogindata == nil) {
            let alv_schoolloginerror:UIAlertView=UIAlertView()
            alv_schoolloginerror.title=NSLocalizedString("Wrong", comment: "Wrong login action")
            alv_schoolloginerror.message=NSLocalizedString("Unknown error. Please check your network.", comment: "Unknown")
            alv_schoolloginerror.addButtonWithTitle(NSLocalizedString("OK", comment: "OK"))
            alv_schoolloginerror.show()
            return
        }
        
        // 截取第一份返回值
        let htmlStr:String=NSString(data: returnlogindata!, encoding: NSUTF8StringEncoding) as! String
        //htmlStr=getRightResponseJSONString(htmlStr)
        let LoginStatusPattern:String="<!--IPGWCLIENT_START([A-Za-z0-9\\s\\w]*)IPGWCLIENT_END-->"
        let regex1:NSRegularExpression=try! NSRegularExpression(pattern: LoginStatusPattern, options: NSRegularExpressionOptions.CaseInsensitive)
        var LoginStat:[String]=regex1.matchesInString(htmlStr, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, (htmlStr as NSString).length)) as! [String]
        
        // 处理第一份返回值
        let LoginStat1:[String]=LoginStat[0].componentsSeparatedByString(" ")
        for _str in LoginStat1 {
            var ppp:[String]=_str.componentsSeparatedByString("=")
            if ppp.count != 2 {
                continue
            }
            pp[ppp[0]]=ppp[1]
        }
        
        if pp["SUCCESS"] == "yes" {
            let TKey:[String]=[
                "username", //账户名
                "ip", //IP
                "fixrate", //包月状态
                "scope", //访问范围
                "deficit", //欠费状态
                "linknum", //当前连接
                "time", //时间
                "balance" //余额
            ]
            (htmlStr as NSString).stringByReplacingOccurrencesOfString("\n", withString: "")
            let patt2="(?s)<\\/td><td>([\\s]*)<\\/td>"
            let regex2:NSRegularExpression=try! NSRegularExpression(pattern: patt2, options: NSRegularExpressionOptions.CaseInsensitive)
            var TrafficStat:[String]=regex2.matchesInString(htmlStr, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, (htmlStr as NSString).length)) as! [String]
            let i:Int=0 // 循环计数器
            while i <= TKey.count {
                traffic[TKey[i]]=TrafficStat[i]
            }
            
            
            // 提示用户
            let alv_succ=UIAlertView()
            alv_succ.title=NSLocalizedString("Succeeded", comment: "success")
            alv_succ.message=NSLocalizedString("Now you can get your traffic query.", comment: "gettr")
            alv_succ.addButtonWithTitle(NSLocalizedString("OK", comment: "OK"))
            alv_succ.show()
        }
        
        
    }
    
    @IBAction func disConnectSchoolNetwork() {
        
    }
    
    @IBAction func disConnectAll() {
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        var originFrame:CGRect=self.view.frame
    }
}
