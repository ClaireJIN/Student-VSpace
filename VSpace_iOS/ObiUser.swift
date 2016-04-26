//
//  ObiUser.swift
//  VSpace_iOS
//
//  Created by 李昂 on 15/8/29.
//  Copyright (c) 2015年 Obisoft Inc. All rights reserved.
//

import Foundation

class ObiUser: NSObject {
    var Username:String=""
    var PasswordDES:String=""
    override init() {
        super.init()
        self.Username=""
        self.PasswordDES=""
    }
}
