//
//  CloseAppView.m
//  aaaaaaaaaaaaaaaa
//
//  Created by admin on 15/5/31.
//  Copyright (c) 2015年 mobisoft. All rights reserved.
//

#import "CloseAppView.h"
@interface CloseAppView()
{
    UIButton* _closebutton;
    UIView* view;
    CAKeyframeAnimation* keyanimation;
    CGRect oldfram;
    
}

@end
@implementation CloseAppView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        view=[[UIView alloc]initWithFrame:CGRectMake(10, 10, self.bounds.size.width-20, self.bounds.size.height-20)];
         view.backgroundColor=[UIColor redColor];
        [self addSubview:view];
        oldfram=self.frame;
       
        self.longpress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongPress:)];
        [self addGestureRecognizer:self.longpress];
        self.isfirst=YES;
        _closebutton=[[UIButton alloc]initWithFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, 20,20)];
        _closebutton.center=CGPointMake(view.frame.origin.x, view.frame.origin.y);
        _closebutton.backgroundColor=[UIColor greenColor];
        [_closebutton addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        _closebutton.hidden=YES;
      //  [_closebutton setTitle:@"X" forState:UIControlStateNormal];
        [_closebutton setImage:[UIImage imageNamed:@"ico_del"] forState:UIControlStateNormal];
        [self laysetCornerRadius:_closebutton andRadius:10 andcolor:[UIColor greenColor]];
        
        [self addSubview:_closebutton];
    }
    return self;
}



-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}


#pragma mark-开始动画
-(void)Startanimation
{
    _closebutton.hidden=NO;
   if(!keyanimation)
   {
        keyanimation=[CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
        CGFloat angel=M_1_PI/10;
        keyanimation.values=@[@(angel),@(-angel),@(angel)];
        keyanimation.repeatCount=HUGE_VALF;
        keyanimation.removedOnCompletion=YES;
        [keyanimation beginTime];
        keyanimation.delegate=self;
        [self.layer addAnimation:keyanimation forKey:@"keypathrotarion"];
   }
    
}


-(void)LongPress:(UILongPressGestureRecognizer*)recognizer
{//transform.rotation
    NSLog(@"我执行了多少次啊");
    if(recognizer.state==UIGestureRecognizerStateBegan)
    {
        if([self.delegates respondsToSelector:@selector(CloseAppView:longpress:)])
        {
            [self.delegates CloseAppView:self longpress:self.tag];
        }
    }
    else if(recognizer.state==UIGestureRecognizerStateEnded)
    {
         self.isfirst=NO;
    }
}

-(void)ResumuAnimation
{
    [self resumeLayer:self.layer];
}



-(void)Click:(UIButton*)sender
{
    [self.layer removeAllAnimations];
     
   
    
    if([self.delegates respondsToSelector:@selector(CloseAppView:close:)])
    {
         [self.delegates CloseAppView:self close:self.tag];
    }
    
}

//暂停动画
- (void)pauseLayer:(CALayer*)layer
{
    [layer setSpeed:0.0];
    // 1. 取出当前的动画的时间点，就是要暂停的时间点
    CFTimeInterval pauseTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    // 2. 设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点
    [layer setTimeOffset:pauseTime];
    // 3. 将动画的运行速度设置为0，动画默认的运行速度是1.0
    [layer setSpeed:0.03];
}



//继续layer上面的动画
- (void)resumeLayer:(CALayer*)layer
{
    _closebutton.hidden=NO;
    // 1. 将动画的时间偏移量作为暂停时的时间点
    CFTimeInterval pauseTime = layer.timeOffset;
    // 2. 根据媒体时间计算出准确的启动动画时间，对之前暂停动画的时间进行修正
    CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
    // 3. 要把偏移时间清零
    [layer setTimeOffset:0.0];
    // 4. 设置图层的开始动画时间
    [layer setBeginTime:0.0];
    [layer setSpeed:1.0];
    [keyanimation beginTime];
}


-(void)StopAnimation
{
    _closebutton.hidden=YES;
   
    [self pauseLayer:self.layer];

}


-(void)laysetCornerRadius:(UIView*)sender andRadius:(float)radius andcolor:(UIColor*)color
{
    [sender.layer setMasksToBounds:YES];
    [sender.layer setCornerRadius:radius];//设置矩形四个圆角半径
    sender.backgroundColor=color;
    
    UIButton* button=(UIButton*)sender;
    button.titleLabel.font=[UIFont systemFontOfSize:17];
}


#pragma mark- 设置视图圆角边
-(void)laysetCornerRadius:(UIView*)sender
{
    [sender.layer setMasksToBounds:YES];
    [sender.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    // sender.backgroundColor=[UIColor blueColor];
    UIButton* button=(UIButton*)sender;
    //  button.titleLabel.font=[UIFont systemFontOfSize:17];
}



@end
