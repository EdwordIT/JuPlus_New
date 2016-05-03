//
//  CountView.h
//  JuPlus
//
//  Created by admin on 15/7/3.
//  Copyright (c) 2015年 居+. All rights reserved.
//计数器

#import "JuPlusUIView.h"

@interface CountView : JuPlusUIView
-(id)initWithFrame:(CGRect)frame;
//背景
@property(nonatomic,strong)UIImageView *backImg;
//减
@property(nonatomic,strong)UIButton *subtractBtn;
//加
@property(nonatomic,strong)UIButton *addBtn;
//计数器
@property(nonatomic,strong)UILabel *countL;
//得到最终值
-(int )getCountNum;
//初始化的时候必须调用此方法设定初始值
//设定初始值
-(void)setCountNum:(int)count;

@end
