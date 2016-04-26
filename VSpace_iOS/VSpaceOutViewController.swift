//
//  VSpaceOutViewController.swift
//  VSpace
//
//  Created by 李昂 on 15/8/29.
//  Copyright (c) 2015年 Obisoft Inc. All rights reserved.
//

import UIKit

class VSpaceOutViewController: UIViewController, LeftMenuProtocol, UIGestureRecognizerDelegate, LoginProtocol {
    
    var IsSchoolNetwork:Double = -1
    
    // Navigation Bar
    var NavigationView:UIView=UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 64))
    var NavigationLeftButton:UIButton=UIButton(type: UIButtonType.System)
    var NavigationLabel:UILabel=UILabel(frame: CGRectMake(40, 33, 109, 21))
    var SignInButton:UIButton=UIButton(type: UIButtonType.System)
    var AccountLabel:UILabel=UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.width-124, 33, 116, 21))
    let NavigationColor=UIColor(red: 117/255, green: 130/255, blue: 145/255, alpha: 1)
    let SignInButtonColor=UIColor(red: 99/255, green: 174/255, blue: 66/255, alpha: 1)
    let LeftMenu_RightVColor=UIColor(red: 203/255, green: 203/255, blue: 203/255, alpha: 1)
    
    
    // Left Menu
    var LeftMenu:UIView=UIView(frame: CGRectMake(-230, 64, 230, UIScreen.mainScreen().bounds.height-64))
    var LeftMenu_RightV:UIView=UIView(frame: CGRectMake(227, 0, 3, UIScreen.mainScreen().bounds.height-64))
    var HomeLabel:UILabel=UILabel(frame: CGRectMake(0, 38, 227, 30))
    var NEUIPGWLabel:UILabel=UILabel(frame: CGRectMake(0, 78, 227, 30))
    var TrafficQueryLabel:UILabel=UILabel(frame: CGRectMake(0, 118, 227, 30))
    var LostAndFoundLabel:UILabel=UILabel(frame: CGRectMake(0, 158, 227, 30))
    var QueryScoresLabel:UILabel=UILabel(frame: CGRectMake(0, 198, 227, 30))
    var VPNLabel:UILabel=UILabel(frame: CGRectMake(0, 238, 227, 30))
    var SchoolCommunityLabel:UILabel=UILabel(frame: CGRectMake(0, 278, 227, 30))
    var SettingsLabel:UILabel=UILabel(frame: CGRectMake(0, 318, 227, 30))
    var AboutLabel:UILabel=UILabel(frame: CGRectMake(0, 358, 227, 30))
    
    // Pass Value
    var ousr=ObiUser()
    
    let LeftMenuLabelBackgroundColor=UIColor(red: 237/255, green: 240/255, blue: 244/255, alpha: 1)
    let LeftMenuLabelBorderColor=UIColor(red: 221/255, green: 225/255, blue: 232/255, alpha: 1)
    
    // 左侧菜单弹出时加遮罩
    var halfb:UIView=UIView(frame: CGRectMake(0, 64, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-64))
    let halfbc=UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    let halfbc_no=UIColor(red: 1, green: 1, blue: 1, alpha: 0)
    
    func signinCompletion(notification:NSNotification) {
        let theData:NSDictionary=notification.userInfo!
        let username:NSString=theData.objectForKey("username") as! NSString
        self.ousr.Username=username as String
    }
    
    func logoutCompletion() {
        self.ousr.Username=""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let thread:NSThread=NSThread(target: self, selector: "CheckIfSchoolNetwork", object: nil)
        thread.start()
        
        print("viewdidload")
        
        
        let halfbt:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: "didTouchBack")
        halfbt.numberOfTapsRequired=1
        halfbt.numberOfTouchesRequired=1
        halfb.addGestureRecognizer(halfbt)
        
        halfb.userInteractionEnabled=true
        halfb.multipleTouchEnabled=true
        
        // Left Menu
        LeftMenu_RightV.backgroundColor=LeftMenu_RightVColor
        LeftMenu.backgroundColor=UIColor.whiteColor()
        
        HomeLabel.userInteractionEnabled=true
        HomeLabel.multipleTouchEnabled=true
        NEUIPGWLabel.userInteractionEnabled=true
        NEUIPGWLabel.multipleTouchEnabled=true
        TrafficQueryLabel.userInteractionEnabled=true
        TrafficQueryLabel.multipleTouchEnabled=true
        LostAndFoundLabel.userInteractionEnabled=true
        LostAndFoundLabel.multipleTouchEnabled=true
        QueryScoresLabel.userInteractionEnabled=true
        QueryScoresLabel.multipleTouchEnabled=true
        VPNLabel.userInteractionEnabled=true
        VPNLabel.multipleTouchEnabled=true
        SchoolCommunityLabel.userInteractionEnabled=true
        SchoolCommunityLabel.multipleTouchEnabled=true
        SettingsLabel.userInteractionEnabled=true
        SettingsLabel.multipleTouchEnabled=true
        AccountLabel.userInteractionEnabled=true
        AccountLabel.multipleTouchEnabled=true
        AboutLabel.userInteractionEnabled=true
        AboutLabel.multipleTouchEnabled=true
        
        HomeLabel.text=NSLocalizedString("   Home", comment: "1")
        NEUIPGWLabel.text=NSLocalizedString("   NEU IPGW", comment: "2")
        TrafficQueryLabel.text=NSLocalizedString("   Traffic Query", comment: "3")
        LostAndFoundLabel.text=NSLocalizedString("   Lost And Found", comment: "4")
        QueryScoresLabel.text=NSLocalizedString("   Query Scores", comment: "5")
        VPNLabel.text=NSLocalizedString("   VPN", comment: "6")
        SchoolCommunityLabel.text=InterStr("   School Community")
        SettingsLabel.text=InterStr("   Settings")
        AboutLabel.text=InterStr("   About")
        
        HomeLabel.textColor=UIColor.blackColor()
        NEUIPGWLabel.textColor=UIColor.blackColor()
        TrafficQueryLabel.textColor=UIColor.blackColor()
        LostAndFoundLabel.textColor=UIColor.blackColor()
        
        let HomeLabelTap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: "gotoMainViewController:")
        HomeLabelTap.numberOfTapsRequired=1
        HomeLabelTap.numberOfTouchesRequired=1
        HomeLabel.addGestureRecognizer(HomeLabelTap)
        self.LeftMenu.addSubview(HomeLabel)
        
        let NEUIPGWLabelTap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: "gotoNEUIPGWViewController:")
        NEUIPGWLabelTap.numberOfTouchesRequired=1
        NEUIPGWLabelTap.numberOfTapsRequired=1
        NEUIPGWLabel.addGestureRecognizer(NEUIPGWLabelTap)
        self.LeftMenu.addSubview(NEUIPGWLabel)
        
        let TrafficQueryLabelTap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: "gotoTrafficQueryViewController:")
        TrafficQueryLabelTap.numberOfTapsRequired=1
        TrafficQueryLabelTap.numberOfTouchesRequired=1
        TrafficQueryLabel.addGestureRecognizer(TrafficQueryLabelTap)
        self.LeftMenu.addSubview(TrafficQueryLabel)
        
        let LostAndFoundLabelTap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: "gotoLostAndFoundViewController:")
        LostAndFoundLabelTap.numberOfTouchesRequired=1
        LostAndFoundLabelTap.numberOfTapsRequired=1
        LostAndFoundLabel.addGestureRecognizer(LostAndFoundLabelTap)
        self.LeftMenu.addSubview(LostAndFoundLabel)
        
        let QueryScoresLabelTap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: "gotoQueryScoresViewController:")
        QueryScoresLabelTap.numberOfTapsRequired=1
        QueryScoresLabelTap.numberOfTouchesRequired=1
        QueryScoresLabel.addGestureRecognizer(QueryScoresLabelTap)
        self.LeftMenu.addSubview(QueryScoresLabel)
        
        let VPNLabelTap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: "gotoVPNViewController:")
        VPNLabelTap.numberOfTapsRequired=1
        VPNLabelTap.numberOfTouchesRequired=1
        VPNLabel.addGestureRecognizer(VPNLabelTap)
        self.LeftMenu.addSubview(VPNLabel)
        
        let SchoolCommunityLabelTap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: "gotoSchoolCommunityViewController:")
        SchoolCommunityLabelTap.numberOfTapsRequired=1
        SchoolCommunityLabelTap.numberOfTouchesRequired=1
        SchoolCommunityLabel.addGestureRecognizer(SchoolCommunityLabelTap)
        self.LeftMenu.addSubview(SchoolCommunityLabel)
        
        let SettingsLabelTap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: "gotoSettingsViewController:")
        SettingsLabelTap.numberOfTapsRequired=1
        SettingsLabelTap.numberOfTouchesRequired=1
        SettingsLabel.addGestureRecognizer(SettingsLabelTap)
        //self.LeftMenu.addSubview(SettingsLabel)
        
        let AboutLabelTap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: "gotoAboutViewController:")
        AboutLabelTap.numberOfTouchesRequired=1
        AboutLabelTap.numberOfTapsRequired=1
        AboutLabel.addGestureRecognizer(AboutLabelTap)
        self.LeftMenu.addSubview(AboutLabel)
        
        self.LeftMenu.addSubview(LeftMenu_RightV)
        
        // Navigation Bar
        NavigationView.backgroundColor=NavigationColor
        
        NavigationLeftButton.frame=CGRectMake(8, 32, 24, 24)
        NavigationLeftButton.setImage(UIImage(named: "ic_menu_black_24dp"), forState: UIControlState.Normal)
        NavigationLeftButton.tintColor=UIColor.whiteColor()
        NavigationLeftButton.addTarget(self, action: "didTouchLeftItem", forControlEvents: UIControlEvents.TouchUpInside)
        
        SignInButton.frame=CGRectMake(UIScreen.mainScreen().bounds.width-44, 20, 44, 44)
        SignInButton.backgroundColor=SignInButtonColor
        SignInButton.setTitle(NSLocalizedString("Sign In", comment: "Sign in"), forState: .Normal)
        SignInButton.titleLabel?.font=UIFont.systemFontOfSize(13.0)
        //SignInButton.titleLabel?.textColor=UIColor.whiteColor()
        SignInButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        SignInButton.addTarget(self, action: "signin", forControlEvents: UIControlEvents.TouchUpInside)
        
        NavigationLabel.text="VSpace"
        NavigationLabel.font=UIFont.systemFontOfSize(17.0)
        NavigationLabel.textColor=UIColor.whiteColor()
        self.NavigationView.addSubview(NavigationLeftButton)
        self.NavigationView.addSubview(NavigationLabel)
        
        AccountLabel.textColor=UIColor.whiteColor()
        AccountLabel.textAlignment=NSTextAlignment.Right
        AccountLabel.font=UIFont.systemFontOfSize(15.0)
        let AccountLabelTap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: "gotoManageViewController")
        AccountLabelTap.numberOfTapsRequired=1
        AccountLabelTap.numberOfTouchesRequired=1
        AccountLabel.addGestureRecognizer(AccountLabelTap)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "signinCompletion:", name: "SignInNotificationCompletion", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "logoutCompletion", name: "LogoutNotificationCompletion", object: nil)
        if (ousr.Username != "") {
            AccountLabel.text=ousr.Username
            self.NavigationView.addSubview(AccountLabel)
        }
        else {
            self.NavigationView.addSubview(SignInButton)
        }
        self.view.addSubview(NavigationView)
        //self.view.addSubview(LeftMenu)
        print("viewwillappear")
    }
    
    func passValue(value: ObiUser?) {
        AccountLabel.removeFromSuperview()
        SignInButton.removeFromSuperview()
        if (value != nil) {
            AccountLabel.text=value!.Username
            self.NavigationView.addSubview(AccountLabel)
            ousr=value!
        }
        else {
            AccountLabel.removeFromSuperview()
            AccountLabel.text=nil
            self.NavigationView.addSubview(SignInButton)
            ousr=ObiUser()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func didTouchLeftItem() {
        let HiddenFrame:CGRect=CGRectMake(-230, 64, 230, UIScreen.mainScreen().bounds.height-64)
        let AppearFrame:CGRect=CGRectMake(0, 64, 230, UIScreen.mainScreen().bounds.height-64)
        
        if (self.LeftMenu.frame.origin.x == -230) {
            halfb.backgroundColor=halfbc_no
            self.view.addSubview(halfb)
            self.view.addSubview(LeftMenu)
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.5)
            UIView.setAnimationDelegate(self)
            halfb.backgroundColor=halfbc
            self.LeftMenu.frame=AppearFrame
            UIView.commitAnimations()
        }
            
        else if (self.LeftMenu.frame.origin.x == 0.0) {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.5)
            UIView.setAnimationDelegate(self)
            halfb.backgroundColor=halfbc_no
            self.LeftMenu.frame=HiddenFrame
            halfb.removeFromSuperview()
            UIView.commitAnimations()
        }
    }

    func gotoMainViewController(sender: UIGestureRecognizer) {
        let HiddenFrame:CGRect=CGRectMake(-230, 64, 230, UIScreen.mainScreen().bounds.height-64)
        HomeLabel.backgroundColor=LeftMenuLabelBackgroundColor
        HomeLabel.layer.borderWidth=1
        HomeLabel.layer.borderColor=LeftMenuLabelBorderColor.CGColor
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStopSelector("Main2")
        self.LeftMenu.frame=HiddenFrame
        UIView.commitAnimations()
    }
    
    func gotoNEUIPGWViewController(sender: UIGestureRecognizer) {
        if IsSchoolNetwork == -1.0 {
            let alv_notschoolnet=UIAlertView()
            alv_notschoolnet.title=InterStr("Not In School Network")
            alv_notschoolnet.message=InterStr("Must be in School Network if use IPGW.")
            alv_notschoolnet.addButtonWithTitle(InterStr("OK"))
            alv_notschoolnet.show()
            return
        }
        let HiddenFrame:CGRect=CGRectMake(-230, 64, 230, UIScreen.mainScreen().bounds.height-64)
        var AppearFrame:CGRect=CGRectMake(0, 64, 230, UIScreen.mainScreen().bounds.height-64)
        NEUIPGWLabel.backgroundColor=LeftMenuLabelBackgroundColor
        NEUIPGWLabel.layer.borderWidth=1
        NEUIPGWLabel.layer.borderColor=LeftMenuLabelBorderColor.CGColor
        // 1、收回菜单
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStopSelector("NEUIPGW2")
        self.LeftMenu.frame=HiddenFrame
        UIView.commitAnimations()
    }
    
    func gotoTrafficQueryViewController(sender: UIGestureRecognizer) {
        if IsSchoolNetwork == -1.0 {
            let alv_notschoolnet=UIAlertView()
            alv_notschoolnet.title=InterStr("Not In School Network")
            alv_notschoolnet.message=InterStr("Must be in School Network if use IPGW.")
            alv_notschoolnet.addButtonWithTitle(InterStr("OK"))
            alv_notschoolnet.show()
            return
        }
        let HiddenFrame:CGRect=CGRectMake(-230, 64, 230, UIScreen.mainScreen().bounds.height-64)
        var AppearFrame:CGRect=CGRectMake(0, 64, 230, UIScreen.mainScreen().bounds.height-64)
        TrafficQueryLabel.backgroundColor=LeftMenuLabelBackgroundColor
        TrafficQueryLabel.layer.borderWidth=1
        TrafficQueryLabel.layer.borderColor=LeftMenuLabelBorderColor.CGColor
        // 1、收回菜单
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStopSelector("TrafficQuery2")
        self.LeftMenu.frame=HiddenFrame
        UIView.commitAnimations()
    }
    
    func gotoLostAndFoundViewController(sender: UIGestureRecognizer) {
        let HiddenFrame:CGRect=CGRectMake(-230, 64, 230, UIScreen.mainScreen().bounds.height-64)
        var AppearFrame:CGRect=CGRectMake(0, 64, 230, UIScreen.mainScreen().bounds.height-64)
        LostAndFoundLabel.backgroundColor=LeftMenuLabelBackgroundColor
        LostAndFoundLabel.layer.borderWidth=1
        LostAndFoundLabel.layer.borderColor=LeftMenuLabelBorderColor.CGColor
        // 1、收回菜单
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStopSelector("LostAndFound2")
        self.LeftMenu.frame=HiddenFrame
        UIView.commitAnimations()
    }
    
    func gotoQueryScoresViewController(sender: UIGestureRecognizer) {
        let HiddenFrame:CGRect=CGRectMake(-230, 64, 230, UIScreen.mainScreen().bounds.height-64)
        var AppearFrame:CGRect=CGRectMake(0, 64, 230, UIScreen.mainScreen().bounds.height-64)
        QueryScoresLabel.backgroundColor=LeftMenuLabelBackgroundColor
        QueryScoresLabel.layer.borderWidth=1
        QueryScoresLabel.layer.borderColor=LeftMenuLabelBorderColor.CGColor
        // 1、收回菜单
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStopSelector("QueryScores2")
        self.LeftMenu.frame=HiddenFrame
        UIView.commitAnimations()
    }
    
    func gotoVPNViewController(sender: UIGestureRecognizer) {
        let HiddenFrame:CGRect=CGRectMake(-230, 64, 230, UIScreen.mainScreen().bounds.height-64)
        var AppearFrame:CGRect=CGRectMake(0, 64, 230, UIScreen.mainScreen().bounds.height-64)
        VPNLabel.backgroundColor=LeftMenuLabelBackgroundColor
        VPNLabel.layer.borderWidth=1
        VPNLabel.layer.borderColor=LeftMenuLabelBorderColor.CGColor
        // 1、收回菜单
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStopSelector("VPN2")
        self.LeftMenu.frame=HiddenFrame
        UIView.commitAnimations()
    }
    
    func gotoSchoolCommunityViewController(sender: UIGestureRecognizer) {
        let alv_undefined=UIAlertView()
        alv_undefined.title=InterStr("Unknown Server Error")
        alv_undefined.addButtonWithTitle(InterStr("OK"))
        alv_undefined.show()
        /*
        var HiddenFrame:CGRect=CGRectMake(-230, 64, 230, UIScreen.mainScreen().bounds.height-64)
        var AppearFrame:CGRect=CGRectMake(0, 64, 230, UIScreen.mainScreen().bounds.height-64)
        SchoolCommunityLabel.backgroundColor=LeftMenuLabelBackgroundColor
        SchoolCommunityLabel.layer.borderWidth=1
        SchoolCommunityLabel.layer.borderColor=LeftMenuLabelBorderColor.CGColor
        // 1、收回菜单
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStopSelector("SchoolCommunity2")
        self.LeftMenu.frame=HiddenFrame
        UIView.commitAnimations()
        */
    }
    
    func gotoSettingsViewController(sender: UIGestureRecognizer) {
        let HiddenFrame:CGRect=CGRectMake(-230, 64, 230, UIScreen.mainScreen().bounds.height-64)
        var AppearFrame:CGRect=CGRectMake(0, 64, 230, UIScreen.mainScreen().bounds.height-64)
        SettingsLabel.backgroundColor=LeftMenuLabelBackgroundColor
        SettingsLabel.layer.borderWidth=1
        SettingsLabel.layer.borderColor=LeftMenuLabelBorderColor.CGColor
        // 1、收回菜单
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStopSelector("Settings2")
        self.LeftMenu.frame=HiddenFrame
        UIView.commitAnimations()
    }
    
    func gotoAboutViewController(sender:UIGestureRecognizer) {
        let HiddenFrame:CGRect=CGRectMake(-230, 64, 230, UIScreen.mainScreen().bounds.height-64)
        var AppearFrame:CGRect=CGRectMake(0, 64, 230, UIScreen.mainScreen().bounds.height-64)
        AboutLabel.backgroundColor=LeftMenuLabelBackgroundColor
        AboutLabel.layer.borderWidth=1
        AboutLabel.layer.borderColor=LeftMenuLabelBorderColor.CGColor
        // 1、收回菜单
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStopSelector("About2")
        self.LeftMenu.frame=HiddenFrame
        UIView.commitAnimations()
    }
    
    // ViewController 跳转
    func NEUIPGW2() {
        let mainsb:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let neuipgw=mainsb.instantiateViewControllerWithIdentifier("NEUIPGWViewController") as! NEUIPGWViewController
        if self.ousr.Username != "" {
            neuipgw.ousr=self.ousr
        }
        // 2、打开 ViewController
        //sleep(1)
        self.presentViewController(neuipgw, animated: false, completion: nil)
    }
    
    func TrafficQuery2() {
        let mainsb:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let trafficquery=mainsb.instantiateViewControllerWithIdentifier("CheckQViewController") as! CheckQViewController
        if self.ousr.Username != "" {
            trafficquery.ousr=self.ousr
        }
        // 2、打开 ViewController
        self.presentViewController(trafficquery, animated: false, completion: nil)
    }
    
    func LostAndFound2() {
        let mainsb:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let missing=mainsb.instantiateViewControllerWithIdentifier("MissingViewController") as! MissingViewController
        if self.ousr.Username != "" {
            missing.ousr=self.ousr
        }
        self.presentViewController(missing, animated: false, completion: nil)
    }
    
    func QueryScores2() {
        let mainsb:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let checkgrade=mainsb.instantiateViewControllerWithIdentifier("CheckGradeViewController") as! CheckGradeViewController
        if self.ousr.Username != "" {
            checkgrade.ousr=self.ousr
        }
        // 2、打开 ViewController
        self.presentViewController(checkgrade, animated: false, completion: nil)
    }
    
    func VPN2() {
        let mainsb:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vpn=mainsb.instantiateViewControllerWithIdentifier("VPNViewController") as! VPNViewController
        if self.ousr.Username != "" {
            vpn.ousr=self.ousr
        }
        // 2、打开 ViewController
        self.presentViewController(vpn, animated: false, completion: nil)
    }
    
    func SchoolCommunity2() {
        let mainsb:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let sc=mainsb.instantiateViewControllerWithIdentifier("SheTuanViewController") as! SheTuanViewController
        if self.ousr.Username != "" {
            sc.ousr=self.ousr
        }
        // 2、打开 ViewController
        self.presentViewController(sc, animated: false, completion: nil)
    }
    
    func Settings2() {
        let mainsb:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let settings=mainsb.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
        /*
        if let usr = self.ousr?.Username {
            settings.ousr=self.ousr
        }
        */
        // 2、打开 ViewController
        self.presentViewController(settings, animated: false, completion: nil)
    }
    
    func Main2() {
        let mainsb:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let main=mainsb.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
        if self.ousr.Username != "" {
            main.ousr=self.ousr
        }
        // 2、打开 ViewController
        self.presentViewController(main, animated: false, completion: nil)
    }
    
    func signin() {
        let mainsb:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let signin=mainsb.instantiateViewControllerWithIdentifier("SignInViewController") as! SignInViewController
        signin.delegate=self
        self.presentViewController(signin, animated: true, completion: nil)
    }
    
    func AccountManage() {
        
    }
    
    func didTouchBack() {
        let HiddenFrame:CGRect=CGRectMake(-230, 64, 230, UIScreen.mainScreen().bounds.height-64)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationDelegate(self)
        halfb.backgroundColor=halfbc_no
        self.LeftMenu.frame=HiddenFrame
        halfb.removeFromSuperview()
        UIView.commitAnimations()
    }
    
    func CheckIfSchoolNetwork() {
        self.IsSchoolNetwork=checkConnection(checkURL: NSURL(string: "http://ipgw.neu.edu.cn")!, allowInterval: 1)
    }
    
    func About2() {
        let mainsb:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let sc=mainsb.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
        if self.ousr.Username != "" {
            sc.ousr=self.ousr
        }
        // 2、打开 ViewController
        self.presentViewController(sc, animated: false, completion: nil)
    }
    
    func gotoManageViewController() {
        let vc0=UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AccountViewController") as! AccountViewController
        vc0.usr=self.ousr
        self.presentViewController(vc0, animated: true, completion: nil)
    }
}

func InterStr(_str:String) -> String {
    return NSLocalizedString(_str, comment: "Un")
}
