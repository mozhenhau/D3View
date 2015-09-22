//
//  D3ScrollView.swift
//  Neighborhood
//
//  Created by mozhenhau on 15-6-08.
//  Copyright (c) 2014 mozhenhau. All rights reserved.
//  滚动图
//  使用方法：initScrollView，   修改样式用initStyle

import UIKit

enum ScrollViewStyle{
    case all
    case noLabel
    case noBar
}

class D3ScrollView: UIView ,UIScrollViewDelegate{
    var d3ImgView : UIImageView!                //显示的第一张图
    private var d3ScrollView : UIScrollView!    //scroll
    private var d3PageControl : UIPageControl!   //下方的圆点
    private var d3Label : UILabel!              //下方的标题
    private var d3MaskView : UIView!            //下方的蒙版
    
    private var myTimer:NSTimer?
    var imgArr:Array<String> = []         //图片数组
    var labelArr:Array<String> = []       //标题数组
    var currentPage:Int = 0              //滚到哪一页，当前页
    private var style:ScrollViewStyle = ScrollViewStyle.all
    var local:Bool = false //是不是用本地图
    
    
    override func layoutSubviews() {
        //调整各部件位置大小
        d3ImgView.frame = CGRectMake(0,0,self.frame.width,self.frame.height)
        d3ScrollView.frame = CGRectMake(0,0,self.frame.width,self.frame.height)
        d3Label.frame = CGRectMake(10,self.frame.height-30,self.frame.width-100,30)
        d3PageControl.frame = CGRectMake(0,self.frame.height-30,100,30)
        d3PageControl.center.x = self.frame.width/2
        d3MaskView.frame = CGRectMake(0,self.frame.height-30,self.frame.width,30)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
        //默认样式
        d3ImgView = UIImageView(image: UIImage(named:""))
        self.contentMode = UIViewContentMode.ScaleAspectFit
        self.clipsToBounds = true
        
        d3ScrollView = UIScrollView()
        d3ScrollView.pagingEnabled = true
        d3ScrollView!.delegate = self
        d3ScrollView.scrollEnabled = true

        d3Label = UILabel()
        d3Label.font = UIFont.systemFontOfSize(14)
        d3Label.textColor = UIColor.whiteColor()
        
        d3PageControl = UIPageControl()
        d3MaskView = UIView()
        d3MaskView.backgroundColor = UIColor(red: 0.0 , green: 0.0, blue: 0.0, alpha: 0.6)
        addSubview(d3ImgView)
        addSubview(d3ScrollView)
        addSubview(d3MaskView)
        addSubview(d3Label)
        addSubview(d3PageControl)
    }
    
    func initScrollView(imgs:Array<String>?,labels:Array<String>?,style:ScrollViewStyle)
    {
        self.imgArr = imgs!
        self.labelArr = labels!
        initStyle(style)
        
        if myTimer != nil
        {
            myTimer?.invalidate()
            myTimer = nil
        }
        //imgView 首先显示第一张图
        if imgArr.count > 0{
            getImg(d3ImgView, img: imgArr[0])
        }
        if labelArr.count > 0{
            d3Label.text = labelArr[0]
        }
        
        //只有一张图就可以结束了，不用划动
        if imgArr.count <= 1
        {
            d3PageControl!.numberOfPages = 0
        }
        else{
            //scrollView 可移动范围3个宽度
            d3ScrollView!.contentSize = CGSizeMake(self.frame.size.width * 3,self.frame.size.height)
            
            //scrollView 第二个宽度居中
            d3ScrollView!.contentOffset = CGPointMake(self.frame.size.width, 0)
            
            //pagecontrol 有多少张图就多少个点
            d3PageControl!.numberOfPages = imgArr.count
            d3PageControl!.pageIndicatorTintColor = UIColor.lightGrayColor()
            d3PageControl!.currentPageIndicatorTintColor = UIColor(red: 153/255, green: 201/255, blue: 47/255, alpha: 1)
            myTimer = NSTimer.scheduledTimerWithTimeInterval(5, target:self, selector:"autoSlide", userInfo:nil, repeats:true)
        }
    }
    
