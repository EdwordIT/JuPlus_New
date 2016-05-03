//
//  LoginViewController.h
//  JuPlus
//
//  Created by admin on 15/6/23.
//  Copyright (c) 2015年 居+. All rights reserved.
//登陆界面

#import <UIKit/UIKit.h>
#import "JuPlusUIViewController.h"
#import "KeyBoardTopBar.h"
@interface LoginViewController :JuPlusUIViewController<keyBoardTopBarDelegate>
{
    KeyBoardTopBar *keyboardTopBar;
    //界面向上弹出的高度
    int movementDistance;

}
@property(nonatomic,strong)UIImageView *iconImg;
//登陆
@property (nonatomic,strong)UIButton *loginBtn;
//快速注册
@property (nonatomic,strong)UIButton *registerBtn;
//忘记密码
@property (nonatomic,strong)UIButton *forgetBtn;
@property (nonatomic,strong)NSMutableArray *fieldArray;
@end
