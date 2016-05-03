//
//  OrderListRespon.h
//  JuPlus
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"
#import "productOrderDTO.h"
@interface OrderListRespon : JuPlusResponse
@property(nonatomic,strong)NSMutableArray *orderListArray;

@property(nonatomic,strong)NSString *totalCount;
@end
