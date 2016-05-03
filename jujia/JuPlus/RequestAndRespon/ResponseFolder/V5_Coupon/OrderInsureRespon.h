//
//  OrderInsureRespon.h
//  JuPlus
//
//  Created by admin on 15/10/27.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"
#import "CouponItem.h"
@interface OrderInsureRespon : JuPlusResponse
@property (nonatomic,strong)NSMutableArray *listArray;

@property (nonatomic,strong)NSString * totalAmt;

@end
