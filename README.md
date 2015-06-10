##简介
一句代码轻松实现IOS常用动画效果
如果只需要方便实现动画，只需要D3Venders类，这个类是扩展UIView类
另外一些类是常用ui控件的扩展，主要是应用在storyboard的方便。  
![此处输入图片的描述][1]


##动画使用
比如要实现左右摇:view.shake()
如果摇完有回调:view.shake("finish")
其他动画效果参照代码  
![此处输入图片的描述][2]

##其他扩展使用
1. 在Indentity inspector视图继承D3_  
![此处输入图片的描述][3]
2. 在Attributes inspector视图选择属性，如图是选择了isRound属性，则view变成圆形  
![此处输入图片的描述][4]
3. 运行得到结果   
![此处输入图片的描述][5]  
旨在不写代码前提下，利用storyboard做更多的事情


##安装使用
###使用CocoaPods (iOS 8+, OS X 10.9+)

pod 'D3View', '~> 0.0.3'
swift调用framework需要import D3View

###普通使用
拖动D3View目录到你的项目，只需要动画效果则只需拖动D3Venders.swift文件


  [1]: http://7vzpd0.com1.z0.glb.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202015-06-10%20%E4%B8%8B%E5%8D%886.01.08.png
  [2]: http://7vzpd0.com1.z0.glb.clouddn.com/11.gif
  [3]: http://7vzpd0.com1.z0.glb.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202015-06-10%20%E4%B8%8B%E5%8D%886.11.13.png
  [4]: http://7vzpd0.com1.z0.glb.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202015-06-10%20%E4%B8%8B%E5%8D%886.10.12.png
  [5]: http://7vzpd0.com1.z0.glb.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202015-06-10%20%E4%B8%8B%E5%8D%886.15.42.png
