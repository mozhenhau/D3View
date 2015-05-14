//
//  D3ViewController.swift
//  Neighborhood
//
//  Created by mozhenhau on 15/1/4.
//  Copyright (c) 2015年 Ray. All rights reserved.
//  使用基类管理常用类
//  更建议使用extension进行扩展,扩展不能实现的才使用基类
//
//  遵循原则--MVC,具体分层如下
//
//  Controller控制层，分两个控制管理:
//  1.UIViewController只实现：获取数据，初始化界面数据，点击事件，跳转
//  2.Adapter里面的View只实现自己的listview里面的代理，DataSource和Delegate（简单来说就是把UITableView和CollectionView的代理交给自己管理）
//
//  View视图层:
//  1.storyboard，xib等
//  2.或者实现基类的initView方法进行代码修改界面
//  ps:Cell功能更似Model层,但理论上应该属于View层，所以应该分在View层
//
//  Model层：
//  分为Model包下的实体类，Dao包下的数据获取类（包括网络数据存取，数据库数据存取）
//
//  一个正常流程: 
//  1.  ViewController初始化界面后，View层渲染 ->  
//  2.  用户在ViewController点击事件产生交互 ->  
//  3.  Model层Dao获取数据填充  ->
//  4.  Model数据发生变化，通知到ViewController -> 
//  5.  View层重新渲染（包括数据变化，页面跳转等）
//   V  -> C -> M -> C -> V

import UIKit

class D3ViewController: UIViewController {
    
    /**
    初始化界面的可以写在此处
    */
    func initView(){
    
    }
    
    /**
    初始化界面数据的可以写在此处
    */
    func initData(){
    
    }
    
    
    //MARK: 友盟统计
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        MobClick.beginLogPageView(self.title)
    }
    
    override func viewWillDisappear(animated: Bool){
        super.viewWillDisappear(animated)
//        MobClick.endLogPageView(self.title)
    }
    
    
    /**
    获取navigationController?.viewControllers上的某个vc。
    一般用于获取上级和下级的vc
    
    :param: clazz           你要获取的vc的类型
    
    :returns: 返回一个vc
    */
    func getViewController<T>(clazz:AnyClass)->T!{
        if self.navigationController == nil{
            return nil
        }
        
        for obj in self.navigationController!.viewControllers{
            if obj.isKindOfClass(clazz){
                return obj as! T
            }
        }
        return nil
    }
}
