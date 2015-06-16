//
//  NoticeViewController.swift
//  D3View
//
//  Created by mozhenhau on 15/6/16.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController {

    
    @IBAction func clickClearNotcie(sender: AnyObject) {
        clearAllNotice()
    }
    
    @IBAction func clickShowSuc(sender: AnyObject) {
        showNoticeSuc("suc")
    }
    
    
    @IBAction func clickShowSucNotDisapear(sender: AnyObject) {
        showNoticeSuc("suc", time: D3Notice.longTime, autoClear: false)
    }
    
    @IBAction func clickShowErr(sender: AnyObject) {
        showNoticeErr("err")
    }
    
    @IBAction func clickSowInfo(sender: AnyObject) {
        showNoticeInfo("info")
    }
    
    @IBAction func clickShowWait(sender: AnyObject) {
        showNoticeWait()
    }
    
    @IBAction func clickShowText(sender: AnyObject) {
        showNoticeText("text")
    }
    
    @IBAction func clickShowSuc2(sender: AnyObject) {
        D3Notice.showNoticeWithText(NoticeType.success, text: "suc",time: D3Notice.longTime, autoClear: true)
    }
    

}
