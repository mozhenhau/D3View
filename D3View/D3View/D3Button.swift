//
//  D3Button.swift
//  D3View
//
//  Created by mozhenhau on 15/5/15.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//

import Foundation
import UIKit


class D3Button: UIButton {
    
    required init(coder aDecoder: NSCoder) {  //默认按钮样式:圆角
        super.init(coder:aDecoder)
        if let style:ViewStyle = ViewStyle(rawValue: self.tag){
            initStyle(style)
        }
        if self.tag == 0{
            showCorner(ViewStyle.Conrer)
        }
    }
}