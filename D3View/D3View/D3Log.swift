//
//  D3Log.swift
//  MoDay
//
//  Created by mozhenhau on 15/6/26.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//

import UIKit

func D3Log<T>(message: T, function: String = __FUNCTION__) {
    #if DEBUG
        print("\(function): \(message)")
//    #else
//        println("not debug")
    #endif
}
    

