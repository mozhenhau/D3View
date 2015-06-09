//
//  ViewController.swift
//  D3View
//
//  Created by mozhenhau on 15/5/31.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var d3view: UIView!
    var exFrame:CGRect!
    var view1 :UIView!
    
    var dataSource = ["重置","左右摇","上下摇","心跳","摇摆","缩小","放大","掉落","翻转","翻页","渐变","推出","覆盖","揭开","3D立方","抽走","滴水"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
        exFrame = d3view.frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataSource.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell  = tableView.dequeueReusableCellWithIdentifier("clickCell") as! UITableViewCell
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        d3view.zoomin(1.0)
        d3view.frame = exFrame
        d3view.backgroundColor = UIColor.yellowColor()
        switch indexPath.row{
            case 0:
                d3view.zoomin(1.0)
                d3view.frame = exFrame
                d3view.backgroundColor = UIColor.yellowColor()
            
            case 1:
                d3view.shake()
            
            case 2:
                d3view.bounce()
            
            case 3:
                d3view.pulse()
                
            case 4:
                d3view.swing()
                
            case 5:
                d3view.compress()
            
            case 6:
                d3view.zoomin(2.0)
            
            case 7:
                d3view.hinge()
            
            case 8:
                d3view.flip()
                
            case 9:
                d3view.pageing()
                
            case 10:  //后面的效果自己尝试，换参数而已
                d3view.addAnimation(kCATransitionFade, subType: nil, duration: 1.0)
                d3view.backgroundColor = UIColor.blackColor()
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
            
        case 11:
            d3view.addAnimation(kCATransitionPush, subType: kCATransitionFromRight, duration: 1.0)
            d3view.backgroundColor = UIColor.blackColor()
            
        case 12:
            d3view.addAnimation(kCATransitionMoveIn, subType: kCATransitionFromRight, duration: 1.0)
            d3view.backgroundColor = UIColor.blackColor()
            
        case 13:
            d3view.addAnimation(kCATransitionReveal, subType: kCATransitionFromRight, duration: 1.0)
            d3view.backgroundColor = UIColor.blackColor()

        case 14:
            d3view.addAnimation("cube", subType: kCATransitionFromRight, duration: 1.0)
            
        case 15:
            d3view.addAnimation("suckEffect", subType: kCATransitionFromRight, duration: 1.0)
            
        case 16:
            d3view.addAnimation("rippleEffect", subType: kCATransitionFromRight, duration: 1.0)
            d3view.backgroundColor = UIColor.blackColor()
            
            default:
            break
        }
    }

}

