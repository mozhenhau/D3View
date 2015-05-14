//
//  Cons.swift
//  D3Framework
//
//  Created by mozhenhau on 15/5/12.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//

import Foundation
import UIKit

@objc(D3Cons)
class D3Cons:NSObject{
    static var IS_DEBUG = false
    static var defaultColor  = UIColor(red: 153/255, green: 201/255, blue: 47/255, alpha: 1)
    static var grayColor     = UIColor(red: 0.0 , green: 0.0, blue: 0.0, alpha: 0.6)
    static var lon           = 0.0
    static var lat           = 0.0
    static var defaultImg    = "defaul_img.png"
    static var defaulHeadImg = "default_head.png"
    static var imgHost       = "http://img.linli100.com/"
}