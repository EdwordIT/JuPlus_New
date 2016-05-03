//
//  OrderListDTO.h
//  JuPlus
//
//  Created by admin on 15/7/9.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "BaseDTO.h"

@interface OrderListDTO : BaseDTO
@property(nonatomic,strong)NSString *orderNo;

@property(nonatomic,strong)NSString *orderTime;

@property(nonatomic,assign)int totalCount;

@property(nonatomic,strong)NSString *totalPrice;

@property(nonatomic,strong)NSMutableArray *productArray;
//订单描述
@property(nonatomic,strong)NSString *statusTxt;
//订单状态
@property(nonatomic,strong)NSString *status;

@end