    func initStyle(style:ScrollViewStyle){
        self.style = style
        switch(style){
        case .noLabel:
            d3Label.hidden = true
        case .noBar:
            d3MaskView.hidden = true
            d3Label.hidden = true
        default:
            break
        }
    }
    
    
    func start()
    {
        if myTimer != nil
        {
            myTimer!.fireDate = NSDate().dateByAddingTimeInterval(5)
        }
    }
    
    func stop()
    {
        if myTimer != nil
        {
            myTimer!.fireDate = NSDate.distantFuture() 
        }
    }
    
    //scrollView 开始手动滚动调用的方法
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.stop()
        
        d3ImgView.image = nil
        
        //总页数
        let totalPage:Int = imgArr.count
        
        //当前图片如果是第一张，则左边图片为最后一张,否则为上一张
        let imgView1:String = imgArr[(currentPage == 0 ? (totalPage - 1) : (currentPage - 1))]
        
        //当前图片
        let imgView2:String = imgArr[currentPage]
        
        //当前图片如果是最后一张，则右边图片为第一张,否则为下一张
        let imgView3:String = imgArr[(currentPage == (totalPage - 1) ? 0 : (currentPage + 1))]
        
        var scrollImgArr:Array<String> = [imgView1,imgView2,imgView3]
        
        for i:Int in 0..<3
        {
            let imgView:UIImageView = UIImageView()
            imgView.frame = CGRectMake(CGFloat(i)*self.frame.size.width,0,self.frame.size.width,self.frame.size.height)
            getImg(imgView, img: scrollImgArr[i])
            
            d3ScrollView!.addSubview(imgView)
        }
    }
    

    
    //scrollView 手动滚动停止调用的方法
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        turnPage()
        self.start()
    }
    
    //scrollView 开始自动滚动调用的方法
    func autoSlide()
    {
        scrollViewWillBeginDragging(d3ScrollView)
        //代码模拟 用手向右拉了一个 scrollView 的宽度
        d3ScrollView!.setContentOffset(CGPointMake(d3ScrollView!.frame.size.width*2,0),animated: true)
    }
    
    //scrollView 自动滚动停止调用的方法
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView)
    {
        turnPage()
        self.start()
    }
    
    //换页时候调用的方法
    func turnPage()
    {
        let totalPage:Int = imgArr.count
        
        //如果 scrollView 的 x 坐标大于320，即已经向右换一页
        //并且判断当前页是否最后一页，如果是则下一页为第一张图
        if d3ScrollView!.contentOffset.x > d3ScrollView!.frame.size.width
        {
            currentPage = (currentPage < (totalPage - 1) ? (currentPage + 1) : 0)
        }
        else if d3ScrollView!.contentOffset.x < d3ScrollView!.frame.size.width
        {
            currentPage = (currentPage > 0 ? (currentPage - 1) : (totalPage - 1))
        }
        
        //换页后mainImgView 显示改图片，并且显示该页标题
        let img:String = imgArr[currentPage]
        getImg(d3ImgView, img: img)
        
        if !d3Label.hidden{
            d3Label.text = labelArr[currentPage]
        }
        d3PageControl!.currentPage = currentPage
        
        //把临时加进去的 imgView 从 scrollView 删除，释放内存
        for imgView:AnyObject in d3ScrollView!.subviews
        {
            if imgView is UIImageView
            {
                (imgView as! UIImageView).removeFromSuperview()
            }
        }
        //scrollView重新摆回第二个页面在中间状态
        d3ScrollView!.contentOffset = CGPointMake(d3ScrollView!.frame.size.width,0)
    }
    
    
    private func getImg(imgView:UIImageView,img:String){
        if !local{
            //TODO: 自行替换加载图的方式
            imgView.image = UIImage(data: NSData(contentsOfURL: NSURL(string:img)!)!)
//            imgView.loadImage(img)
            imgView.contentMode = UIViewContentMode.ScaleAspectFit
            imgView.clipsToBounds = true
        }
        else{
            imgView.image = UIImage(named:img)
        }
    }
    
}