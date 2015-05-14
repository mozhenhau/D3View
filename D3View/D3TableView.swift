//
//  D3TableView.swift
//  Neighborhood
//
//  Created by mozhenhau on 14/11/13.
//  Copyright (c) 2014年 Ray. All rights reserved.
//  此类需结合PullRefresh
//  initRefesh后即可刷新和加载，不要加载的话init前把isShowFooter设为false，主动刷新self.headerBeginRefreshing
//  需要加载后有额外操作则调用addSucBlock，addCompleteBlock
//

import UIKit

class D3TableView: UITableView {
    var arr:Array<AnyObject> = []
    var isShowFooter:Bool = true //有没有加载更多
    //无数据
    var isShowNoView:Bool = true  //没有数据时是否显示“无数据界面”
    var noText:String?      //没有数据时显示的文字,默认为“暂无数据”
    var noImgName:String?   //没有数据时显示的图片，默认为“default.png”
    var isShowImg:Bool = true    //为false没有数据也不显示图
    
    var cateId:Int?
    var text:String?
    private var suc:(AnyObject?->Void)?
    private var complete:(Void->Void)?
    private var clazz:AnyClass?
    private var loadMethod:Any?
    private var type:RefreshType = RefreshType.refresh
    private var isInitRefresh:Bool = false
    var parms:Array<Int>?  //这个是getGoodsByCate的特例。。。其他情况用不到.传scId，order_type,order三个参数
    
    enum RefreshType{
        case refresh
        case more
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /**
    基础方法，只需要传入转化对象类型和加载方法
    :param: clazz      转化对象类型class
    :param: loadMethod 加载方法
    */
    func initRefresh(clazz:AnyClass?,loadMethod:Any?){
        self.clazz = clazz
        self.loadMethod = loadMethod
        setupRefresh()
    }
    
    /**
    传入ID，此方法用于单参数传入。 比如：是商品分类，则传入商品分类。是小区圈的分类则传入小区圈分类
    :param: cateId     分类ID
    :param: clazz      转化对象类型class
    :param: loadMethod 加载方法
    
    */
    func initRefreshWithId(cateId:Int,clazz:AnyClass,loadMethod:Any?){
        self.cateId = cateId
        self.initRefresh(clazz,loadMethod:loadMethod)
    }

    
    //下拉上拉刷新列表
    private func setupRefresh(){
        if !isInitRefresh{
            self.addHeaderWithCallback({
                dispatch_async( dispatch_get_main_queue(), {
                    self.loadData(RefreshType.refresh)
                })
            })
            
            if isShowFooter{
                self.addFooterWithCallback({
                    dispatch_async( dispatch_get_main_queue(), {
                        self.loadData(RefreshType.more)
                    })
                })
            }
            isInitRefresh = true
        }
    }
    
