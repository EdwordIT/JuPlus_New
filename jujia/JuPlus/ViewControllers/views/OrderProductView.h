//
//  OrderProductView.h
//  JuPlus
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUIView.h"
#import "productOrderDTO.h"
@interface OrderProductView : JuPlusUIView
//图标
@property(nonatomic,strong)UIImageView *iconImgV;
//标题
@property(nonatomic,strong)JuPlusUILabel *titleL;
//价格
@property(nonatomic,strong)JuPlusUILabel *priceL;
//数量
@property(nonatomic,strong)JuPlusUILabel *countL;

-(void)loadData:(productOrderDTO *)dto;

@end
