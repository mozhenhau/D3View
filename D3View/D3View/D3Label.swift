//
//  D3Label.swift
//  D3View
//
//  Created by mozhenhau on 15/5/15.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//

import Foundation
import UIKit


public class D3Label:UILabel{
    var ori_width:CGFloat = 0
    @IBInspectable var isHide: Bool = true   //为true时num为0会隐藏
    //显示为红点
    @IBInspectable var isBadge: Bool = false {
        didSet {
            if isBadge{
                self.backgroundColor = UIColor.redColor()
                self.textColor = UIColor.whiteColor()
                self.textAlignment = NSTextAlignment.Center
                self.showRound()
                if isHide{
                    hidden = true
                }
            }
        }
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.ori_width = self.frame.width
    }
    
    func setBadge(num:Int){
        if num == 0
        {
            if isHide{
                self.hidden = true
            }
            return
        }
        self.hidden = false
        var width:CGFloat = 0
        var string:String = "\(num)"
        if num < 10
        {
            width = ori_width
        }
        else if num < 100
        {
            width = ori_width*1.5
        }
        else
        {
            width = ori_width*2
            string = "99+"
        }
        self.text = string
        self.frame.size.width = width
        self.shake(2.0, time: 0.15)
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: width))
    }
}
