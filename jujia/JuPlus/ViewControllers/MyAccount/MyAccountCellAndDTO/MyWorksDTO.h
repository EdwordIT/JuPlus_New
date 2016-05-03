//
//  MyWorksDTO.h
//  JuPlus
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "BaseDTO.h"
@interface MyWorksDTO : BaseDTO
//审核进度
@property (nonatomic,strong)NSString *status;
//被赞次数
@property (nonatomic,strong)NSString *favCount;
//购买次数
@property (nonatomic,strong)NSString *payCount;
//发布时间
@property (nonatomic,strong)NSString *uploadTime;
//作品号
@property (nonatomic,strong)NSString *regNo;

@property (nonatomic,strong)NSString *coverUrl;
@end
