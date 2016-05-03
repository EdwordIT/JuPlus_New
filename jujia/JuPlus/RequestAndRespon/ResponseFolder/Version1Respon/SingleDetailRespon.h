//
//  SingleDetailRespon.h
//  JuPlus
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"

@interface SingleDetailRespon : JuPlusResponse
//单品展示图层数组
@property(nonatomic,strong)NSArray *imageArray;
//单品描述H5文字段
@property(nonatomic,strong)NSString *htmlString;
//主要成分对应的图层数组展示
@property(nonatomic,strong)NSArray *basisArray;
//单品编号
@property(nonatomic,strong)NSString *regNo;
//单品名称
@property(nonatomic,strong)NSString *proName;
//价格
@property(nonatomic,strong)NSString *price;
//是否收藏过
@property(nonatomic,strong)NSString *isFav;

@property(nonatomic,strong)NSString *status;
//相关效果图
@property(nonatomic,strong)NSArray *packageList;
@end
