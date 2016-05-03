//
//  OrderInsureRespon.m
//  JuPlus
//
//  Created by admin on 15/10/27.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "OrderInsureRespon.h"

@implementation OrderInsureRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.listArray = [[NSMutableArray alloc]init];
    self.totalAmt = EncodeStringFromDic(dict, @"totalAmt");
    NSArray *arr = [dict objectForKey:@"couponDetailList"];
    for (NSDictionary *dic in arr) {
        CouponItem *item = [[CouponItem alloc]init];
        [item loadDTO:dic];
        [self.listArray addObject:item];
    }
}
@end
