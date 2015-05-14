//
//  UICons.swift
//  Neighborhood
//
//  Created by 陈经达 on 15/1/6.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

import UIKit

enum deviceModel:Int
{
    case iPhone_4  = 1  //pixel: 640*960   @2x
    case iPhone_5  = 2  //pixel: 640x1136  @2x
    case iPhone_6  = 3  //pixel: 750x1334  @2x
    case iPhone_6P = 4  //pixel: 1242x2208 @3x
    case unKnown   = 5  //pixel: unknown
}

func getDeviceModel() -> deviceModel
{
    var name:UnsafeMutablePointer<utsname> = UnsafeMutablePointer.alloc(1)
    uname(name)
    let machine:String? = withUnsafePointer(&name.memory.machine, { (ptr) -> String? in
        
        var int8Ptr:UnsafePointer<CChar> = unsafeBitCast(ptr, UnsafePointer.self)
        return String.fromCString(int8Ptr)
    })
    
    name.dealloc(1)
    
    var deviceString:String
    if machine != nil
    {
        deviceString = machine!
        if deviceString == "iPhone3,1" || deviceString == "iPhone3,2" || deviceString == "iPhone4,1"
        {
            return .iPhone_4
        }
        else if deviceString == "iPhone5,2" || deviceString == "iPhone5,3" || deviceString == "iPhone5,4" || deviceString == "iPhone6,2"
        {
            return .iPhone_5
        }
        else if deviceString == "iPhone7,2"
        {
            return .iPhone_6
        }
        else if deviceString == "iPhone7,1"
        {
            return .iPhone_6P
        }
        else
        {
            return .unKnown
        }

    }
    return .unKnown
    
}

var DM:deviceModel = getDeviceModel()

let screenFrame:CGRect = UIScreen.mainScreen().bounds
let screenWidth:CGFloat = screenFrame.size.width
let screenHeight:CGFloat = screenFrame.size.height
let screenCenterX:CGFloat = screenWidth/2
let screenCenterY:CGFloat = screenHeight/2


