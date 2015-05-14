//
//  D3Timer.swift
//  Neighborhood
//
//  Created by 陈经达 on 15/1/22.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

import UIKit

class D3Timer: NSObject {
    var stopBlock:(()->Void)?
    var runBlock:((second:Int)->Void)?
    
    var _timer:dispatch_source_t?
    
    func startTime(runSecond:Double)
    {
        var timeOut:Double = runSecond
        
        var queue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue)
        
        dispatch_source_set_timer(_timer!,dispatch_walltime(nil, 0),UInt64(1.0)*NSEC_PER_SEC, 0); //每秒执行
        
        
        dispatch_source_set_event_handler(_timer!, { () -> Void in

            if timeOut <= 0
            {
                dispatch_source_cancel(self._timer!)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.stopBlock!()
                    NSUserDefaults.standardUserDefaults().removeObjectForKey("timerTime")
                    NSUserDefaults.standardUserDefaults().synchronize()
                })
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.runBlock!(second: Int(timeOut))
                    
                })
                timeOut--
                
            }
        })
        dispatch_resume(_timer!)
    }
    
    func stopTimer()
    {
        dispatch_source_cancel(_timer!)
        _timer = nil
    }
    
}

