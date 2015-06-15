//
//  D3Notice.swift
//  D3Notice
//
//  Created by mozhenhau on 15/6/11.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//  显示最后一个
//
import Foundation
import UIKit

extension UIViewController {
    //suc,3秒自动消失
    func showNoticeSuc(text: String) {
        D3Notice.showNoticeWithText(NoticeType.success, text: text,time: D3Notice.longTime, autoClear: true)
    }
    
    func showNoticeSuc(text: String,time:NSTimeInterval, autoClear: Bool) {
        D3Notice.showNoticeWithText(NoticeType.success, text: text,time: time, autoClear: autoClear)
    }
    
    //err
    func showNoticeErr(text: String) {
        D3Notice.showNoticeWithText(NoticeType.error, text: text,time: D3Notice.longTime, autoClear: true)
    }
    func showNoticeErr(text: String,time:NSTimeInterval, autoClear: Bool) {
        D3Notice.showNoticeWithText(NoticeType.error, text: text, time:time,autoClear: autoClear)
    }
    
    //info
    func showNoticeInfo(text: String) {
        D3Notice.showNoticeWithText(NoticeType.info, text: text, time: D3Notice.longTime,autoClear: true)
    }
    func showNoticeInfo(text: String,time:NSTimeInterval, autoClear: Bool) {
        D3Notice.showNoticeWithText(NoticeType.info, text: text, time: time,autoClear: autoClear)
    }
    
    //wait 不自动消失
    func showNoticeWait() {
        D3Notice.wait(D3Notice.longTime,autoClear: false)
    }
    
    func showNoticeWaitAuto(time:NSTimeInterval){
        D3Notice.wait(time,autoClear: true)
    }
    
    //text
    func showNoticeText(text: String) {
        D3Notice.showText(text,time:D3Notice.longTime,autoClear:true)
    }
    
    func showNoticeText(text: String,time:NSTimeInterval,autoClear:Bool) {
        D3Notice.showText(text,time:time,autoClear:true)
    }
    
    //clear
    func clearAllNotice() {
        D3Notice.clear()
    }
    
    //clear wait
    func clearWaitNotice(){
        D3Notice.clearWait()
    }
}

enum NoticeType{
    case success
    case error
    case info
}

class D3Notice: NSObject {
    private static var imageOfCheckmark: UIImage?
    private static var imageOfCross: UIImage?
    private static var imageOfInfo: UIImage?
    private static let waitTag = 98
    static let longTime:NSTimeInterval = 2
    static let shortTime:NSTimeInterval = 1
    static var notices = Array<UIView>()
    static let rv = UIApplication.sharedApplication().keyWindow?.subviews.first as! UIView
    static var window:UIWindow = UIApplication.sharedApplication().keyWindow!
    
    static func clear() {
        for i in notices {
            i.removeFromSuperview()
        }
    }
    
    static func clearWait(){
        for i in notices {
            if i.tag == waitTag{
                i.removeFromSuperview()
            }
        }
    }
    
    //菊花图
    static func wait(time:NSTimeInterval?,autoClear: Bool) {
        clear()
        let frame = CGRectMake(0, 0, 78, 78)
        let mainView = UIView(frame: frame)
        mainView.layer.cornerRadius = 12
        mainView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.8)
        
        let ai = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        ai.frame = CGRectMake(21, 21, 36, 36)
        ai.startAnimating()
        mainView.addSubview(ai)
        
        mainView.center = rv.center
        window.addSubview(mainView)
        notices.append(mainView)
        
