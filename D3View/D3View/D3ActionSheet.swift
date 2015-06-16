//
//  D3ActionSheet.swift
//  Neighborhood
//
//  Created by mozhenhau on 15/6/10.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//  用代理写actionsheet太麻烦就用block写了
//

import UIKit

class D3ActionSheet: UIActionSheet,UIActionSheetDelegate{
    var block:((Int)->Void)?
    
    func initView(btnTitles:Array<String>,block:((Int)->Void)?) {
        self.delegate = self
        self.block = block
        for btn in btnTitles{
            self.addButtonWithTitle(btn)
        }
        self.addButtonWithTitle("取消")
    }
    
    //下标从0开始，对应的就是btnTitles的下标
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int){
        block?(buttonIndex)
    }
}
