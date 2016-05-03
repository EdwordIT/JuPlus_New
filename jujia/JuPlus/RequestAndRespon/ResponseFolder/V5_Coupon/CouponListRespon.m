//
//  CouponListRespon.m
//  JuPlus
//
//  Created by admin on 15/10/20.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "CouponListRespon.h"

@implementation CouponListRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.listArray = [[NSMutableArray alloc]init];
    self.count = [EncodeStringFromDic(dict, @"count") integerValue];
    NSArray *arr = [dict objectForKey:@"list"];
    for (NSDictionary *dic in arr) {
        CouponItem *item = [[CouponItem alloc]init];
        [item loadDTO:dic];
        [self.listArray addObject:item];
    }
}
@end
