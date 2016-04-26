//
//  LeftMenuProtocol.swift
//  VSpace_iOS
//
//  Created by 李昂 on 15/8/15.
//  Copyright (c) 2015年 Obisoft Inc. All rights reserved.
//

import UIKit
import Foundation

protocol LeftMenuProtocol: class {
    func gotoMainViewController(sender:UIGestureRecognizer)
    func gotoNEUIPGWViewController(sender:UIGestureRecognizer)
    func gotoTrafficQueryViewController(sender:UIGestureRecognizer)
    func gotoLostAndFoundViewController(sender:UIGestureRecognizer)
    func gotoQueryScoresViewController(sender:UIGestureRecognizer)
    func gotoVPNViewController(sender:UIGestureRecognizer)
    func gotoSchoolCommunityViewController(sender:UIGestureRecognizer)
    func gotoSettingsViewController(sender:UIGestureRecognizer)
    
    func Main2()
    func NEUIPGW2()
    func TrafficQuery2()
    func LostAndFound2()
    func QueryScores2()
    func VPN2()
    func SchoolCommunity2()
    func Settings2()
}