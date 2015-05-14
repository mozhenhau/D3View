//
//  Neighborhood
//
//  Created by mozhenhau on 14/11/21.
//  Copyright (c) 2014年 Ray. All rights reserved.
//  初始化话是基于tag的，比如D3Button默认tag为0时是圆角
//  使用方法1：在mainstoryboard继承D3__   ，然后tag设置为对应样式。(tag被占用的时候不可用)
//         2: 在viewcontroller实例化后在viewdiload进行初始化initstyle，可以传多个样式
//
import UIKit
enum ViewStyle:Int{
    case Round        = 168//圆形
    case Conrer       = 169//圆角3.0
    case Border       = 170//边线0.5
    case BorderM      = 171//边线1
    case ConrerM      = 172//圆角10.0
    case Shadow       = 173//阴影
    case ShadowDown   = 174//下阴影
    case BorderRight  = 175//右边线
    case BorderBottom = 176//下边线
    case GrayBorder   = 177//border灰颜色
    case DarkGrayBorder   = 178//border深灰颜色
}

extension UIView{

    //加边线,边框
    private func addBorder(style:ViewStyle){
        switch style{
        case .Border:   //边框宽度0.5
            self.layer.borderWidth = 0.5
            
        case .BorderM:
            self.layer.borderWidth = 1    //边框宽度1
            
        case .BorderRight:     //右边框宽度0.5
            let line = UIView(frame: CGRectMake(frame.width - 0.5, 0, 0.5, frame.height))
            line.backgroundColor = UIColor(red: 100/255 , green: 100/255, blue: 100/255, alpha: 0.3)
            self.addSubview(line)
            
            
        case .BorderBottom:    //下边框宽度0.5
            let line = UIView(frame: CGRectMake(0, frame.height - 0.5, frame.width, 0.5))
            line.backgroundColor = UIColor(red: 100/255 , green: 100/255, blue: 100/255, alpha: 0.3)
            self.addSubview(line)
            
        default:
            break
        }
        self.layer.borderColor = D3Cons.defaultColor.CGColor
    }
    
    func changeBorderColor(style:ViewStyle){
        switch style{
        case .DarkGrayBorder:
            self.layer.borderColor = UIColor(red: 100/255 , green: 100/255, blue: 100/255, alpha: 0.8).CGColor
            
            case .GrayBorder:
                self.layer.borderColor = UIColor(red: 200/255 , green: 200/255, blue: 200/255, alpha: 0.5).CGColor
            
            default:
            break
        }
    }
    
    //加阴影
    private func addShadow(style:ViewStyle){
        switch style{
        case .Shadow:
            layer.shadowOffset = CGSizeMake(0, 0)   //x为向右偏移，y为向下偏移
        
        case .ShadowDown:
            layer.shadowOffset = CGSizeMake(0, 2)
            
        default:
            break
        }
        layer.shadowOpacity = 0.1   //透明度
        layer.shadowRadius = 2.0    //阴影半径
        layer.shadowColor = UIColor.blackColor().CGColor
    }
    
    
    
    //圆角
    private func showCorner(style:ViewStyle){
        switch style{
        case .ConrerM:
            self.layer.cornerRadius = 10.0   //弧度为10，大弧度
            
        case .Conrer:
            self.layer.cornerRadius = 3.0   //弧度为3，小弧度
            
        default:
            break
        }
        self.layer.masksToBounds = true
    }
    
    
    
    //显示圆形
    private func showRound(){
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
    }
    
    
    
    //初始化style
    func initStyle(styles:ViewStyle...){
        for style:ViewStyle in styles{
            switch style{
            case .Round:
                showRound()
                
            case .Conrer, .ConrerM:
                showCorner(style)
                
            case .Border, .BorderM, .BorderRight, .BorderBottom:
                addBorder(style)
                
            case .ShadowDown,.Shadow:
                addShadow(style)
                
            case .GrayBorder,.DarkGrayBorder:
                changeBorderColor(style)
                
            default:
                break
            }
        }
    }
    
    
    //MARK: 加入动画效果
    func addAnimation(type:String,subType:String,duration:CFTimeInterval){
        var action:CATransition = CATransition()
        action.type = type
        action.subtype = subType
        action.duration = duration
        self.layer.addAnimation(action, forKey: nil)
    }

    
    //MARK: 获取所在的vc
   func findMainViewController() -> UIViewController
    {
        var target:AnyObject = self
        while(true)
        {
            target = (target as! UIResponder).nextResponder()!
            
            if target is UIViewController
            {
                break
            }
        }
        return target as! UIViewController
        
    }
    
    
    
