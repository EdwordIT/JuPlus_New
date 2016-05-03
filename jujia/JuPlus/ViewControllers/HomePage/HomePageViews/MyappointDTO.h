//
//  MyappointDTO.h
//  JuPlus
//
//  Created by ios_admin on 15/9/2.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "BaseDTO.h"

@interface MyappointDTO : BaseDTO

//注册号
@property (nonatomic, strong)NSString *regNo;
//预约状态
@property (nonatomic, strong)NSString *status;
//图片
@property (nonatomic, strong)NSString *imgUrl;
//创建日期
@property (nonatomic, strong)NSString *createTime;
//预约类型
@property (nonatomic, strong)NSString *type;
//设计师或者效果图id
@property (nonatomic,strong)NSString *objNo;
@end
