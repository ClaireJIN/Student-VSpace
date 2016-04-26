//
//  ViewController.swift
//  VSpace_iOS
//
//  Created by 李昂 on 15/8/9.
//  Copyright (c) 2015年 Obisoft Inc. All rights reserved.
//

import UIKit

class MainViewController: VSpaceOutViewController {
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var NetworkModeView: UIView!
    // 需调整
    var GettingNetworkView:UIView=UIView(frame: CGRectMake(0, 20, UIScreen.mainScreen().bounds.width, 20))
    
    @IBOutlet var FreshNetworkView: UIView!
    @IBOutlet var FreshNetworkButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.frame=CGRectMake(0, 64, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-64)
        //---------
        scrollView.contentSize=CGSize(width: UIScreen.mainScreen().bounds.width, height: 474)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}



