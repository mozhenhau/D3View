

import UIKit

extension String {
    func escapeStr() -> String {
        var raw: NSString = self
        var str:CFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,raw,"[].","+",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))
        return str as NSString as! String
    }
    
    //MARK: 字符分割扩展
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
    
    //MARK: 字符翻转扩展
    func reverse()-> String{
        var s:Array = self.split("").reverse()
        var x:String = ""
        for y in s{
            x += y
        }
        return x
    }
    
    //MARK: 字符包含扩展
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




//MARK: UIView动画扩展
var DEFAULT_DURATION:NSTimeInterval = 0.25
extension UIView{
    typealias VoidBlock = (() -> Void)?
    
    //MARK: 加入动画效果
    func addAnimation(type:String,subType:String!,duration:CFTimeInterval){
        var action:CATransition = CATransition()
        action.type = type
        if subType != nil{
            action.subtype = subType
        }
        action.duration = duration
        self.layer.addAnimation(action, forKey: "animation")
    }
    
    
    
    func degreesToRadians(r:CGFloat)->CGFloat
    {
        return CGFloat(Double(r) * M_PI / 180)
    }
    
    
    func setX(x:CGFloat,finish:VoidBlock){
        self.setX(x, duration: DEFAULT_DURATION, finish: finish)
    }
    
    
    func setX(x:CGFloat,duration:NSTimeInterval,finish:VoidBlock){
        UIView.animateWithDuration(duration, animations: {
            var frame = self.frame
            frame.origin.x = x
            self.frame = frame
        }, completion: {(f) in
            finish?()
        })
    }
    
    
    func setY(y:CGFloat,finish:VoidBlock){
        self.setY(y, duration: DEFAULT_DURATION, finish: finish)
    }
    
    
    func setY(y:CGFloat,duration:NSTimeInterval,finish:VoidBlock){
        UIView.animateWithDuration(duration, animations: {
            var frame = self.frame
            frame.origin.y = y
            self.frame = frame
            }, completion: {(f) in
                finish?()
        })
    }
    
    func setRotation(r:CGFloat,finish:VoidBlock){
        self.setRotation(r, duration: DEFAULT_DURATION, finish: finish)
    }
    
    
    func setRotation(r:CGFloat,duration:NSTimeInterval,finish:VoidBlock){
        UIView.animateWithDuration(duration, animations: {
            var ratationTransform = CGAffineTransformIdentity
            self.transform = CGAffineTransformRotate(ratationTransform, self.degreesToRadians(r))
        },completion:{(f) in
            finish?()
        })
    }
    
    func setPoint(point:CGPoint,duration:NSTimeInterval,finish:VoidBlock){
        UIView.animateWithDuration(duration, animations: {
            var frame = self.frame
            frame.origin = point
            self.frame = frame
        }, completion: {(f) in
            finish?()
        })
    }
    
    func setPoint(point:CGPoint,finish:VoidBlock){
        self.setPoint(point, duration: DEFAULT_DURATION, finish: finish)
    }
    
    
    //在原来基础上修改
    func moveX(x:CGFloat,duration:NSTimeInterval,finish:VoidBlock){
        self.setX(self.frame.origin.x+x, duration: duration, finish: finish)
    }
    
    func moveX(x:CGFloat,finish:VoidBlock){
        self.moveX(x, duration: DEFAULT_DURATION, finish: finish)
    }
    
    func moveY(y:CGFloat,duration:NSTimeInterval,finish:VoidBlock){
        self.setY(self.frame.origin.y+y, duration: duration, finish: finish)
    }
    
    func moveY(y:CGFloat,finish:VoidBlock){
        self.moveY(y, duration: DEFAULT_DURATION, finish: finish)
    }
    
    func moveRotation(r:CGFloat,duration:NSTimeInterval,finish:VoidBlock){
        UIView.animateWithDuration(duration, animations: {
            self.transform = CGAffineTransformRotate(self.transform, self.degreesToRadians(r))
        }, completion: {(f) in
            finish?()
        })
    }
    
    func moveRotation(r:CGFloat,finish:VoidBlock){
        self.moveRotation(r, duration: DEFAULT_DURATION, finish: finish)
    }
    
    func d3Animate(duration:NSTimeInterval,block:VoidBlock,finish:VoidBlock){
        UIView.animateWithDuration(duration, animations: {
            block?()
        }, completion: {(f) in
            finish?()
        })
    }
    