        time == nil ? longTime : time
        if autoClear {
            NSTimer.scheduledTimerWithTimeInterval(time!, target: self, selector: "hideNotice:", userInfo: mainView, repeats: false)
        }
    }
    
    //仅文字
    static func showText(text: String,time:NSTimeInterval,autoClear: Bool) {
        clear()
        let mainView = UIView()
        mainView.layer.cornerRadius = 12
        mainView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.8)
        
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.font = UIFont.systemFontOfSize(13)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.sizeToFit()
        mainView.addSubview(label)
        mainView.frame = CGRectMake(0, 0, label.frame.width + 50 , label.frame.height + 30)
    
        mainView.center = rv.center
        label.center = CGPointMake(mainView.frame.width/2, mainView.frame.height/2)
        
        window.addSubview(mainView)
        notices.append(mainView)
        
        if autoClear {
            NSTimer.scheduledTimerWithTimeInterval(time, target: self, selector: "hideNotice:", userInfo: mainView, repeats: false)
        }
    }
    
    //有勾、叉和警告
    static func showNoticeWithText(type: NoticeType,text: String,time:NSTimeInterval,autoClear: Bool) {
        clear()
        let frame = CGRectMake(0, 0, 90, 90)
        let mainView = UIView(frame: frame)
        mainView.layer.cornerRadius = 10
        mainView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.7)
        
        var image = UIImage()
        switch type {
        case .success:
            image = drawCacheImg(imageOfCheckmark,type: NoticeType.success)
        case .error:
            image = drawCacheImg(imageOfCross,type: NoticeType.error)
        case .info:
            image = drawCacheImg(imageOfInfo,type: NoticeType.info)
        default:
            break
        }
        let checkmarkView = UIImageView(image: image)
        checkmarkView.frame = CGRectMake(27, 15, 36, 36)
        mainView.addSubview(checkmarkView)
        
        let label = UILabel(frame: CGRectMake(0, 60, 90, 16))
        label.font = UIFont.systemFontOfSize(13)
        label.textColor = UIColor.whiteColor()
        label.text = text
        label.textAlignment = NSTextAlignment.Center
        mainView.addSubview(label)
        
        mainView.center = rv.center
        window.addSubview(mainView)
        notices.append(mainView)
        
        if autoClear {
            NSTimer.scheduledTimerWithTimeInterval(time, target: self, selector: "hideNotice:", userInfo: mainView, repeats: false)
        }
    }
    
    static func hideNotice(sender: NSTimer) {
        if sender.userInfo is UIView {
            sender.userInfo!.removeFromSuperview()
        }
    }
    
    //下面是画图的
    class func draw(type: NoticeType) {
        var checkmarkShapePath = UIBezierPath()
        // 先画个圈圈
        checkmarkShapePath.moveToPoint(CGPointMake(36, 18))
        checkmarkShapePath.addArcWithCenter(CGPointMake(18, 18), radius: 17.5, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
        checkmarkShapePath.closePath()
        
        switch type {
        case .success: // 画勾
            checkmarkShapePath.moveToPoint(CGPointMake(10, 18))
            checkmarkShapePath.addLineToPoint(CGPointMake(16, 24))
            checkmarkShapePath.addLineToPoint(CGPointMake(27, 13))
            checkmarkShapePath.moveToPoint(CGPointMake(10, 18))
            checkmarkShapePath.closePath()
        case .error: // 画叉
            checkmarkShapePath.moveToPoint(CGPointMake(10, 10))
            checkmarkShapePath.addLineToPoint(CGPointMake(26, 26))
            checkmarkShapePath.moveToPoint(CGPointMake(10, 26))
            checkmarkShapePath.addLineToPoint(CGPointMake(26, 10))
            checkmarkShapePath.moveToPoint(CGPointMake(10, 10))
            checkmarkShapePath.closePath()
        case .info:  //画警告
            checkmarkShapePath.moveToPoint(CGPointMake(18, 6))
            checkmarkShapePath.addLineToPoint(CGPointMake(18, 22))
            checkmarkShapePath.moveToPoint(CGPointMake(18, 6))
            checkmarkShapePath.closePath()
            
            UIColor.whiteColor().setStroke()
            checkmarkShapePath.stroke()
            
            var checkmarkShapePath = UIBezierPath()
            checkmarkShapePath.moveToPoint(CGPointMake(18, 27))
            checkmarkShapePath.addArcWithCenter(CGPointMake(18, 27), radius: 1, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
            checkmarkShapePath.closePath()
            
            UIColor.whiteColor().setFill()
            checkmarkShapePath.fill()
            
        default:
            break
        }
        
        UIColor.whiteColor().setStroke()
        checkmarkShapePath.stroke()
    }
    
    
    class func drawCacheImg(cacheImg: UIImage?,type:NoticeType)->UIImage{
        if (cacheImg != nil) {
            return cacheImg!
        }
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(36, 36), false, 0)
        draw(type)
        
        switch type{
        case .success:
            imageOfCheckmark = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return imageOfCheckmark!
            
        case .error:
            imageOfCross = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return imageOfCross!
            
        case .info:
            imageOfInfo = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return imageOfInfo!
            
        default:
            break
        }
    }

}