    //获取列表
    private func loadData(type:RefreshType){   //offset为0代表是更新，不为0则是加载更多
        var page:Int = 0
        if type != RefreshType.refresh{
            page = self.arr.count
        }
        
        //FIXME:if have better idea,change this
        if let load = loadMethod as? ((((Int,AnyObject?)->Void),(Int->Void))->Void){
            //无参
            load({(statusCode,data) in
                self.suc(type, data: data)
                },
                {(statusCode) in
                    self.complete(type)
            })
        }
        else if loadMethod is ((String,((Int,AnyObject?)->Void),(Int->Void))->Void) && text != nil{
            let load = loadMethod as? ((String,((Int,AnyObject?)->Void),(Int->Void))->Void)
            //有parm,text
            load?(text!,{(statusCode,data) in
                self.suc(type, data: data)
                },
                {(statusCode) in
                    self.complete(type)
            })
        }
        else if loadMethod is ((Int,((Int,AnyObject?)->Void),(Int->Void))->Void) && cateId != nil{
            let load = loadMethod as? ((Int,((Int,AnyObject?)->Void),(Int->Void))->Void)
            //有parm
            load?(cateId!,{(statusCode,data) in
                self.suc(type, data: data)
                },
                {(statusCode) in
                    self.complete(type)
            })
        }
        else if let load = loadMethod as? ((Int,((Int,AnyObject?)->Void),(Int->Void))->Void){
            //有offset
            load(page,{(statusCode,data) in
                self.suc(type, data: data)
            },
            {(statusCode) in
                self.complete(type)
            })
        }
        else if let load = loadMethod as? ((Int,Int,((Int,AnyObject?)->Void),(Int->Void))->Void){
            //有offset，parm，第一个要是parm，第二个是offset
            load(cateId!,page,{(statusCode,data) in
                self.suc(type, data: data)
            },
            {(statusCode) in
                self.complete(type)
            })
        }
        else if let load = loadMethod as? ((Int,Int,Int,Int,((Int,AnyObject?)->Void),(Int->Void))->Void){
            //这个是getGoodsByCate的特例，有scId，order_type,order,offset
            if parms != nil && parms?.count == 3{
                load(parms![0],parms![1],parms![2],page,{(statusCode,data) in
                    self.suc(type, data: data)
                },
                {(statusCode) in
                    self.complete(type)
                })
            }
            else{
                println("参数不对啊亲")
            }
        }
        else{
            println("没有这个加载方法类型啊")
        }
    }
    
    //获取数据成功后操作
    private func suc(type:RefreshType,data:AnyObject?){
        if type == RefreshType.refresh{  //刷新，先清空
            self.arr = []
        }
        //TODO
        if data != nil{
//            self.arr += self.clazz!.objectArrayWithKeyValuesArray(data)
        }
        
        if self.suc != nil{   //如果额外有操作的suc不为空,写在suc
            self.suc!(data)
        }
    }
    
    
    //获取数据完成后操作
    private func complete(type:RefreshType){
        self.headerEndRefreshing()
        self.footerEndRefreshing()
        
        if self.complete != nil{
            self.complete!()
        }
        
        self.reloadData()
        if arr.count == 0 && isShowNoView{   //没有数据显示label
            showNothingView()
        }
        else{    //有数据，移除label
            for view in self.subviews{
                if let nothingView:UIView = view as? UIView{
                    if nothingView.tag == 499{
                        nothingView.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    func showNothingView()
    {
        var nothingView:UIView = UIView(frame: CGRectMake(0, 0, frame.width, frame.height))
        nothingView.tag = 499
        nothingView.backgroundColor = UIColor.whiteColor()
        
        //add label
        var label:UILabel = UILabel()
        label.text = noText==nil ? "暂无数据":noText
        label.textColor = UIColor.lightGrayColor()
        label.numberOfLines = 2
        label.sizeToFit()
        label.center = CGPointMake(nothingView.frame.width/2, nothingView.frame.height/2.5)
        nothingView.addSubview(label)
        
        //add img
        var img:UIImageView = UIImageView()
        if noImgName != nil{
            img.image = UIImage(named: noImgName!)
        }
        else if isShowImg{
            img.image = UIImage(named: "default.png")
        }
        
        img.sizeToFit()
        img.center = CGPointMake(nothingView.frame.width/2, nothingView.frame.height/2.5-img.bounds.height/2 - 30)
        nothingView.addSubview(img)
        
        self.addSubview(nothingView)
    }
    
    /**
    加载数据成功后的额外操作.sucBlock发生在completeBlock,reloadData之前
    :param: suc 成功操作
    */
    func addSucBlock(suc:(AnyObject?->Void)){
        self.suc = suc
    }
    
    /**
    加载完成后的额外操作,completeBlock发生在reloadData之前
    :param: complete 完成操作
    */
    func addCompleteBlock(complete:(Void->Void)){
        self.complete = complete
    }
    
    /**
    :returns: 返回当前arr的数量
    */
    var count:Int{
        return arr.count
    }
}
