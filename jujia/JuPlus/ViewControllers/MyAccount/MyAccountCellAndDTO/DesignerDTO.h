//
//  DesignerDTO.h
//  JuPlus
//
//  Created by ios_admin on 15/8/25.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "BaseDTO.h"

@interface DesignerDTO : BaseDTO

//注册号
@property (nonatomic, strong) NSString *regNo;
//效果图
@property (nonatomic, strong) NSString *coverUrl;
//介绍
@property (nonatomic, strong) NSString * simpleExplain;
//价格
@property (nonatomic, strong) NSString *totalPrice;

@end
