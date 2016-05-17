
import UIKit

//MARK: UIView动画扩展,d3开头的都是带动画的
var DEFAULT_DURATION:NSTimeInterval = 0.25
typealias CompleteBlock = (() -> Void)?

enum D3SiteType:Int {
    case Left
    case Right
    case Top
    case Bottom
    case LeftTop
    case RightTop
    case LeftBottom
    case RightBottom
    case Center
}


extension UIView{
    
    var left:CGFloat{
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get{
            return self.frame.origin.x
        }
    }
    
    var top:CGFloat{
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get{
            return self.frame.origin.y
        }
    }
    
    var right:CGFloat{
        set{
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
        get{
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    var bottom:CGFloat{
        set{
            var frame = self.frame;
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
        get{
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    var centerX:CGFloat{
        set{
            self.center = CGPointMake(newValue, self.center.y)
        }
        get{
            return self.center.x
        }
    }
    
    var centerY:CGFloat{
        set{
            self.center = CGPointMake(self.center.x, newValue)
        }
        get{
            return self.center.y
        }
    }
    
    var width:CGFloat{
        set{
            var frame = self.frame;
            frame.size.width = newValue
            self.frame = frame
        }
        get{
            return self.frame.size.width
        }
    }
    
    var height:CGFloat{
        set{
            var frame = self.frame;
            frame.size.height = newValue
            self.frame = frame
        }
        get{
            return self.frame.size.height
        }
    }
    
    var origin:CGPoint{
        set{
            var frame = self.frame;
            frame.origin = newValue
            self.frame = frame
        }
        get{
            return self.frame.origin
        }
    }
    
    
    var leftPoint:CGPoint{
        set{
            self.left = newValue.x
            self.centerY = newValue.y
        }
        get{
            return CGPointMake(left, centerY)
        }
    }
    
    var rightPoint:CGPoint{
        set{
            self.right = newValue.x
            self.centerY = newValue.y
        }
        get{
            return CGPointMake(right, centerY)
        }
    }
    
    var topPoint:CGPoint{
        set{
            self.centerX = newValue.x
            self.top = newValue.y
        }
        get{
            return CGPointMake(centerX, top)
        }
    }
    
    var bottomPoint:CGPoint{
        set{
            self.centerX = newValue.x
            self.bottom = newValue.y
        }
        get{
            return CGPointMake(centerX, bottom)
        }
    }
    
    
    var leftTopPoint:CGPoint{
        set{
            self.left = newValue.x
            self.top = newValue.y
        }
        get{
            return CGPointMake(left, top)
        }
    }
    
    
    var rightTopPoint:CGPoint{
        set{
            self.right = newValue.x
            self.top = newValue.y
        }
        get{
            return CGPointMake(right, top)
        }
    }
    
    
    var leftBottomPoint:CGPoint{
        set{
            self.left = newValue.x
            self.bottom = newValue.y
        }
        get{
            return CGPointMake(left, bottom)
        }
    }
    
    
    var rightBottomPoint:CGPoint{
        set{
            self.right = newValue.x
            self.bottom = newValue.y
        }
        get{
            return CGPointMake(right, bottom)
        }
    }
    
    var size:CGSize{
        set{
            var frame = self.frame;
            frame.size = newValue
            self.frame = frame
        }
        get{
            return self.frame.size
        }
    }
    
    
    //MARK: 动画效果基础类
    /**
     加入动画效果
     
     - parameter type:     
     fade     //交叉淡化过渡(不支持过渡方向)
     push     //新视图把旧视图推出去
     moveIn   //新视图移到旧视图上面
     reveal   //将旧视图移开,显示下面的新视图
     cube     //立方体翻滚效果
     oglFlip  //上下左右翻转效果
     suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
     rippleEffect //滴水效果(不支持过渡方向)
     pageCurl     //向上翻页效果
     pageUnCurl   //向下翻页效果
     cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
     cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
     
     
     - parameter subType:  
     kCATransitionFromRight
     kCATransitionFromLeft
     kCATransitionFromTop
     kCATransitionFromBottom
     
     
     - parameter duration: 动画持续时间
     */
    func d3_Animation(type:String,subType:String!,duration:NSTimeInterval){
        let action:CATransition = CATransition()
        action.type = type
        if subType != nil{
            action.subtype = subType
        }
        action.duration = duration
        self.layer.addAnimation(action, forKey: "animation")
    }
    
    //转场类
    func d3_Animation(duration:NSTimeInterval,transition:UIViewAnimationTransition,forView:UIView,completion:CompleteBlock){
        UIView.animateWithDuration(duration, animations: {
            UIView.setAnimationTransition(transition, forView: forView, cache: true)
            }, completion: {(finished) in
                completion?()
        })
    }
    
    //停止动画
    func d3_stop(){
        self.layer.removeAllAnimations()
    }
    
    //暂停动画
    func d3_pause(){
        let pauseTime = self.layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        print("暂停:\(pauseTime)")
        self.layer.speed = 0.0
        self.layer.timeOffset = pauseTime
    }
    
    //恢复动画
    func d3_resume(){
        let pauseTime = self.layer.timeOffset
        layer.speed = 1
        layer.timeOffset = 0
        layer.beginTime = 0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pauseTime
        print("暂停结束:\(timeSincePause)")
        layer.beginTime = timeSincePause
    }
    
    
    
    //角度转弧度
    func degreesToRadians(angle:CGFloat)->CGFloat
    {
        return CGFloat(Double(angle) * M_PI / 180)
    }
    
    
    func d3_setX(x:CGFloat,completion:CompleteBlock){
        self.d3_setX(x, duration: DEFAULT_DURATION, delay: 0,usingSpringWithDamping: 1, options: UIViewAnimationOptions.CurveEaseOut, completion: completion)
    }
    
    
    func d3_setX(x:CGFloat,usingSpringWithDamping:CGFloat ,completion:CompleteBlock){
        self.d3_setX(x, duration: DEFAULT_DURATION, delay: 0,usingSpringWithDamping: usingSpringWithDamping, options: UIViewAnimationOptions.CurveEaseOut, completion: completion)
    }
    
    func d3_setX(x:CGFloat,duration:NSTimeInterval,delay:NSTimeInterval,usingSpringWithDamping:CGFloat, options:UIViewAnimationOptions, completion:CompleteBlock){
        UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: 1, options: options, animations: {
            self.left = x
        }, completion: { f in
                completion?()
        })
    }
    
    
    func d3_setY(y:CGFloat,completion:CompleteBlock){
        self.d3_setY(y, duration: DEFAULT_DURATION, delay: 0,usingSpringWithDamping: 1, options: UIViewAnimationOptions.CurveEaseOut, completion: completion)
    }
    
    func d3_setY(y:CGFloat,usingSpringWithDamping:CGFloat,completion:CompleteBlock){
        self.d3_setY(y, duration: DEFAULT_DURATION, delay: 0,usingSpringWithDamping: usingSpringWithDamping, options: UIViewAnimationOptions.CurveEaseOut, completion: completion)
    }
    
    
    func d3_setY(y:CGFloat,duration:NSTimeInterval,delay:NSTimeInterval,usingSpringWithDamping:CGFloat,options:UIViewAnimationOptions, completion:CompleteBlock){
        UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: 1,  options: options, animations: {
            self.top = y
            }, completion: { f in
                completion?()
        })
    }
    
    
    func d3_setRotate(angle:CGFloat,completion:CompleteBlock){
        self.d3_setRotate(angle, duration: DEFAULT_DURATION, completion: completion)
    }
    
    /**
     *  旋转
     *
     *  @param duration   用时
     *  @param angle      角度， 为-1的时候一直转.  0~180
     *  @param completion 完成block
     */
    func d3_setRotate(angle:CGFloat,duration:NSTimeInterval,completion:CompleteBlock){
        var options:UIViewAnimationOptions!
        var angle = angle
        if angle == -1 {
            angle = 180
            options = [.Repeat, .CurveLinear]
        }
        else{
            options = UIViewAnimationOptions.CurveLinear
        }
        
        UIView.animateWithDuration(duration ,delay:0 ,options:options ,animations: {
            self.transform = CGAffineTransformMakeRotation(self.degreesToRadians(angle))
        },completion:{(finished) in
            completion?()
        })
    }
    
    //usingSpringWithDamping 越大弹簧震动越大
    func d3_setPoint(point:CGPoint,duration:NSTimeInterval,delay:NSTimeInterval,usingSpringWithDamping:CGFloat,options:UIViewAnimationOptions, completion:CompleteBlock){
        UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: 1, options: options, animations: {
            self.origin = point
            }, completion: { f in
                completion?()
        })
    }
    
    func d3_setPoint(point:CGPoint,usingSpringWithDamping:CGFloat,completion:CompleteBlock){
        self.d3_setPoint(point, duration: DEFAULT_DURATION,delay: 0,usingSpringWithDamping:usingSpringWithDamping, options: UIViewAnimationOptions.CurveEaseOut, completion: completion)
    }
    
    
    func d3_setPoint(point:CGPoint,completion:CompleteBlock){
        self.d3_setPoint(point, duration: DEFAULT_DURATION,delay: 0,usingSpringWithDamping:1, options: UIViewAnimationOptions.CurveEaseOut, completion: completion)
    }
    
    
    //在原来基础上移动
    func d3_moveX(x:CGFloat,duration:NSTimeInterval,completion:CompleteBlock){
        self.d3_setX(self.frame.origin.x+x, duration: duration, delay: 0,usingSpringWithDamping:1, options: UIViewAnimationOptions.CurveEaseOut, completion: completion)
    }
    
    func d3_moveX(x:CGFloat,completion:CompleteBlock){
        self.d3_moveX(x, duration: DEFAULT_DURATION, completion: completion)
    }
    
    func d3_moveY(y:CGFloat,duration:NSTimeInterval,completion:CompleteBlock){
        self.d3_setY(self.frame.origin.y+y, duration: duration, delay: 0,usingSpringWithDamping:1,options: UIViewAnimationOptions.CurveEaseOut, completion: completion)
    }
    
    func d3_moveY(y:CGFloat,completion:CompleteBlock){
        self.d3_moveY(y, duration: DEFAULT_DURATION, completion: completion)
    }
    
    
    
    //MARK: 左右摇
    /**
     左右摇动
     
     - parameter range:      摇动幅度
     - parameter duration:       摇动时间
     - parameter completion: 完成block
     */
    func d3_shake(range:CGFloat,duration:NSTimeInterval,completion:CompleteBlock){
        self.d3_moveX(-range, duration: duration, completion: {
            self.d3_moveX(range*2, duration: duration,completion: {
                self.d3_moveX(-range*2, duration: duration, completion: {
                    self.d3_moveX(range,  duration: duration,completion: {
                        completion?()
                    })
                })
            })
        })
    }
    
    func d3_shake(){
        self.d3_shake(10.0,duration: DEFAULT_DURATION,completion: nil)
    }
    
    //MARK: 上下摇
    /**
     上下摇
     
     - parameter range:    摇动幅度
     - parameter duration:   摇动时间
     - parameter finish: 完成block
     */
    func d3_bounce(range:CGFloat,duration:NSTimeInterval,completion:CompleteBlock){
        self.d3_moveY(-range, duration: duration, completion: {
            self.d3_moveY(range, duration: duration, completion: {
                self.d3_moveY(-(range/2), duration: duration, completion: {
                    self.d3_moveY(range/2, duration: duration, completion: {
                        completion?()
                    })
                })
            })
        })
    }
    
    
    func d3_bounce(){
        self.d3_bounce(10.0,duration: DEFAULT_DURATION,completion: nil)
    }
    
    
    //MARK: 心跳
    /**
     心跳
     
     - parameter range:  幅度
     - parameter duration:   时间
     - parameter finish: 完成block
     */
    func d3_heartbeat(range:CGFloat,duration:NSTimeInterval,completion:CompleteBlock){
        UIView.animateWithDuration(duration, animations: {
            self.transform = CGAffineTransformMakeScale(range, range)
            }, completion: {(f) in
                UIView.animateWithDuration(duration, delay: 0.1 as NSTimeInterval, options: [.LayoutSubviews,.CurveEaseOut], animations: {
                    self.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: {(f) in
                        completion?()
                })
        })
    }
    
    func d3_heartbeat(){
        self.d3_heartbeat(1.2,duration: 0.5,completion: nil)
    }
    
    
    //MARK: 摇摆
    /**
     摇摆
     
     - parameter finish: 完成block
     */
    func d3_swing(range:CGFloat,duration:NSTimeInterval, completion:CompleteBlock){
        self.d3_setRotate(range, duration: duration) { 
            self.d3_setRotate(-range, duration: duration, completion: { 
                self.d3_setRotate(range/2, duration: duration, completion: { 
                    self.d3_setRotate(0, duration: duration, completion: { 
                        completion?()
                    })
                })
            })
        }
    }
    
    func d3_swing(){
        self.d3_swing(15, duration: DEFAULT_DURATION, completion: nil)
    }
    
    
    //MARK: 放大缩小
    /**
     整体放大缩小
     */
    func d3_scale(scale:CGFloat,duration:NSTimeInterval,delay:NSTimeInterval,options:UIViewAnimationOptions, finish:CompleteBlock){
        UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.transform = CGAffineTransformMakeScale(scale, scale)
        }, completion: { f in
                finish?()
        })
    }
    
    func d3_scale(scale:CGFloat){
        self.d3_scale(scale, duration: DEFAULT_DURATION,delay: 0,options: UIViewAnimationOptions.CurveEaseOut, finish: nil)
    }
    
    /**
     宽放大缩小
     */
    func d3_scaleX(scale:CGFloat,duration:NSTimeInterval,delay:NSTimeInterval,options:UIViewAnimationOptions,  finish:CompleteBlock){
        UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
            self.transform = CGAffineTransformMakeScale(scale, 1)
            }, completion: { f in
                finish?()
        })
    }
    
