//
//  D3RadioBtn.swift
//  Neighborhood
//
//  Created by mozhenhau on 15/1/20.
//  Copyright (c) 2015年 Ray. All rights reserved.
//  在storyboard的界面设计时，此类内部的所有UIButton都会在被此类控制
//
import UIKit

class D3RadioBtn: UIView {
    private var btns:Array<UIButton> = []
    private var norImg = "radio_btn_nor.png"
    private var preImg = "radio_btn_pre.png" //选中的图片
    private var block:(UIButton->Void)?
    var isBackgroundImg = false  //用背景图setBackgroundImage还是用图setImage.默认使用setImage
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        //初始化，把子视图的所有btn
        for view in self.subviews{
            if let btn = view as? UIButton{
                btns.append(btn)
                btn.addTarget(self, action: "clickBtn:", forControlEvents: UIControlEvents.TouchUpInside)
            }
        }
    }

    /**
    初始化值，比如性别：男女,不需要初始化的不需要调用
    */
    func initValue(index:Int){
        for btn in btns{
            setBtnImg(btn, img: norImg)
        }
        setBtnImg(btns[index], img: preImg)
    }
    
    
    /**
    要换选中和没选中的图则调用此方法
    */
    func initRadioImg(norImg:String,preImg:String){
        self.norImg = norImg
        self.preImg = preImg
    }
    
    /**
    添加点击的回调事件，回调返回参数为点击的按钮
    */
    func addBlock(block:(UIButton->Void)){
        self.block = block
    }
    
    /**
    点中按钮事件
    :param: sender 点中的按钮
    */
    func clickBtn(sender:UIButton){
        for btn in btns{
            setBtnImg(btn, img: norImg)
            
            if btn == sender{
                setBtnImg(btn, img: preImg)
                block?(btn)
            }
        }
    }
    
    
    
    /**
    设置radioBtn的图片
    :param: btn 需要设置的radio
    :param: img 设置preimg还是norimg
    */
    private func setBtnImg(btn:UIButton,img:String){
        if isBackgroundImg{
        btn.setBackgroundImage(UIImage(named: img), forState: UIControlState.Normal)
        }
        else{
        btn.setImage(UIImage(named: img), forState: UIControlState.Normal)
        }
    }
    
    /**
    设置成选中状态
    */
    func setBtnPre(btn:UIButton){
        setBtnImg(btn, img: preImg)
    }
    
    /**
    设置成没选状态
    */
    func setBtnNor(btn:UIButton){
        setBtnImg(btn, img: norImg)
    }
}
