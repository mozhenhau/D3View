//
//  MoreViewController.swift
//  D3View
//
//  Created by mozhenhau on 15/6/16.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    @IBOutlet weak var radioBtn: D3RadioBtn!
    @IBOutlet weak var d3ScrollView: D3ScrollView!
    @IBOutlet weak var d3Label: D3Label!
    var num = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化点击后闭包
        radioBtn.addBlock({btn in
            println("click\(btn.tag)")
        })
        
        //初始化d3ScrollView
        var imgs = ["http://7vzpd0.com1.z0.glb.clouddn.com/pod.png","http://7vzpd0.com1.z0.glb.clouddn.com/EEFAD82B-6612-4783-98C4-67B0AB98DB69.png"]
        var labels = ["1","2"]
        d3ScrollView.initScrollView(imgs, labels:labels , style: ScrollViewStyle.all)
        
        //d3Label
        d3Label.setBadge(1)
    }

    
    @IBAction func clickShowActionSheet(sender: AnyObject) {
        var sheet = D3ActionSheet()
        sheet.initView(["照相","相片"], block: {
            println($0) //打印下标
        })
        sheet.showInView(self.view)
    }
    
    
    @IBAction func clickAdd(sender: AnyObject) {
        d3Label.setBadge(++num)
    }
    
    
    

}
