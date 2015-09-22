//
//  D3TextView.swift
//  D3View
//
//  Created by mozhenhau on 15/5/15.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//

import Foundation
import UIKit

public class D3TextView:UITextView{
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
        if let style:ViewStyle = ViewStyle(rawValue: self.tag){
            initStyle(style)
        }
        
        if self.tag == 0{
            addBorder(ViewStyle.Border)
        }
    }
}