    //位置控制
    /**
    左边界对齐目标view的右边界
    :param: view    目标view
    :param: padding 距离
    */
    func right2View(view:UIView,padding:CGFloat){
        frame.origin.x = view.frame.origin.x + view.frame.width + padding
    }
    
    /**
    右边界对齐目标view的左边界
    :param: view    目标view
    :param: padding 距离
    */
    func left2View(view:UIView,padding:CGFloat){
        frame.origin.x = view.frame.origin.x - frame.width - padding
    }
    
    /**
    右边界对齐目标view的右边界
    :param: view    目标view
    :param: padding 距离
    */
    func right2ViewInner(view:UIView,padding:CGFloat){
        frame.origin.x = view.frame.origin.x + view.frame.width - frame.width - padding
    }
    
    /**
    左边界对齐目标view的左边界
    :param: view    目标view
    :param: padding 距离
    */
    func left2ViewInner(view:UIView,padding:CGFloat){
        frame.origin.x = view.frame.origin.x + padding
    }
    
    //下边界对齐目标上边界
    func top2View(view:UIView,padding:CGFloat){
        frame.origin.y = view.frame.origin.y - frame.height - padding
    }
    
    //上边界对齐目标下边界
    func bottom2View(view:UIView,padding:CGFloat){
        frame.origin.y = view.frame.origin.y + view.frame.height + padding
    }
    
    func shake(duration:CGFloat)
    {
        var shake:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        shake.fromValue = -0.3
        shake.toValue = 0.3
        shake.duration = 0.1
        shake.repeatCount =  Float(duration)/0.2
        shake.autoreverses = true
        self.layer.addAnimation(shake, forKey: "shakeView")
        
    }
    
}



//MARK: OTHER  widget
public class D3View: UIView {
    //对应enum ViewStyle
    @IBInspectable var viewStyle: Int = 0
    
    //对应enum ViewStyle,可写多个用逗号隔开
    @IBInspectable var viewStyles: String = ""{
        didSet{
            var styles = viewStyles.split(",")
            for style in styles{
                if let styleInt = style.toInt() {
                    if let style:ViewStyle = ViewStyle(rawValue: style.toInt()!){
                        initStyle(style)
                    }
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


class D3Button: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        if let style:ViewStyle = ViewStyle(rawValue: self.tag){
            initStyle(style)
        }
        if self.tag == 0{ //默认圆角
            showCorner(ViewStyle.Conrer)
        }
    }
}


class D3ImageView:UIImageView{
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound{
                initStyle(ViewStyle.Round)
            }
        }
    }
    
    
    @IBInspectable var isCorner: Bool = false {
        didSet {
            if isRound{
                initStyle(ViewStyle.Conrer)
                if cornerRadius != 0{
                    self.layer.cornerRadius = cornerRadius
                }
            }
        }
    }
}



class D3TextField:UITextField,UITextFieldDelegate{
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
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        delegate = self
        if let style:ViewStyle = ViewStyle(rawValue: self.tag){
            initStyle(style)
        }
    }
    
    func setLitmitCount(litmit:Int){
        self.litmit = litmit
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        if litmit != 0 && range.location > litmit{
            return false
        }
        return true
    }
}


class D3TextView:UITextView{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        if let style:ViewStyle = ViewStyle(rawValue: self.tag){
            initStyle(style)
        }
        
        if self.tag == 0{
            addBorder(ViewStyle.Border)
        }
    }
}

class D3Label:UILabel{
    @IBInspectable var isHide: Bool = true   //为true时num为0会隐藏
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
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        if let style:ViewStyle = ViewStyle(rawValue: self.tag){
            initStyle(style)
        }
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
            width = self.frame.height
        }
        else if num < 100
        {
            width = self.frame.height*1.5
        }
        else
        {
            width = self.frame.height*2
            string = "99+"
        }
        self.text = string
//        self.frame.width = width
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: width))
        
    }
}


