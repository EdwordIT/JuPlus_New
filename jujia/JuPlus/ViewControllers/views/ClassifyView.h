//
//  ClassifyView.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/18.
//  Copyright (c) 2015年 居+. All rights reserved.
//兴趣分类，放在引导页的位置，用于存储用户的兴趣方向

#import <UIKit/UIKit.h>
#import "JuPlusUIView.h"
#import "UIImage+GIF.h"
#import "ClassifyTagsDTO.h"


@interface ClassifyView :JuPlusUIView <UIScrollViewDelegate>

@property (nonatomic,strong)UILabel *titleL;
//可扩展的类容分布
@property (nonatomic,strong)UIScrollView *itemsScroll;
//数据源
@property (nonatomic,strong)NSMutableArray *dataArray;
//底层确定按钮
@property (nonatomic,strong)UIButton *sureBtn;
//被选中的标签数组
@property (nonatomic,strong)NSMutableArray *selectArr;

@property (nonatomic,strong)ClassifyTagsDTO *infoDTO;

-(id)initWithFrame:(CGRect)frame andView:(UIView *)superV;

-(void)showClassify;
@end
