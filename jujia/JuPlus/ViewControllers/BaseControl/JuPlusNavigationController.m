//
//  JuPlusNavigationController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusNavigationController.h"

#import "JuPlusEnvironmentConfig.h"

@implementation JuPlusNavigationController
-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if(self)
    {
        self.navigationItem.titleView = self.titleLabel;
    }
    return self;
}

//标题
-(UILabel *)titleLabel
{
    CGFloat titleWidth = 120.0f;
    if(!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH)/2, 0.0f, titleWidth, 44.0f)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
    
}

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [self.topViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

@end
