//
//  OrderDetailViewController.h
//  JuPlus
//
//  Created by admin on 15/7/9.
//  Copyright (c) 2015年 居+. All rights reserved.
//订单详情

#import "JuPlusUIViewController.h"

@interface OrderDetailViewController : JuPlusUIViewController
//订单号
@property(nonatomic,strong)NSString *orderNo;

@property(nonatomic,assign)BOOL isFromPlaceOrder;
@end
