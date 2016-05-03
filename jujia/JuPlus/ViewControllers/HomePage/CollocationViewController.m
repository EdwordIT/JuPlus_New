//
//  CollocationViewController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "CollocationViewController.h"
#import "ClassifyView.h"
@implementation CollocationViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"搭配";

    UIImageView *back = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, nav_height, self.view.width, self.view.height)];
    [back setImage:[UIImage imageNamed:@"2.jpg"]];
    [self.view addSubview:back];
    
    ClassifyView *class = [[ClassifyView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, SCREEN_HEIGHT - nav_height)];
    [self.view addSubview:class];

   // [self.view setVisualEffect];
   // [self.view removeVisualEffect];
}

@end
