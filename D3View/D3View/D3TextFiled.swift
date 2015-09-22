//
//  D3TextFiled.swift
//  D3View
//
//  Created by mozhenhau on 15/5/15.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//

import Foundation
import UIKit

public class D3TextField:UITextField,UITextFieldDelegate{
    @IBInspectable var litmit: Int = 30  //为0则不限制
    @IBInspectable var isGrayBorder: Bool = false {
        didSet {
            if isGrayBorder{
                self.borderStyle = UITextBorderStyle.None
                self.initStyle(ViewStyle.Border)
                self.layer.borderColor = UIColor(red: 50/255 , green: 50/255, blue: 50/255, alpha: 0.8).CGColor
            }
        }
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
        delegate = self
        if let style:ViewStyle = ViewStyle(rawValue: self.tag){
            initStyle(style)
        }
    }
    
    func setLitmitCount(litmit:Int){
        self.litmit = litmit
    }
    
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        if litmit != 0 && range.location > litmit{
            return false
        }
        return true
    }
}