//  Created by mozhenhau on 14/11/21.
//  Copyright (c) 2014年 mozhenhau. All rights reserved.
//  初始化话是基于tag的，比如D3Button默认tag为0时是圆角
//  使用方法1：在mainstoryboard继承D3__   ，然后tag设置为对应样式。(tag被占用的时候不可用)
//         2: 在viewcontroller实例化后在viewdiload进行初始化initstyle，可以传多个样式
//
import UIKit

//MARK: OTHER  widget
public class D3View: UIView {
    //对应enum ViewStyle
    @IBInspectable var viewStyle: Int = 0
    
    //对应enum ViewStyle,可写多个用逗号隔开
    @IBInspectable var viewStyles: String = ""{
        didSet{
            let styles = viewStyles.componentsSeparatedByString(",")
            for style in styles{
                if let style:ViewStyle = ViewStyle(rawValue: Int(style)!){
                    initStyle(style)
                }
            }
        }
    }
    
    @IBInspectable var isShadowDown: Bool = false {
        didSet {
            if isShadowDown{
                initStyle(ViewStyle.ShadowDown)
            }
        }
    }
    
    @IBInspectable var isShadow: Bool = false {
        didSet {
            if isShadow{
                initStyle(ViewStyle.Shadow)
            }
        }
    }
    
    @IBInspectable var isGrayBorder: Bool = false {
        didSet {
            if isGrayBorder{
                initStyle(ViewStyle.Border,ViewStyle.GrayBorder)
            }
        }
    }
    
    //是否圆形
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound{
                initStyle(ViewStyle.Round)
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clearColor(){
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}