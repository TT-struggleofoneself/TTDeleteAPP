//
//  ViewController.m
//  TTDeleteAPP
//
//  Created by TT_code on 16/4/18.
//  Copyright © 2016年 TT_code. All rights reserved.
//
#import "CloseAppView.h"
#import "ViewController.h"

@interface ViewController ()<CloseAppViewDelegate>
{
    NSMutableArray* _array;//可变数组
    int k;
    BOOL isfirst;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    k=0;
    if(!_array)
    {
        _array=[NSMutableArray array];
    }
    isfirst=NO;
    [self UpdateUI];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(Stop:)];
    
}


/**
 *  布局
 */
-(void)UpdateUI
{
    CGFloat height=100;
    CGFloat width=100;
    CGFloat widths=width+20;
    CGFloat heights=height+20;
    for (int i=0; i<9; i++){
        CloseAppView* view=[[CloseAppView alloc]initWithFrame:CGRectMake(10+widths*(i%3), 80+heights*(int)(i/3), width, height)];
        view.tag=i;
        view.delegates=self;
        
        [self.view addSubview:view];
        [_array addObject:view];
    }
}

/**
 *  计算APP 的位置
 */
-(void)ReInitView
{
    [UIView animateWithDuration:0.6 animations:^{
        CGFloat height=100;
        CGFloat width=100;
        CGFloat widths=width+20;
        CGFloat heights=height+20;
        for (int i=0; i<_array.count; i++)
        {
            CloseAppView* view=(CloseAppView*)_array[i];
            view.frame=CGRectMake(10+widths*(i%3), 80+heights*(int)(i/3), width, height);
            view.tag=i;
        }
    }];
}


/**
 *  设置所有的APP 都进入编辑状态（左右摆动）
 *
 *  @return
 */
-(void)AllCanRemove
{
    for (CloseAppView* view in _array)
    {
        [view  Startanimation];
    }
}


/**
 *  设置所有的APP  关闭编辑状态（不左右摆动）
 */
-(void)Allresume
{
    for (CloseAppView* view in _array)
    {
        [view  ResumuAnimation];
    }
}

/**
 *  代理 -----监听长按
 *
 *  @return
 */
#pragma mark-close  delegate
-(void)CloseAppView:(CloseAppView *)view longpress:(NSInteger)tag
{
    if(k==0){
        isfirst=YES;
    }else{
        isfirst=NO;
    }
    k++;
    if(isfirst){
        [self AllCanRemove];
        NSLog(@"我开始了");
    }else{
        NSLog(@"我暂停了");
        [self Allresume];
    }
}



/**
 *  监听---当删除的时候
 *
 *  @param view
 *  @param tag  
 */
-(void)CloseAppView:(CloseAppView *)view close:(NSInteger)tag
{
    
    [_array removeObjectAtIndex:tag];
    [view removeFromSuperview];
    [self ReInitView];
}





/**
 *  停止动画
 *
 *  @param sender
 */
-(void)Stop:(UIBarButtonItem*)sender
{
    for (CloseAppView* view in _array)
    {
        [view  StopAnimation];
    }
}




@end
