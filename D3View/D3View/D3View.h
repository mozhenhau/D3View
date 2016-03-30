//
//  D3View.h
//  D3View
//
//  Created by 莫振华 on 16/3/28.
//  Copyright © 2016年 mozhenhau. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULT_DURATION 0.25
typedef void(^CompletionBlock)();
@interface UIView(D3)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;
@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;


#pragma mark 动画基础
/**
 *  添加动画效果
 * 加入动画效果
 
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
-(void)d3_Animation:(NSString*)type subType:(NSString*)subType duration:(NSTimeInterval)duration;


-(void)d3_Animation:(NSTimeInterval)duration transition:(UIViewAnimationTransition)transition forView:(UIView*)view completion:(CompletionBlock)completion;

-(void)d3_removeAnimate;

-(CGFloat)degressToRadians:(CGFloat)angle;

/**
 *  设置x的位置，有动画效果
 *
 */
-(void)d3_setX:(CGFloat)x completion:(CompletionBlock)completion;

-(void)d3_setX:(CGFloat)x duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;


/**
 *  设置y的位置
 */
-(void)d3_setY:(CGFloat)y completion:(CompletionBlock)completion;

-(void)d3_setY:(CGFloat)y duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;

/**
 *  旋转角度
 *  @param angle      角度， 为-1的时候一直转.  0~180
 *
 */
-(void)d3_setRotate:(CGFloat)angle completion:(CompletionBlock)completion;

-(void)d3_setRotate:(CGFloat)angle duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;


/**
 *  设置point
 *
 */
-(void)d3_setPoint:(CGPoint)point completion:(CompletionBlock)completion;

-(void)d3_setPoint:(CGPoint)point duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;


//在现在位置基础上移动
-(void)d3_moveX:(CGFloat)x completion:(CompletionBlock)completion;

-(void)d3_moveX:(CGFloat)x duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;


-(void)d3_moveY:(CGFloat)y completion:(CompletionBlock)completion;

-(void)d3_moveY:(CGFloat)y duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;

#pragma 以下是动画
/**
 *  左右摇动
 */
-(void)d3_shake:(CGFloat)range duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)d3_shake;


/**
 *  上下摇动
 */
-(void)d3_bounce:(CGFloat)range duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)d3_bounce;


/**
 *  心跳
 */
-(void)d3_heartbeat:(CGFloat)range duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)d3_heartbeat;


/**
 *  摇摆
 */
-(void)d3_swing:(CGFloat)range duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)d3_swing;


/**
 *  整体放大缩小
 */
-(void)d3_scale:(CGFloat)scale duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;


-(void)d3_scale:(CGFloat)scale;


-(void)d3_scaleX:(CGFloat)scale duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;


-(void)d3_scaleX:(CGFloat)scale;


-(void)d3_scaleY:(CGFloat)scale duration:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)d3_scaleY:(CGFloat)scale;


/**
 *  掉落
 */
-(void)d3_drop:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)d3_drop;



/**
 *  翻转
 */
-(void)d3_flip:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)d3_flip;



/**
 *  翻页
 */
-(void)d3_pageing:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)d3_pageing;


/**
 *  闪亮，呼吸灯
 */
-(void)d3_blink:(NSTimeInterval)duration;


-(void)d3_blink;


/**
 *  渐隐
 */
-(void)d3_fadeOut:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)d3_fadeOut;

/**
 *  渐现
 */
-(void)d3_fadeIn:(NSTimeInterval)duration completion:(CompletionBlock)completion;

-(void)d3_fadeIn;

@end
