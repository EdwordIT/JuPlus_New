//
//  productView.h
//  JuPlus
//
//  Created by admin on 15/7/3.
//  Copyright (c) 2015年 居+. All rights reserved.
//单品下单页面

#import "JuPlusUIView.h"
#import "JuPlusUILabel.h"
#import "CountView.h"
#import "productOrderDTO.h"
@interface productView : JuPlusUIView
//图标
@property(nonatomic,strong)UIImageView *iconImgV;
//标题
@property(nonatomic,strong)JuPlusUILabel *titleL;
//价格
@property(nonatomic,strong)JuPlusUILabel *priceL;
//增删器
@property(nonatomic,strong)CountView *countV;
//发货状态
@property(nonatomic,strong)UILabel *typeLabel;

-(void)loadData:(productOrderDTO *)dto;
@end
