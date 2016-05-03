//
//  MapCollocationDTO.h
//  JuPlus
//
//  Created by admin on 15/8/27.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "BaseDTO.h"

@interface MapCollocationDTO : BaseDTO
//经纬度
@property (nonatomic,strong)NSString *lon;
@property (nonatomic,strong)NSString *lat;
//名称
@property (nonatomic,strong)NSString *name;
//用户注册号
@property (nonatomic,strong)NSString *regNo;

@end
