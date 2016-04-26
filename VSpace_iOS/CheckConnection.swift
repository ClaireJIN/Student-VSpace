//
//  CheckConnection.swift
//  VSpace_iOS
//
//  Created by 李昂 on 15/8/10.
//  Copyright (c) 2015年 Obisoft Inc. All rights reserved.
//

import Foundation

func checkConnection(checkURL checkURL:NSURL, allowInterval:NSTimeInterval) -> Double {
    // 开始计时
    let dateTimePast:NSDate=NSDate(timeIntervalSinceNow: 0)
    // 连接请求
    let chkURLRequest:NSURLRequest=NSURLRequest(URL: checkURL, cachePolicy: NSURLRequestCachePolicy(rawValue: 1)!, timeoutInterval: allowInterval)
    let _data:NSData?=try? NSURLConnection.sendSynchronousRequest(chkURLRequest, returningResponse: nil)
    // 当返回不为空时，计算时间间隔
    if (_data != nil) {
        let dateTimeNow:NSDate=NSDate(timeIntervalSinceNow: 0)
        let atimer:NSTimeInterval=dateTimeNow.timeIntervalSinceDate(dateTimePast)
        return (atimer as Double)
    }
    else {
        return -1
    }
}
