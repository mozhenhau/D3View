
#D3View
##简介
一句代码轻松实现IOS常用动画效果的超轻量库，旨在实现一些简单的动画效果基础  
有swift和oc的版本。需要什么版本自己拖到项目，两者只需其中一个  
Swift只需要拖D3View.swift到项目，Objective-c需要D3View.h和D3View.m到项目,都是UIView扩展类  
  
有希望实现的动画效果可以提issue，本人有空可以尝试实现 0.0  
也希望有朋友可以贡献实现一些动画效果。 右上角给个star呗亲~


##使用
因为是扩展，所以只要是uiview的子类都可以使用。 动画都是以`d3`_开头的方法，避免扩展冲突  
 
要实现左右摇，只需一句代码:

    view.d3_shake()  

噢耶，得咗  
其他动画效果参照代码,在ViewController有使用例子  
  
![此处输入图片的描述][1]

##安装使用(swift)
###使用CocoaPods (iOS 8+, OS X 10.9+)

pod 'D3View', '~> 1.2.0'
swift调用framework需要import D3View

###普通使用
拖动D3View目录到你的项目，只需拖动D3View.swift文件  
OC的只需拖动D3View.h和m文件


  [1]: http://7vzpd0.com1.z0.glb.clouddn.com/mo112.gif
