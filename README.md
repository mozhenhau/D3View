#D3View
##简介
一句代码轻松实现IOS常用动画效果
如果只需要方便实现动画，只需要D3Venders类，这个类是扩展UIView类
另外一些类是常用ui控件的扩展，主要是应用在storyboard的方便。  
![此处输入图片的描述][1]

##使用
##1.动画使用--只需要D3Venders
比如要实现左右摇:view.shake()  
如果摇完有回调:view.shake("finish")  
其他动画效果参照代码  
![此处输入图片的描述][2]

##2.D3Notice弹窗使用--只需要D3Notice
D3Notice是用swift写的IOS的自定义AlertView。包括纯文字提示，成功、失败、警告和菊花图。是扩展UIViewController的实现。  
![此处输入图片的描述][3]

###在UIViewController使用
对应上图的功能，直接在UIViewController里使用

    clearAllNotice()

    showNoticeSuc("suc")

    showNoticeSuc("suc", time: D3Notice.longTime, autoClear: false)

    showNoticeErr("err")

    showNoticeInfo("info")

    showNoticeWait()

    showNoticeText("text")
    
###不在UIViewController使用
如果不是在UIViewController,使用方法：

     D3Notice.showNoticeWithText(NoticeType.success, text: "suc",time: D3Notice.longTime, autoClear: true)
    

##3.其他D3扩展使用--使用方法大概参考以下
1. 在Indentity inspector视图继承D3_  
![此处输入图片的描述][4]
2. 在Attributes inspector视图选择属性，如图是选择了isRound属性，则view变成圆形  
![此处输入图片的描述][5]
3. 运行得到结果   
![此处输入图片的描述][6]  
旨在不写代码前提下，利用storyboard做更多的事情

##4.一些封装的控件
使用方法参考MoreViewController.swift
![此处输入图片的描述][7]

##安装使用
###使用CocoaPods (iOS 8+, OS X 10.9+)

pod 'D3View', '~> 1.0.0'
swift调用framework需要import D3View

###普通使用
拖动D3View目录到你的项目，只需要动画效果则只需拖动D3Venders.swift文件


  [1]: http://7vzpd0.com1.z0.glb.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202015-06-10%20%E4%B8%8B%E5%8D%886.01.08.png
  [2]: http://7vzpd0.com1.z0.glb.clouddn.com/11.gif
  [3]: http://7vzpd0.com1.z0.glb.clouddn.com/111.gif
  [4]: http://7vzpd0.com1.z0.glb.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202015-06-10%20%E4%B8%8B%E5%8D%886.11.13.png
  [5]: http://7vzpd0.com1.z0.glb.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202015-06-10%20%E4%B8%8B%E5%8D%886.10.12.png
  [6]: http://7vzpd0.com1.z0.glb.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202015-06-10%20%E4%B8%8B%E5%8D%886.15.42.png
  [7]: http://7vzpd0.com1.z0.glb.clouddn.com/more.gif
