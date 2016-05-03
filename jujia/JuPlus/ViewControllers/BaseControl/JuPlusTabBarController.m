//
//  JuPlusTabBarController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusTabBarController.h"
#import "JuPlusEnvironmentConfig.h"
@implementation JuPlusTabBarController
-(void)viewDidLoad
{
    [super viewDidLoad];
    //(1)移除工具栏上的按钮
    //取得tabbar上的所有子视图
    NSArray *views = [self.tabBar subviews];
    for (UIView *view in views) {
        
        [view removeFromSuperview];
    }
    //self.tabBar.backgroundImage = [UIImage imageNamed:@"navbg"];
    //(3)创建按钮
    CGFloat width = SCREEN_WIDTH;
    //每一个按钮的宽度
    CGFloat w = width/4;
    for (int i=0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *imageName = [NSString stringWithFormat:@"icons_%d",i+2];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
        //设置frame
        button.frame = CGRectMake((w-42)/2+w*i, 2, 42, 45);
        //添加一个点击事件
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:button];
    }
}
//按钮的点击事件

- (void)buttonAction:(UIButton *)button {
    //切换视图控制器
    self.selectedIndex = button.tag;
    //动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.2];
    [UIView commitAnimations];
}

- (BOOL)shouldAutorotate
{
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [self.selectedViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

@end
