
//
//  D3AlertView.swift
//  MoDay
//
//  Created by mozhenhau on 15/6/28.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//  build().show()
//

import UIKit

class D3AlertView: UIAlertView,UIAlertViewDelegate{
    var block:((Int,String?)->Void)? //有textfield的时候会传string出去
    
    func build(title:String!,message:String?,btnTitles:Array<String>,placeHolder:String?,block:((Int,String?)->Void)?)->D3AlertView{
        self.title = title
        self.message = message
        self.delegate = self
        self.block = block
        for btn in btnTitles{
            self.addButtonWithTitle(btn)
        }
        self.addButtonWithTitle("取消")
        if placeHolder != nil{
            self.alertViewStyle = UIAlertViewStyle.PlainTextInput
            textFieldAtIndex(0)?.placeholder = placeHolder
        }
        return self
    }
    
    func build(title:String!,message:String?,btnTitles:Array<String>,block:((Int,String?)->Void)?)->D3AlertView{
        return build(title, message: message, btnTitles: btnTitles, placeHolder: nil, block: block)
    }
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        block?(buttonIndex,textFieldAtIndex(0)?.text)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
