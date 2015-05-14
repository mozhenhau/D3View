//
//  MyUITapGestureRecognizer.swift
//  Neighborhood
//
//  Created by mozhenhau on 14/10/30.
//  Copyright (c) 2014年 Ray. All rights reserved.
//

import UIKit

class D3UITapGestureRecognizer: UITapGestureRecognizer {
    var obj:AnyObject!
    
    override init(target: AnyObject, action: Selector) {
        super.init(target: target, action: action)
    }
    
    
    init(target: AnyObject, action: Selector,obj:AnyObject) {
        self.obj = obj
        super.init(target: target, action: action)
    }
}
