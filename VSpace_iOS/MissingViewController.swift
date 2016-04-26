//
//  MissingViewController.swift
//  VSpace_iOS
//
//  Created by 李昂 on 15/8/10.
//  Copyright (c) 2015年 Obisoft Inc. All rights reserved.
//

import UIKit

class MissingViewController: VSpaceOutViewController, UIWebViewDelegate {
    @IBOutlet var webView: UIWebView!
    //var missingStr:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //webView.loadRequest(MissingRequest)
        // Do any additional setup after loading the view.
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //self.setNavigationBarItem()
    }

}
