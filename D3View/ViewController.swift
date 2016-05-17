//
//  ViewController.swift
//  D3View
//
//  Created by mozhenhau on 15/5/31.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var d3view: UIView!
    var exFrame:CGRect!
    
    var dataSource = ["放大出现","缩小消失","闪亮","左右摇","上下摇","心跳","摇摆","缩小","放大","掉落","翻转","翻页","推出","覆盖","揭开","3D立方","抽走","不停旋转","渐隐","渐现"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
        exFrame = d3view.frame
    }

}

extension ViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //重置
        d3view.transform = CGAffineTransformIdentity
        d3view.size = CGSizeMake(exFrame.width, exFrame.height)
        d3view.d3_setPoint(CGPointMake(exFrame.origin.x, exFrame.origin.y), completion: nil)
        d3view.alpha = 1
        
        switch row-2{
        case -2:
            d3view.d3_scaleIn()
            
        case -1:
            d3view.d3_scaleOut(0.8, siteType: .Center)
            
        case 0:  //闪亮
            d3view.d3_blink()
            
        case 1:  //左右摇
            d3view.d3_shake()
            
        case 2:  //上下摇
            d3view.d3_bounce(10, duration: 0.2, completion: {
                print("摇完了")
            })
            
        case 3:  //心跳
            d3view.d3_heartbeat()
            
        case 4:  //摇摆
            d3view.d3_swing()
            
        case 5:  //缩小
            d3view.d3_scale(0.01)
            
        case 6:  //放大
            d3view.d3_scale(2.0)
            
        case 7:  //掉落
            d3view.d3_drop()
            
        case 8:  //翻转
            d3view.d3_flip()
            
        case 9:  //翻页
            d3view.d3_pageing()
            
        case 10:
            //后面的效果自己尝试，换参数而已
            //                fade     //交叉淡化过渡(不支持过渡方向)
            //                push     //新视图把旧视图推出去
            //                moveIn   //新视图移到旧视图上面
            //                reveal   //将旧视图移开,显示下面的新视图
            //                cube     //立方体翻滚效果
            //                oglFlip  //上下左右翻转效果
            //                suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
            //                rippleEffect //滴水效果(不支持过渡方向)
            //                pageCurl     //向上翻页效果
            //                pageUnCurl   //向下翻页效果
            //                cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
            //            cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
            
            
            //            subType:
            //            kCATransitionFromRight
            //            kCATransitionFromLeft
            //            kCATransitionFromTop
            //            kCATransitionFromBottom
            
            d3view.d3_Animation(kCATransitionPush, subType: kCATransitionFromRight, duration: 1.0)
            
        case 11:
            d3view.d3_Animation(kCATransitionMoveIn, subType: kCATransitionFromRight, duration: 1.0)
            
        case 12:
            d3view.d3_Animation(kCATransitionReveal, subType: kCATransitionFromRight, duration: 1.0)
            
        case 13:  //立方
            d3view.d3_Animation("cube", subType: kCATransitionFromRight, duration: 1.0)
            
        case 14:
            d3view.d3_Animation("suckEffect", subType: kCATransitionFromRight, duration: 1.0)
        
        case 15:  //不停旋转. 如果执行过掉落，这里可能有问题
            d3view.d3_setRotate(-1, duration: 1, completion: nil)
            
        case 16:  //渐隐
            d3view.d3_fadeOut()
            
        case 17:  //渐现
            d3view.d3_fadeIn()
            
        default:
            break
        }

    }
    
    @IBAction func clickDown(sender: UIButton) {
        d3view.d3_scaleOut(3, siteType: .Center)
    }
    
    @IBAction func clickUp(sender: UIButton) {
        d3view.d3_scale_stop()
    }
    
    
    
}

