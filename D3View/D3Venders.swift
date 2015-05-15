

import UIKit

extension String {
    func escapeStr() -> String {
        var raw: NSString = self
        var str:CFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,raw,"[].","+",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))
        return str as NSString as! String
    }
    
    func split(s:String)->Array<String>
    {
        if s.isEmpty{
            var x:Array<String> = []
            for y in self{
                x.append(String(y))
            }
            return x
        }
        return self.componentsSeparatedByString(s)
    }
    
    func reverse()-> String{
        var s:Array = self.split("").reverse()
        var x:String = ""
        for y in s{
            x += y
        }
        return x
    }
    
    func contain(s:String)->Bool{
        var ns = self as NSString
        if ns.rangeOfString(s).length > 0{
            return true
        }
        return false
    }
}

extension Array{

    func filter<T>(name:String)->Array<T>{
        var newArr:Array<T> = []
        for item in self {
            var pros:MirrorType = reflect(item)
            for(var i:Int = 1;i < pros.count;i++){
                var pro = pros[i]
                let key = pro.0        //pro  name
                let value = pro.1.value
                if name == key{
                    newArr.append(pro.1.value as! T)
                    break
                }
            }
        }
        return newArr
    }
}



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
    func addBorder(style:ViewStyle){
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
        self.layer.borderColor = UIColor.grayColor().CGColor
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
    func addShadow(style:ViewStyle){
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
    func showCorner(style:ViewStyle){
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
    func showRound(){
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