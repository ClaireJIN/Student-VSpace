//
//  SignInViewController.swift
//  VSpace_iOS
//
//  Created by 李昂 on 15/8/17.
//  Copyright (c) 2015年 Obisoft Inc. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet var UserEmailTextField: UITextField!
    @IBOutlet var UserPasswordTextField: UITextField!
    @IBOutlet var SaveLabel: UILabel!
    
    var usr=ObiUser()
    
    var delegate:LoginProtocol?
    
    var SavedUserRes:String=NSBundle.mainBundle().pathForResource("ObiUser", ofType: "plist")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(SavedUserRes)
        var SavedUser:[String:String]=NSDictionary(contentsOfFile: SavedUserRes) as! [String:String]
        if SavedUser["Username"] != nil {
            UserEmailTextField.text=SavedUser["Username"]
            UserPasswordTextField.text=DESEncryptor.textFromBase64String(SavedUser["PasswordDES"])
            SaveLabel.text=InterStr("Save User E-mail and Password (Click to disable)")
            SaveLabel.textColor=UIColor.blueColor()
        }
        
        let SaveLabelTap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: "saveUser")
        SaveLabelTap.numberOfTapsRequired=1
        SaveLabelTap.numberOfTouchesRequired=1
        SaveLabel.addGestureRecognizer(SaveLabelTap)
    }
    
    func saveUser() {
        if SaveLabel.text == InterStr("Save User E-mail and Password (Click to enable)") {
            SaveLabel.text=InterStr("Save User E-mail and Password (Click to disable)")
            SaveLabel.textColor=UIColor.blueColor()
        }
        else {
            SaveLabel.text=InterStr("Save User E-mail and Password (Click to enable)")
            SaveLabel.textColor=UIColor.blackColor()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Nothing.
    }
    
    @IBAction func goBack() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 登录实现
    @IBAction func signInObisoftAccount() {
        // 检查用户邮箱及密码是否为空
        if (UserEmailTextField.text == "") {
            var alv_emailempty:UIAlertView=UIAlertView()
            alv_emailempty.title="Wrong"
            alv_emailempty.message="User e-mail shouldn't be empty!"
            alv_emailempty.addButtonWithTitle("OK")
            alv_emailempty.show()
            UserEmailTextField.becomeFirstResponder()
            return
        }
        if (UserPasswordTextField.text == "") {
            var alv_passwordempty:UIAlertView=UIAlertView()
            alv_passwordempty.title="Wrong"
            alv_passwordempty.message="User password shouldn't be empty!"
            alv_passwordempty.addButtonWithTitle("OK")
            alv_passwordempty.show()
            UserPasswordTextField.becomeFirstResponder()
            return
        }
        
        // 检查用户邮箱是否合法
        var emailtext=UserEmailTextField.text as NSString
        let emailregex:NSString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" as NSString
        var isEmailRight:NSPredicate=NSPredicate(format: "SELF MATCHES %@", emailregex)
        if (!isEmailRight.evaluateWithObject(UserEmailTextField.text)) {
            var alv_emailillegal:UIAlertView=UIAlertView()
            alv_emailillegal.title="Wrong"
            alv_emailillegal.message="User e-mail is in illegal format!"
            alv_emailillegal.addButtonWithTitle("OK")
            alv_emailillegal.show()
            UserEmailTextField.text = ""
            UserEmailTextField.becomeFirstResponder()
            return
        }
        
        // 登录
        // 导出加密后的密码
        var password=UserPasswordTextField.text
        var password_encrypted:String=DESEncryptor.base64StringFromText(password) as String
        var password_encoded=CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, password_encrypted, nil, "!*'();:@&=+$,/?%#[]", kCFStringEncodingASCII) as String
        var useremail_encoded=CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, UserEmailTextField.text, nil, "!*'();:@&=+$,/?%#[]", kCFStringEncodingASCII) as String
        
        // 登录请求
        var LoginURL:NSURL=NSURL(string: "http://101.200.182.196/Vspace/Login?Username=\(useremail_encoded)&PasswordDES=\(password_encoded)")!
        var LoginWebRequest:NSMutableURLRequest=NSMutableURLRequest(URL: LoginURL)
        LoginWebRequest.HTTPMethod="POST"
        print(LoginWebRequest)
        
        // 返回值 LoginResponse 为 JSON
        var LoginResponse:NSData=try! NSURLConnection.sendSynchronousRequest(LoginWebRequest, returningResponse: nil)
        var LoginResponseString:String=NSString(data: LoginResponse, encoding: NSUTF8StringEncoding) as! String

        // "" &quot;
        
        // 得到的 JSON 不能被识别。需要处理。
        LoginResponseString=(LoginResponseString as NSString).stringByReplacingOccurrencesOfString("&quot;", withString: "\"")
        LoginResponseString=(LoginResponseString as NSString).stringByReplacingOccurrencesOfString("\\", withString: "")
        LoginResponseString=LoginResponseString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        LoginResponseString=(LoginResponseString as NSString).stringByReplacingCharactersInRange(NSMakeRange(0, 1), withString: "")
        var lastchar:Int=(LoginResponseString as NSString).length-1
        LoginResponseString=(LoginResponseString as NSString).stringByReplacingCharactersInRange(NSMakeRange(lastchar, 1), withString: "")
        LoginResponseString=(LoginResponseString as NSString).stringByReplacingOccurrencesOfString("\\", withString: "")
        LoginResponseString = "{" + LoginResponseString + "}"
        
        
        // 序列化处理后的 JSON
        var LoginJSON:NSData=(LoginResponseString as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        var LoginInformation:Dictionary<String, String>? = (try? NSJSONSerialization.JSONObjectWithData(LoginJSON, options: NSJSONReadingOptions.MutableLeaves)) as? Dictionary<String, String>
        
        // 如果登录错误
        if (LoginInformation == nil) {
            var alv_loginerror:UIAlertView=UIAlertView()
            alv_loginerror.title="There is a mistake when signing in. Please try again."
            alv_loginerror.addButtonWithTitle("OK")
            alv_loginerror.show()
            //UserEmailTextField.text=""
            //UserPasswordTextField.text=""
            UserEmailTextField.becomeFirstResponder()
            return
        }
        
        usr.Username=UserEmailTextField.text
        usr.PasswordDES=password_encrypted
        
        // 处理登录数据
        switch (LoginInformation!["Status"]!) {
        case "Successfully":
            self.goBackAndPassValue(usr)
        case "Lockout":
            var alv_accountlockout:UIAlertView=UIAlertView()
            alv_accountlockout.title="This account is locked out."
            alv_accountlockout.addButtonWithTitle("OK")
            alv_accountlockout.show()
            UserEmailTextField.text=""
            UserPasswordTextField.text=""
            UserEmailTextField.becomeFirstResponder()
        case "RequestTwoFactor": // 未实现
            self.goBackAndPassValue(usr)
        case "WrongPassword":
            var alv_accountwrong:UIAlertView=UIAlertView()
            alv_accountwrong.title="User e-mail or password is wrong. Please check if they're right."
            alv_accountwrong.addButtonWithTitle("OK")
            alv_accountwrong.show()
            UserPasswordTextField.text=""
            UserPasswordTextField.becomeFirstResponder()
        default:
            var alv_unknown:UIAlertView=UIAlertView()
            alv_unknown.title="Unknown error. Please try again."
            alv_unknown.addButtonWithTitle("OK")
            alv_unknown.show()
        }
    }
    
    func goBackAndPassValue(_ouser:ObiUser) {
        if SaveLabel.text == InterStr("Save User E-mail and Password (Click to enable)") {
            var dic:[String:String]=NSDictionary(contentsOfFile: SavedUserRes) as! [String:String]
            dic["Username"]=UserEmailTextField.text
            dic["PasswordDES"]=DESEncryptor.base64StringFromText(UserPasswordTextField.text)
            var path=NSHomeDirectory() as NSString
            path=path.stringByAppendingPathComponent("Document")
            path=path.stringByAppendingPathComponent("ObiUser.plist")
            (dic as NSDictionary).writeToFile(path as String, atomically: true)
        }
        let dataDict=["username":_ouser]
        NSNotificationCenter.defaultCenter().postNotificationName("SignInCompletionNotification", object: nil, userInfo: dataDict)
        self.dismissViewControllerAnimated(true, completion: {
            self.delegate?.passValue(_ouser)
        })
    }
    
    
}

func getRightResponseJSONString(LoginResponseString:String) -> String {
    let _LoginResponseString=(LoginResponseString as NSString).stringByReplacingOccurrencesOfString("&quot;", withString: "\"")
    return _LoginResponseString
}
