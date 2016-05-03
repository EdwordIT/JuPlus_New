//
//  LabelDTO.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//标签详情

#import "BaseDTO.h"
@interface LabelDTO : BaseDTO
//单品类型
@property (nonatomic,strong)NSString *productName;
//单品对应id
@property (nonatomic,strong)NSString *productNo;
//距离左边距距离
@property (nonatomic,assign)float locX;
//距离上边距距离
@property (nonatomic,assign)float locY;
//朝向
@property (nonatomic,strong)NSString *direction;

@property (nonatomic,strong)NSString *coverUrl;

@property (nonatomic,strong)NSString *price;

@end
