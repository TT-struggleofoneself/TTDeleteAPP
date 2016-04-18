//
//  CloseAppView.h
//  aaaaaaaaaaaaaaaa
//
//  Created by admin on 15/5/31.
//  Copyright (c) 2015年 mobisoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CloseAppView;
@protocol CloseAppViewDelegate <NSObject>


@optional
-(void)CloseAppView:(CloseAppView*)view  close:(NSInteger)tag;
-(void)CloseAppView:(CloseAppView*)view  longpress:(NSInteger)tag;

-(void)CloseAppView:(CloseAppView*)view  stop:(NSInteger)tag;

@end


@interface CloseAppView : UIView

@property(nonatomic,strong)UILongPressGestureRecognizer* longpress;
@property(nonatomic,weak)id<CloseAppViewDelegate>delegates;
@property(nonatomic)BOOL isfirst;//是否是第一次执行动画


-(void)StopAnimation;//停止动画


-(void)Startanimation;//开始动画


-(void)ResumuAnimation;//恢复动画

@end

