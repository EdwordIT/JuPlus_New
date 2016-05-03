//
//  SingleDetialViewController.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//单品详情界面

#import "JuPlusUIViewController.h"
#import "RTLabel.h"
#import "PriceView.h"
#import "ImageScrollView.h"
@interface SingleDetialViewController : JuPlusUIViewController<UIScrollViewDelegate>
//单品对应id值
@property (nonatomic,strong)NSString *singleId;
//从套餐过来
@property (nonatomic,assign)BOOL isfromPackage;
//该单品对应的套餐(即从哪个套餐过来的)
@property (nonatomic,strong)NSString *regNo;
//招商中
@property (nonatomic,strong)UIImageView *attractivedImg;
@property (nonatomic,strong)ImageScrollView *topView;
@property (nonatomic,strong)UIScrollView *backScroll;
//用于展示交互效果的下层图片
@property (nonatomic,strong)JuPlusUIView *bottomV;
//描述
@property (nonatomic,strong)RTLabel *descripLabel;
//主要成分
@property(nonatomic,strong)JuPlusUIView *basisView;
//主要成分数量
@property(nonatomic,strong)UILabel *basisLabel;
//主要成分图片列表
@property (nonatomic,strong)UIScrollView *basisScroll;
//购买单品
@property (nonatomic,strong)UIButton *placeOrderBtn;

@property (nonatomic,strong)UIScrollView *imageScroll;
//需要返回的上个界面中心坐标
@property (nonatomic,assign)CGPoint point;
@property (nonatomic,strong)UILabel *titleL;
//猜你喜欢
@property (nonatomic,strong)JuPlusUIView *relativedView;


@end