    func d3Animate(duration:NSTimeInterval,transition:UIViewAnimationTransition,forView:UIView,finish:VoidBlock){
        UIView.animateWithDuration(duration, animations: {
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
            UIView.setAnimationTransition(transition, forView: forView, cache: true)
            }, completion: {(f) in
                finish?()
        })
    }
    
    
    func d3Animate(transition:UIViewAnimationTransition,finish:VoidBlock){
        self.d3Animate(1.0, transition: transition, forView: self, finish: finish)
    }
    
    func d3Animate(transition:UIViewAnimationTransition){
        self.d3Animate(1.0, transition: transition, forView: self, finish: nil)
    }
    
    
    //MARK: 左右摇
    func shake(finish:VoidBlock){
        var dist:CGFloat = 10
        var time:NSTimeInterval = 0.15
        self.moveX(-dist, duration: time, finish: {
            self.moveX(dist*2, duration: time,finish: {
                self.moveX(-dist*2, duration: time, finish: {
                    self.moveX(dist,  duration: time,finish: {
                        finish?()
                    })
                })
            })
        })
    }
    
    func shake(){
        self.shake(nil)
    }
    
    //MARK: 上下反弹
    func bounce(finish:VoidBlock){
        var dist:CGFloat = 10
        self.moveY(-dist, duration: DEFAULT_DURATION, finish: {
            self.moveY(dist, duration: 0.15, finish: {
                self.moveY(-(dist/2), duration: 0.15, finish: {
                    self.moveY(dist/2, duration: 0.05, finish: {
                        finish?()
                    })
                })
            })
        })
    }
    
    func bounce(){
        self.bounce(nil)
    }
    
    //MARK: 心跳
    func pulse(finish:VoidBlock){
        UIView.animateWithDuration(0.5 as NSTimeInterval, animations: {
            self.transform = CGAffineTransformMakeScale(1.2, 1.2)
        }, completion: {(f) in
            UIView.animateWithDuration(0.5 as NSTimeInterval, delay: 0.1 as NSTimeInterval, options: UIViewAnimationOptions.LayoutSubviews, animations: {
                self.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: {(f) in
                    finish?()
            })
        })
    }
    
    func pulse(){
        self.pulse(nil)
    }
    
    //MARK: 摇摆
    func swing(finish:VoidBlock){
        var dist:CGFloat = 15
        self.setRotation(dist, finish: {
            self.setRotation(-dist, finish: {
                self.setRotation(dist/2, finish: {
                    self.setRotation(-dist/2, finish: {
                        self.setRotation(0, finish: {
                            finish?()
                        })
                    })
                })
            })
        })
    }
    
    func swing(){
        self.swing(nil)
    }
    
    
    //MARK: 缩小到不见
    func compress(finish:VoidBlock){
        self.d3Animate(1.0, block: {
            self.transform = CGAffineTransformMakeScale(0.01, 0.01)
        }, finish: {
            self.hidden = true
            finish?()
        })
    }
    
    func compress(){
        self.compress(nil)
    }
    
    
    //MARK: 放大到一个倍数
    func zoomin(size:CGFloat,finish:VoidBlock){
        self.hidden = false
        self.d3Animate(1.0, block: {
            self.transform = CGAffineTransformMakeScale(size, size)
        }, finish: finish)
    }
    
    func zoomin(size:CGFloat){
        self.zoomin(size,finish: nil)
    }
    
    
    //MARK: 转轴
    func hinge(finish:VoidBlock){
        var time:NSTimeInterval = 0.5
        var point = CGPointMake(self.frame.origin.x, self.frame.origin.y)
        self.layer.anchorPoint = CGPointMake(0, 0)
        self.center = point
        self.setRotation(80, duration: time, finish: {
            self.setRotation(70, duration: time, finish: {
                self.setRotation(80, duration: time, finish: {
                    self.setRotation(70, duration: time, finish: {
                        self.moveY(self.window!.frame.size.height, duration: time, finish: {
                            finish?()
                            self.setRotation(0, finish: nil)
                        })
                    })
                })
            })
        })
    }
    
    func hinge(){
        self.hinge(nil)
    }
    
    //MARK: 翻转
    func flip(finish:VoidBlock){
        self.d3Animate(UIViewAnimationTransition.FlipFromLeft,finish: finish)
    }
    
    func flip(){
        self.flip(nil)
    }
    
    func pageing(finish:VoidBlock){
        self.d3Animate(UIViewAnimationTransition.CurlUp,finish: finish)
    }
    
    func pageing(){
        self.pageing(nil)
    }
    
    //MARK: 切换效果
    
    
}


//MARK: UIView位置扩展
extension UIView{
    
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

//MARK: UIView样式扩展
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
}
