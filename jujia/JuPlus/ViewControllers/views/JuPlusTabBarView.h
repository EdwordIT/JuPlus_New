//
//  JuPlusTabBarView.h
//  JuPlus
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 居+. All rights reserved.
//自定义tabBar，实现不同界面之间切换效果

#import "JuPlusUIView.h"
typedef enum{
    ShowCollocation = 1,  //显示套餐列表
    ShowPerson , //显示个人中心
    GoToCarma,
} TabBarTag;

@protocol TabBarViewDelegate <NSObject>

-(void)changeTo:(UIButton *)sender;

@end

@interface JuPlusTabBarView : JuPlusUIView
@property(nonatomic,assign)id<TabBarViewDelegate>delegate;

@property(nonatomic,strong)UIButton *selectedBtn;
//个人
@property(nonatomic,strong)UIButton *personBtn;

@property(nonatomic,strong)UIButton *collocationBtn;

@property(nonatomic,strong)    UIButton *logoBtn;

@property(nonatomic,strong)NSMutableArray *buttonArr;

-(void)resetButtonArray;
@end