    func d3_scaleX(scale:CGFloat){
        self.d3_scaleX(scale, duration: DEFAULT_DURATION,delay: 0,options: UIViewAnimationOptions.CurveEaseOut, finish: nil)
    }
    
    /**
     高放大缩小
     */
    func d3_scaleY(scale:CGFloat,duration:NSTimeInterval, delay:NSTimeInterval,options:UIViewAnimationOptions,  finish:CompleteBlock){
        UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
            self.transform = CGAffineTransformMakeScale(scale, 1)
            }, completion: { f in
                finish?()
        })
    }
    
    func d3_scaleY(scale:CGFloat){
        self.d3_scaleY(scale, duration: DEFAULT_DURATION,delay: 0,options: UIViewAnimationOptions.CurveEaseOut, finish: nil)
    }
    

    
    //MARK: 掉落
    func d3_drop(duration:NSTimeInterval, completion:CompleteBlock){
        //移动锚点
        let point = CGPointMake(self.frame.origin.x, self.frame.origin.y)
        self.layer.anchorPoint = CGPointMake(0, 0)
        self.center = point
        
        self.d3_setRotate(80, duration: duration, completion: {
            self.d3_setRotate(70, duration: duration, completion: {
                self.d3_setRotate(80, duration: duration, completion: {
                    self.d3_setRotate(70, duration: duration, completion: {
                        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { 
                                self.top = UIScreen.mainScreen().bounds.height+self.frame.size.height
                            }, completion: { (finished) in
                                self.layer.anchorPoint = CGPointMake(0.5, 0.5)
                                completion?()
                        })
                        
                    })
                })
            })
        })
    }
    
    func d3_drop(){
        self.d3_drop(0.5, completion: nil)
    }
    
    //MARK: 翻转
    func d3_flip(duration:NSTimeInterval, completion:CompleteBlock){
        self.d3_Animation(duration,transition: UIViewAnimationTransition.FlipFromLeft,forView: self, completion: completion)
    }
    
    func d3_flip(){
        self.d3_flip(1.0, completion: nil)
    }
    
    
    //MARK: 翻页
    func d3_pageing(duration:NSTimeInterval, completion:CompleteBlock){
        self.d3_Animation(duration,transition: UIViewAnimationTransition.CurlUp,forView: self, completion: completion)
    }
    
    func d3_pageing(){
        self.d3_pageing(1.0, completion: nil)
    }
    
    
    //MARK: 闪,呼吸灯
    func d3_blink(duration:NSTimeInterval){
        UIView.animateWithDuration(duration, delay: 0, options: [.Repeat,.Autoreverse,.CurveEaseOut], animations: { 
            self.alpha = 0;
        }, completion: nil)
    }
    
    func d3_blink(){
        self.d3_blink(0.5)
    }
    
    //MARK: 渐隐
    func d3_fadeOut(duration:NSTimeInterval,completion:CompleteBlock){
        UIView.animateWithDuration(duration, animations: { 
            self.alpha = 0
        }, completion: {(finished) in
            completion?()
        })
    }
 
    func d3_fadeOut(){
        self.d3_fadeOut(0.5, completion: nil)
    }
    
    //MARK: 渐现
    func d3_fadeIn(duration:NSTimeInterval,completion:CompleteBlock){
        self.hidden = false
        self.alpha = 0
        UIView.animateWithDuration(duration, animations: {
            self.alpha = 1
        }, completion: {(finished) in
            completion?()
        })
    }
    
    func d3_fadeIn(){
        self.d3_fadeIn(0.5, completion: nil)
    }
    
    
    func  d3_scaleIn(){
        d3_Scale_Transite(0.5, siteType: .LeftTop, hide: false)
    }
    
    func  d3_scaleIn(duration:NSTimeInterval,siteType:D3SiteType){
        d3_Scale_Transite(duration, siteType: siteType, hide: false)
    }
    
    func  d3_scaleOut(){
        d3_Scale_Transite(0.5, siteType: .LeftTop, hide: true)
    }
    
    func  d3_scaleOut(duration:NSTimeInterval,siteType:D3SiteType){
        d3_Scale_Transite(duration, siteType: siteType, hide: true)
    }
    
    func d3_scale_stop(){
        
        let oldAnimation = self.layer.mask?.animationForKey("transform.scale") as? CABasicAnimation
        let pauseTime = layer.mask?.timeOffset
        let toValue = oldAnimation!.toValue!.doubleValue
        let fromValue = oldAnimation!.fromValue!.doubleValue
        let duration = oldAnimation!.duration
        self.layer.mask?.removeAllAnimations()
        
        if oldAnimation != nil && (self.layer.mask?.convertTime(CACurrentMediaTime(), fromLayer: nil)) != nil{
            let maskLayerAnimation = CABasicAnimation(keyPath: "transform.scale")
            let timeSincePause = (self.layer.mask?.convertTime(CACurrentMediaTime(), fromLayer: nil))! - pauseTime!*2
            maskLayerAnimation.duration = timeSincePause
            
            if fromValue > toValue { //原来是缩小
                let nowValue = fromValue - fromValue*timeSincePause/duration
                maskLayerAnimation.fromValue = nowValue
                maskLayerAnimation.toValue = fromValue
            }
            else{
                let nowValue = toValue*timeSincePause/duration
                maskLayerAnimation.fromValue = nowValue
                maskLayerAnimation.toValue = fromValue
            }
            maskLayerAnimation.removedOnCompletion = false
            maskLayerAnimation.fillMode = kCAFillModeForwards
            maskLayerAnimation.delegate = self
            layer.mask?.addAnimation(maskLayerAnimation, forKey: "transform.scale")
            self.layer.mask?.timeOffset = (self.layer.mask?.convertTime(CACurrentMediaTime(), fromLayer: nil))!
        }
        
        
        //        layer.beginTime = timeSincePause
        //        print(toValue)
        
    }
    
    func d3_Scale_Transite(duration:NSTimeInterval,siteType:D3SiteType,hide:Bool){  //转场
        let layer = CAShapeLayer()
        layer.cornerRadius = 5
        layer.backgroundColor = UIColor.whiteColor().CGColor
        let layerSize:CGFloat = 10
        
        self.layer.mask = layer
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "transform.scale")
        maskLayerAnimation.duration = duration
        var toValue = sqrt(pow(self.bounds.width,2)+pow(self.bounds.height,2))/layerSize*2
        
        
        switch siteType {
        case .Left:
            layer.frame = CGRectMake(-layerSize/2, self.height/2-layerSize/2, layerSize, layerSize)
            toValue = sqrt(pow(self.bounds.width,2)+pow(self.bounds.height/2,2))/layerSize*2
            
        case .Right:
            layer.frame = CGRectMake(self.width-layerSize/2, self.self.height/2-layerSize/2, layerSize, layerSize)
            toValue = sqrt(pow(self.bounds.width,2)+pow(self.bounds.height/2,2))/layerSize*2
            
        case .Top:
            layer.frame = CGRectMake(self.width/2-layerSize/2, -layerSize/2, layerSize, layerSize)
            toValue = sqrt(pow(self.bounds.width/2,2)+pow(self.bounds.height,2))/layerSize*2
            
        case .Bottom:
            layer.frame = CGRectMake(self.width/2-layerSize/2, self.height+layerSize/2, layerSize, layerSize)
            toValue = sqrt(pow(self.bounds.width/2,2)+pow(self.bounds.height,2))/layerSize*2
            
        case .LeftTop:
            layer.frame = CGRectMake(-layerSize/2, -layerSize/2, layerSize, layerSize)
            
        case .LeftBottom:
            layer.frame = CGRectMake(-layerSize/2, self.height-layerSize/2, layerSize, layerSize)
            
        case .RightTop:
            layer.frame = CGRectMake(self.width-layerSize/2, -layerSize/2, layerSize, layerSize)
            
        case .RightBottom:
            layer.frame = CGRectMake(self.width-layerSize/2, self.height-layerSize/2, layerSize, layerSize)
            
        case .Center:
            layer.frame = CGRectMake(self.width/2-layerSize/2, self.height/2-layerSize/2, layerSize, layerSize)
            toValue = sqrt(pow(self.bounds.width/2,2)+pow(self.bounds.height/2,2))/layerSize*2
        }
        
        
        maskLayerAnimation.fromValue = hide ? toValue : 1
        maskLayerAnimation.toValue = hide ? 0.0001 : toValue
        //不还原
        maskLayerAnimation.removedOnCompletion = false
        maskLayerAnimation.fillMode = kCAFillModeForwards
        maskLayerAnimation.delegate = self
        layer.addAnimation(maskLayerAnimation, forKey: "transform.scale")
        if self.layer.mask?.convertTime(CACurrentMediaTime(), fromLayer: nil) != nil {
            self.layer.mask?.timeOffset = (self.layer.mask?.convertTime(CACurrentMediaTime(), fromLayer: nil))!
        }
    }
}